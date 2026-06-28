# Docker Cleanup

Use this guide when you want to stop containers, reset the local PostgreSQL
database, or reclaim cache space.

## Stop The Compose Services

From the project root:

```bash
docker compose -f .devcontainer/docker-compose.yml down
```

This stops and removes the project containers and network. It does not remove
Docker volumes.

## Reset Pgvector Data

The project PostgreSQL data is stored in:

```text
dtcllm-rag_pgvector_data
```

Remove it when you want a fresh local database:

```bash
docker compose -f .devcontainer/docker-compose.yml down
docker volume rm dtcllm-rag_pgvector_data
```

The next DevContainer or Compose start will recreate the volume and initialize a
new PostgreSQL database from `.devcontainer/.env`.

## Remove Shared Caches

The DevContainer uses shared cache volumes:

```text
devcontainer-uv-cache
devcontainer-huggingface-cache
devcontainer-torch-cache
```

These caches may be useful across projects. Remove them only when you want to
reclaim disk space or force fresh downloads:

```bash
docker volume rm devcontainer-uv-cache
docker volume rm devcontainer-huggingface-cache
docker volume rm devcontainer-torch-cache
```

## Remove All Project Docker State

To remove this project's containers, network, and PostgreSQL data while keeping
the shared caches:

```bash
docker compose -f .devcontainer/docker-compose.yml down
docker volume rm dtcllm-rag_pgvector_data
```

To also remove the shared caches, run the cache removal commands above.
