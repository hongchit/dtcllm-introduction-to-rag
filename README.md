# DTCLLM Introduction to RAG

This repository contains local notebooks and helper code for working through the
introductory Retrieval-Augmented Generation (RAG) material from
[DataTalksClub LLM Zoomcamp](https://github.com/DataTalksClub/llm-zoomcamp).

The project focuses on building small, inspectable RAG examples with Python:

- loading course FAQ and lesson content
- indexing documents with keyword and vector search
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
- `vector_search_pgvector.ipynb` - pgvector/PostgreSQL vector search notebook
- `ingest.py` - helper functions for loading FAQ data and building an index
- `rag_helper.py` - RAG helper for FAQ-style documents
- `rag_helper2.py` - RAG helper for lesson-style documents
- `faq.db` - local SQLite search database generated during experiments

## Requirements

- Python 3.13
- [`uv`](https://docs.astral.sh/uv/) for dependency management
- Jupyter or VS Code with the Jupyter extension
- Docker Desktop for the DevContainer and the pgvector PostgreSQL service
- An OpenAI-compatible API key for notebooks that call an LLM

## Environment Files

This project uses two local env files. Both are ignored by git; the committed
`.env.example` files are safe templates.

1. Create the root app/notebook env file:

```bash
cp .env.example .env
```

Use this file for API/application secrets such as:

```text
OPENAI_API_KEY
EDGAR_IDENTITY
HF_TOKEN
```

2. Create the DevContainer/PostgreSQL env file:

```bash
cp .devcontainer/.env.example .devcontainer/.env
```

Use this file for the local pgvector database settings:

```text
PGVECTOR_DATABASE
PGVECTOR_USER
PGVECTOR_PASSWORD
```

## Setup With DevContainer

The recommended reproducible setup is the included DevContainer. VS Code uses
Docker Compose to start two services:

- `app` - the Python 3.13 development container where VS Code attaches
- `pgvector` - PostgreSQL with the pgvector extension for vector search tests

1. Install Docker Desktop.
2. Install VS Code with the Dev Containers extension.
3. Create both env files from the examples:

```bash
cp .env.example .env
cp .devcontainer/.env.example .devcontainer/.env
```

4. Open this repository in VS Code.
5. Run `Dev Containers: Reopen in Container`.
6. Wait for the `postCreateCommand` to finish.

The DevContainer runs:

```bash
uv sync --frozen
.venv/bin/python -m ipykernel install --user --name dtcllm-introduction-to-rag --display-name "Python (.venv)"
```

After setup, open a notebook and select the `Python (.venv)` kernel.
Inside the DevContainer, pgvector notebooks should use:

```text
PGVECTOR_CONNECTION_STRING
```

That connection string points to the Compose service hostname `pgvector`.

More detail: [DevContainer and Docker structure](docs/devcontainer-docker.md).

## Setup Without DevContainer

You can run Python locally and still use the project PostgreSQL service through
Docker Compose.

1. Install Python 3.13. With `pyenv`:

```bash
pyenv install 3.13.14
pyenv local 3.13.14
```

2. Install `uv` if needed:

```bash
brew install uv
```

3. Create the root env file:

```bash
cp .env.example .env
```

4. Recreate and sync the virtual environment:

```bash
uv sync --frozen
```

5. Register the Jupyter kernel:

```bash
.venv/bin/python -m ipykernel install --user --name dtcllm-introduction-to-rag --display-name "Python (.venv)"
```

6. Start Jupyter:

```bash
.venv/bin/jupyter notebook
```

To run only the pgvector PostgreSQL service without opening the DevContainer,
also create `.devcontainer/.env` and start the service:

```bash
cp .devcontainer/.env.example .devcontainer/.env
docker compose -f .devcontainer/docker-compose.yml up pgvector
```

When Python runs on your host machine, connect to PostgreSQL through the
published localhost port:

```text
127.0.0.1:5432
```

When Python runs inside the DevContainer or Compose network, connect through the
service hostname:

```text
pgvector:5432
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

## Docker Volumes And Cleanup

The Docker setup creates one project-specific PostgreSQL volume and three shared
cache volumes:

- `dtcllm-rag_pgvector_data` - PostgreSQL/pgvector data for this project
- `devcontainer-uv-cache` - shared `uv` package cache
- `devcontainer-huggingface-cache` - shared Hugging Face cache
- `devcontainer-torch-cache` - shared Torch cache

Remove the pgvector data volume when you want to reset the local database. Remove
the shared cache volumes only when you want to reclaim disk space or force fresh
downloads across projects.

Cleanup commands and details: [Docker cleanup](docs/docker-cleanup.md).

## Notes

- Use the DevContainer when you want the most reproducible environment.
- Use the local setup when you want to run directly on your host machine.
- If `.venv/bin/python` is a broken symlink, delete and recreate `.venv` with
  `uv sync --frozen`.
- Keep generated files such as notebook outputs and local databases under review
  before committing.
