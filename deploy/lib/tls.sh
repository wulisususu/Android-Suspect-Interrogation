#!/usr/bin/env bash
set -euo pipefail

SUSPECT_TLS_DIR="${SUSPECT_TLS_DIR:-${SUSPECT_ETC_DIR:-/etc/suspect-interrogation}/tls}"
SUSPECT_TLS_LAN_IP="${SUSPECT_TLS_LAN_IP:-192.168.0.9}"
SUSPECT_TLS_CA_FILE="${SUSPECT_TLS_CA_FILE:-${SUSPECT_TLS_DIR}/ca.crt}"
SUSPECT_TLS_CA_KEY_FILE="${SUSPECT_TLS_CA_KEY_FILE:-${SUSPECT_TLS_DIR}/ca.key}"
SUSPECT_TLS_CERT_FILE="${SUSPECT_TLS_CERT_FILE:-${SUSPECT_TLS_DIR}/server.crt}"
SUSPECT_TLS_KEY_FILE="${SUSPECT_TLS_KEY_FILE:-${SUSPECT_TLS_DIR}/server.key}"
SUSPECT_TLS_CA_DAYS="${SUSPECT_TLS_CA_DAYS:-365}"
SUSPECT_TLS_CERT_DAYS="${SUSPECT_TLS_CERT_DAYS:-90}"
SUSPECT_TLS_RENEW_BEFORE_DAYS="${SUSPECT_TLS_RENEW_BEFORE_DAYS:-30}"

_tls_require_openssl() {
  command -v openssl >/dev/null 2>&1 || {
    printf 'openssl is required for LAN TLS\n' >&2
    return 1
  }
}

_tls_ca_valid() {
  [[ -s "$SUSPECT_TLS_CA_FILE" && -s "$SUSPECT_TLS_CA_KEY_FILE" ]] || return 1
  openssl x509 -in "$SUSPECT_TLS_CA_FILE" -noout >/dev/null 2>&1 || return 1
  openssl pkey -in "$SUSPECT_TLS_CA_KEY_FILE" -noout >/dev/null 2>&1 || return 1
  openssl x509 -checkend 86400 -noout -in "$SUSPECT_TLS_CA_FILE" >/dev/null 2>&1 || return 1
}

_tls_leaf_valid() {
  [[ -s "$SUSPECT_TLS_CERT_FILE" && -s "$SUSPECT_TLS_KEY_FILE" ]] || return 1
  openssl x509 -in "$SUSPECT_TLS_CERT_FILE" -noout >/dev/null 2>&1 || return 1
  openssl pkey -in "$SUSPECT_TLS_KEY_FILE" -noout >/dev/null 2>&1 || return 1
  local renew_seconds=$((SUSPECT_TLS_RENEW_BEFORE_DAYS * 86400))
  openssl x509 -checkend "$renew_seconds" -noout -in "$SUSPECT_TLS_CERT_FILE" >/dev/null 2>&1 || return 1
  openssl verify -CAfile "$SUSPECT_TLS_CA_FILE" "$SUSPECT_TLS_CERT_FILE" >/dev/null 2>&1 || return 1
  local sans
  sans="$(openssl x509 -in "$SUSPECT_TLS_CERT_FILE" -noout -ext subjectAltName 2>/dev/null || true)"
  grep -Fq "IP Address:${SUSPECT_TLS_LAN_IP}" <<<"$sans" || return 1
  grep -Fq "IP Address:127.0.0.1" <<<"$sans" || return 1
  grep -Fq "DNS:localhost" <<<"$sans" || return 1
}

_tls_generate_ca() {
  umask 077
  openssl genrsa -out "$SUSPECT_TLS_CA_KEY_FILE" 4096 >/dev/null 2>&1
  openssl req -x509 -new -sha256 \
    -key "$SUSPECT_TLS_CA_KEY_FILE" \
    -days "$SUSPECT_TLS_CA_DAYS" \
    -subj "/CN=Suspect Interrogation LAN Root CA/O=Suspect Interrogation" \
    -addext "basicConstraints=critical,CA:TRUE" \
    -addext "keyUsage=critical,keyCertSign,cRLSign" \
    -out "$SUSPECT_TLS_CA_FILE"
}

_tls_generate_leaf() {
  local csr config
  csr="$(mktemp "${SUSPECT_TLS_DIR}/server.XXXXXX.csr")"
  config="$(mktemp "${SUSPECT_TLS_DIR}/server.XXXXXX.cnf")"
  trap 'rm -f "$csr" "$config"' RETURN
  cat >"$config" <<EOF
[req]
prompt = no
distinguished_name = dn
req_extensions = req_ext

[dn]
CN = ${SUSPECT_TLS_LAN_IP}
O = Suspect Interrogation

[req_ext]
subjectAltName = @alt_names

[v3_server]
basicConstraints = critical,CA:FALSE
keyUsage = critical,digitalSignature,keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
IP.1 = ${SUSPECT_TLS_LAN_IP}
IP.2 = 127.0.0.1
DNS.1 = localhost
EOF
  umask 077
  openssl genrsa -out "$SUSPECT_TLS_KEY_FILE" 3072 >/dev/null 2>&1
  openssl req -new -sha256 \
    -key "$SUSPECT_TLS_KEY_FILE" \
    -config "$config" \
    -out "$csr"
  openssl x509 -req -sha256 \
    -in "$csr" \
    -CA "$SUSPECT_TLS_CA_FILE" \
    -CAkey "$SUSPECT_TLS_CA_KEY_FILE" \
    -CAcreateserial \
    -days "$SUSPECT_TLS_CERT_DAYS" \
    -extfile "$config" \
    -extensions v3_server \
    -out "$SUSPECT_TLS_CERT_FILE" >/dev/null 2>&1
  rm -f "${SUSPECT_TLS_CA_FILE%.crt}.srl" "$csr" "$config"
  trap - RETURN
}

ensure_tls_material() {
  _tls_require_openssl
  mkdir -p "$SUSPECT_TLS_DIR"
  chmod 0750 "$SUSPECT_TLS_DIR" 2>/dev/null || true

  if ! _tls_ca_valid; then
    rm -f "$SUSPECT_TLS_CA_FILE" "$SUSPECT_TLS_CA_KEY_FILE" "$SUSPECT_TLS_CERT_FILE" "$SUSPECT_TLS_KEY_FILE"
    _tls_generate_ca
  fi

  if ! _tls_leaf_valid; then
    rm -f "$SUSPECT_TLS_CERT_FILE" "$SUSPECT_TLS_KEY_FILE"
    _tls_generate_leaf
  fi

  chmod 0600 "$SUSPECT_TLS_CA_KEY_FILE" 2>/dev/null || true
  chmod 0644 "$SUSPECT_TLS_CA_FILE" "$SUSPECT_TLS_CERT_FILE" 2>/dev/null || true
  chmod 0640 "$SUSPECT_TLS_KEY_FILE" 2>/dev/null || true
  if [[ "${SUSPECT_DRY_RUN:-0}" != "1" ]]; then
    chown root:root "$SUSPECT_TLS_CA_KEY_FILE" "$SUSPECT_TLS_CA_FILE"
    chown root:"${SUSPECT_SERVICE_GROUP:-suspect-interrogation}" "$SUSPECT_TLS_KEY_FILE" "$SUSPECT_TLS_CERT_FILE"
  fi
}

install_tls_trust() {
  [[ "${SUSPECT_DRY_RUN:-0}" == "1" ]] && return 0
  local trust_target="/usr/local/share/ca-certificates/suspect-interrogation-ca.crt"
  local changed=0
  if [[ ! -f "$trust_target" ]] || ! cmp -s "$SUSPECT_TLS_CA_FILE" "$trust_target"; then
    install -o root -g root -m 0644 "$SUSPECT_TLS_CA_FILE" "$trust_target"
    changed=1
  fi
  if [[ "$changed" -eq 1 ]]; then
    command -v update-ca-certificates >/dev/null 2>&1 || {
      printf 'update-ca-certificates is required to trust the LAN CA\n' >&2
      return 1
    }
    update-ca-certificates >/dev/null
  fi
}

curl_tls() {
  curl --fail --silent --show-error --cacert "$SUSPECT_TLS_CA_FILE" "$@"
}
