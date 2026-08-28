from __future__ import annotations
import argparse, base64, json, socket, sys
from pathlib import Path
import numpy as np
import soundfile as sf

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--model-root", required=True, type=Path)
    args=parser.parse_args()
    root=args.model_root
    old=socket.socket.connect
    socket.socket.connect=lambda self, address: (_ for _ in ()).throw(RuntimeError("network disabled"))
    try:
        from funasr.bin.sv_infer import Speech2Xvector
        runtime=Speech2Xvector(sv_train_config=str(root/"sv.yaml"), sv_model_file=str(root/"sv.pth"), device="cpu", dtype="float32", embedding_node="resnet1_dense")
        request=json.load(sys.stdin)
        if request.get("op")=="health":
            print(json.dumps({"ready": True})); return
        pcm=base64.b64decode(request["pcm_b64"], validate=True)
        audio=np.frombuffer(pcm, dtype="<i2").astype("float32") / 32768.0
        vector=runtime.calculate_embedding(audio).squeeze(0).cpu().numpy().tolist()
        print(json.dumps({"spk_embedding": vector}))
    finally:
        socket.socket.connect=old
if __name__=="__main__": main()
