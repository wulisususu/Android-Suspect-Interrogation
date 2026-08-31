#!/usr/bin/env bash
set -euo pipefail

PROBE_ID="${PROBE_ID:-${GITHUB_RUN_ID:-manual}}"
sudo -n true

tmp="$(mktemp -d)"
pids=()
cleanup() {
  for pid in "${pids[@]:-}"; do
    kill "$pid" 2>/dev/null || true
  done
  rm -rf "$tmp"
}
trap cleanup EXIT

exec_line="$(systemctl show frpc.service --property=ExecStart --value 2>/dev/null || true)"
config="$(grep -oE '/[^ ;{}]+\.(toml|ini)' <<<"$exec_line" | head -n 1 || true)"
if [[ -z "$config" || ! -f "$config" ]]; then
  for root in /etc /opt /usr/local/etc /home; do
    [[ -d "$root" ]] || continue
    config="$(sudo -n find "$root" -maxdepth 5 -type f \( -name 'frpc.toml' -o -name 'frpc.ini' \) -print -quit 2>/dev/null || true)"
    [[ -n "$config" ]] && break
  done
fi
[[ -n "$config" && -f "$config" ]] || { echo 'probe_config_found=false'; exit 1; }

sudo -n python3 - "$config" "$tmp" "$PROBE_ID" <<'PY'
import configparser
import ipaddress
import pathlib
import re
import sys

source = pathlib.Path(sys.argv[1])
outdir = pathlib.Path(sys.argv[2])
probe_id = re.sub(r'[^A-Za-z0-9_-]', '', sys.argv[3])[:32]
text = source.read_text(encoding='utf-8', errors='replace')
server = ''
if source.suffix.lower() == '.toml':
    match = re.search(r'^\s*serverAddr\s*=\s*["\']([^"\']+)["\']', text, flags=re.MULTILINE)
    server = match.group(1).strip() if match else ''
    base = re.split(r'^\s*\[\[proxies\]\]\s*$', text, maxsplit=1, flags=re.MULTILINE)[0].rstrip() + '\n'
    target = outdir / 'probe.toml'
else:
    parser = configparser.ConfigParser(interpolation=None)
    parser.read_string(text)
    server = parser.get('common', 'server_addr', fallback='').strip()
    common = configparser.ConfigParser(interpolation=None)
    common['common'] = dict(parser['common'])
    target = outdir / 'probe.ini'
    with target.open('w', encoding='utf-8') as fh:
        common.write(fh)
    base = target.read_text(encoding='utf-8')

try:
    address = ipaddress.ip_address(server)
except ValueError:
    print('probe_server_is_ipv4=false')
    raise SystemExit(2)
if address.version != 4:
    print('probe_server_is_ipv4=false')
    raise SystemExit(2)
print('probe_server_is_ipv4=true')
host = f"suspect-{probe_id}.{str(address).replace('.', '-')}.sslip.io"
(outdir / 'endpoint').write_text(server + '\n' + host + '\n', encoding='utf-8')

if source.suffix.lower() == '.toml':
    extra = f'''\n[[proxies]]
name = "suspect-http-probe-{probe_id}"
type = "http"
localIP = "127.0.0.1"
localPort = 18081
customDomains = ["{host}"]

[[proxies]]
name = "suspect-https-probe-{probe_id}"
type = "https"
localIP = "127.0.0.1"
localPort = 18443
customDomains = ["{host}"]
'''
    target.write_text(base + extra, encoding='utf-8')
else:
    with target.open('a', encoding='utf-8') as fh:
        fh.write(f'''\n[suspect-http-probe-{probe_id}]
type = http
local_ip = 127.0.0.1
local_port = 18081
custom_domains = {host}

[suspect-https-probe-{probe_id}]
type = https
local_ip = 127.0.0.1
local_port = 18443
custom_domains = {host}
''')
target.chmod(0o600)
PY

mapfile -t endpoint < "$tmp/endpoint"
server="${endpoint[0]}"
host="${endpoint[1]}"
probe_config="$tmp/probe.${config##*.}"

mkdir -p "$tmp/www"
printf 'suspect-vhost-probe\n' > "$tmp/www/index.html"
python3 -m http.server 18081 --bind 127.0.0.1 --directory "$tmp/www" >"$tmp/http.log" 2>&1 &
pids+=("$!")

openssl req -x509 -newkey rsa:2048 -nodes -days 1 \
  -subj '/CN=frp-vhost-probe' \
  -keyout "$tmp/probe.key" -out "$tmp/probe.crt" >/dev/null 2>&1
python3 - "$tmp" <<'PY' >"$tmp/https.log" 2>&1 &
import http.server
import ssl
import sys
root = sys.argv[1]
handler = lambda *a, **kw: http.server.SimpleHTTPRequestHandler(*a, directory=root + '/www', **kw)
server = http.server.ThreadingHTTPServer(('127.0.0.1', 18443), handler)
context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain(root + '/probe.crt', root + '/probe.key')
server.socket = context.wrap_socket(server.socket, server_side=True)
server.serve_forever()
PY
pids+=("$!")

frpc -c "$probe_config" >"$tmp/frpc.log" 2>&1 &
frpc_pid="$!"
pids+=("$frpc_pid")
sleep 4
if ! kill -0 "$frpc_pid" 2>/dev/null; then
  echo 'temporary_frpc_started=false'
  echo 'frp_http_vhost_supported=false'
  echo 'frp_https_vhost_supported=false'
  exit 0
fi
echo 'temporary_frpc_started=true'

http_ok=false
https_ok=false
for _ in $(seq 1 8); do
  body="$(curl -fsS --max-time 4 --resolve "$host:80:$server" "http://$host/" 2>/dev/null || true)"
  if grep -q 'suspect-vhost-probe' <<<"$body"; then
    http_ok=true
    break
  fi
  sleep 1
done
for _ in $(seq 1 8); do
  body="$(curl -kfsS --max-time 4 --resolve "$host:443:$server" "https://$host/" 2>/dev/null || true)"
  if grep -q 'suspect-vhost-probe' <<<"$body"; then
    https_ok=true
    break
  fi
  sleep 1
done

echo "frp_http_vhost_supported=$http_ok"
echo "frp_https_vhost_supported=$https_ok"
