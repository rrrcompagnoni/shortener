# Shortener

## Installation

### Requirements

1. Docker version >= 20.10.18 [Install Docker](https://docs.docker.com/engine/install/).
2. docker-compose version >= 1.29.2 [Install Docker Compose](https://https://docs.docker.com/compose/install/).

### Build and DB creation

This step is a precontidion to the commands following it.

From your terminal console run:

```shell=
docker-compose build
```

```shell=
docker-compose run shortener mix setup
```

### Running tests

From your terminal console run:

```shell=
docker-compose run shortener mix test
```

### Up and running the Web Server

From your terminal console run:

```shell=
docker-compose up
```

### Documents

[Development notes](docs/notes.txt)

#### Use cases

- [Alias Creation](docs/use_cases/alias_creation.md)
- [Alias Redirection](docs/use_cases/alias_redirection.md)
