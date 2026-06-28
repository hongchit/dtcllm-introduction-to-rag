#!/usr/bin/env bash
set -euo pipefail

# Shared cache ownership setup.
sudo chown -R vscode:vscode \
  /home/vscode/.cache/uv \
  /home/vscode/.cache/huggingface \
  /home/vscode/.cache/torch

# Root project environment and Jupyter kernel setup.
uv sync --frozen

.venv/bin/python -m ipykernel install --user \
  --name dtcllm-introduction-to-rag \
  --display-name "Python (.venv)"

# ONNX sub-project environment and Jupyter kernel setup.
(
  cd onnx
  uv sync --frozen --dev
  .venv/bin/python -m ipykernel install --user \
    --name dtcllm-onnx \
    --display-name "Python (onnx/.venv)"
)
