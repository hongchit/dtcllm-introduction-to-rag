# DevContainer And Docker Structure

This project uses VS Code Dev Containers with Docker Compose. The setup keeps the
Python development environment and PostgreSQL database in separate containers.

## Files

- `.devcontainer/devcontainer.json` tells VS Code which Compose service to attach
  to and what to run after the container is created.
- `.devcontainer/docker-compose.yml` defines the Docker services, network,
  volumes, and pgvector environment loading.
- `.devcontainer/.env` provides local PostgreSQL settings and is ignored by git.
- `.devcontainer/.env.example` is the committed template for `.devcontainer/.env`.

## Compose Project

The Compose project name is:

```text
dtcllm-rag
```

That name is used as the namespace for project-specific Docker resources such as:

```text
dtcllm-rag_default
dtcllm-rag_pgvector_data
```

## Services

`app` is the DevContainer service. It uses the official Python 3.13 DevContainer
image and mounts the repository at:

```text
/workspaces/dtcllm-introduction-to-rag
```

The `app` service runs:

```yaml
command: sleep infinity
```

That keeps the container alive so VS Code can attach terminals, notebooks, and
language tooling.

`pgvector` is the PostgreSQL service. It uses:

```text
pgvector/pgvector:pg17
```

The database is available inside the Compose network at:

```text
pgvector:5432
```

It is also published to the host at:

```text
127.0.0.1:5432
```

## Network

Compose creates the default project network:

```text
dtcllm-rag_default
```

Containers on this network can reach each other by service name. That is why
notebooks inside the DevContainer use the hostname `pgvector`.

## Environment

The root `.env` file is for notebook/application secrets such as API keys.

The `.devcontainer/.env` file is for Docker/PostgreSQL settings:

```text
PGVECTOR_DATABASE
PGVECTOR_USER
PGVECTOR_PASSWORD
```

The Compose file builds `PGVECTOR_CONNECTION_STRING` from those values and makes
it available inside the `app` container.
