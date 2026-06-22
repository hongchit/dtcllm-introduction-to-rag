# DTCLLM Introduction to RAG

This repository contains local notebooks and helper code for working through the
introductory Retrieval-Augmented Generation (RAG) material from
[DataTalksClub LLM Zoomcamp](https://github.com/DataTalksClub/llm-zoomcamp).

The project focuses on building small, inspectable RAG examples with Python:

- loading course FAQ and lesson content
- indexing documents with keyword search
- building prompts from retrieved context
- calling OpenAI-compatible LLM APIs
- experimenting with notebooks for homework and local RAG behavior

## Course Acknowledgement

The learning material and examples in this repository are based on the
[DataTalksClub/llm-zoomcamp](https://github.com/DataTalksClub/llm-zoomcamp)
course. LLM Zoomcamp is a free, hands-on course about building practical LLM
applications, including RAG, agents, vector search, evaluation, monitoring, and
related production topics.

This repository is a personal/local working copy for the introduction-to-RAG
exercises and should be read alongside the upstream course materials.

## Repository Contents

- `homework-01.ipynb` - homework notebook for the introductory RAG work
- `test-openai-api.ipynb` - experiments with OpenAI API calls
- `test-rag.ipynb` - RAG pipeline experiments
- `sqlite-ingest.ipynb` - SQLite/search ingestion experiments
- `ingest.py` - helper functions for loading FAQ data and building an index
- `rag_helper.py` - RAG helper for FAQ-style documents
- `rag_helper2.py` - RAG helper for lesson-style documents
- `faq.db` - local SQLite search database generated during experiments

## Requirements

- Python 3.13
- [`uv`](https://docs.astral.sh/uv/) for dependency management
- Jupyter or VS Code with the Jupyter extension
- An OpenAI-compatible API key for notebooks that call an LLM

Create a local `.env` file for secrets:

```bash
OPENAI_API_KEY=your_api_key_here
```

The `.env` file is ignored by git.

## Setup With DevContainer

The recommended reproducible setup is the included DevContainer. It uses the
official Python 3.13 DevContainer image and installs `uv`.
The DevContainer also mounts a Docker-managed UV cache volume at
`/home/vscode/.cache/uv` so dependency downloads can be reused across container
rebuilds. This cache is disposable; remove the Docker volume when you no longer
need it or want a completely fresh dependency cache.

1. Install Docker.
2. Install VS Code with the Dev Containers extension.
3. Open this repository in VS Code.
4. Run `Dev Containers: Reopen in Container`.
5. Wait for the `postCreateCommand` to finish.

The DevContainer runs:

```bash
uv sync --frozen
.venv/bin/python -m ipykernel install --user --name dtcllm-introduction-to-rag --display-name "Python (.venv)"
```

After setup, open a notebook and select the `Python (.venv)` kernel.

To remove the UV cache volume after use:

```bash
docker volume rm devcontainer-uv-cache
```

## Setup Without DevContainer

The checked-in `.venv` may have been created inside the DevContainer and can
contain container-specific interpreter paths. If you are running locally, recreate
the virtual environment on your host machine.

1. Install Python 3.13. With `pyenv`:

```bash
pyenv install 3.13.14
pyenv local 3.13.14
```

2. Install `uv` if needed:

```bash
brew install uv
```

3. Recreate and sync the virtual environment:

```bash
uv sync --frozen
```

4. Register the Jupyter kernel:

```bash
.venv/bin/python -m ipykernel install --user --name dtcllm-introduction-to-rag --display-name "Python (.venv)"
```

5. Start Jupyter:

```bash
.venv/bin/jupyter notebook
```

If VS Code still points to a DevContainer path such as
`/workspaces/dtcllm-introduction-to-rag/.venv/bin/python`, select the local
interpreter manually:

```bash
./.venv/bin/python
```

## Running the Notebooks

Activate the environment or use the registered notebook kernel:

```bash
source .venv/bin/activate
```

Then open one of the notebooks:

```bash
jupyter notebook homework-01.ipynb
```

Some notebooks call external APIs and require `OPENAI_API_KEY` to be present in
`.env` or in the shell environment.

## Notes

- Use the DevContainer when you want the most reproducible environment.
- Use the local setup when you want to run directly on your host machine.
- If `.venv/bin/python` is a broken symlink, delete and recreate `.venv` with
  `uv sync --frozen`.
- Keep generated files such as notebook outputs and local databases under review
  before committing.
