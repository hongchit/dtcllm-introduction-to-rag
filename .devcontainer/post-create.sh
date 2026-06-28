#!/usr/bin/env bash
set -euo pipefail

sudo chown -R vscode:vscode \
  /home/vscode/.cache/uv \
  /home/vscode/.cache/huggingface \
  /home/vscode/.cache/torch

uv sync --frozen

.venv/bin/python -m ipykernel install --user \
  --name dtcllm-introduction-to-rag \
  --display-name "Python (.venv)"
