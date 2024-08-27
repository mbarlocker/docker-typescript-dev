# Docker Typescript Dev

[![Docker Image Publish](https://github.com/mbarlocker/docker-typescript-dev/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/mbarlocker/docker-typescript-dev/actions/workflows/docker-publish.yml)

## Contents

This repo builds a Docker container. The purpose of this container is to develop on a local machine with Node.

Based on [Docker Dev](https://hub.docker.com/r/mbarlocker/docker-dev).

This image installs nvm, but will not run your app.

## Usage

First, to get the permissions to work, you have to update your `.bashrc` or equivalent. Add these lines to the bottom of that file.

```bash
export DOCKER_UID=$(id -u)
export DOCKER_GID=$(id -g)
```

Next, you'll need a script to actually run your program. Since this is a Node program, it's probably going to be something like the one below.
Just create this script in your repo, we'll reference it later in docker-compose.yaml.

```bash
#!/bin/bash

# this sets up NVM
source ~/.bashnvm
nvm -v

# go to your app
cd /app

# install and use node based on .nvmrc file
nvm install
nvm use
node -v

yarn install
exec yarn dev
```

Finally, use `docker` or `docker compose` to put everything in place. This `docker-compose.yaml` is placed in the root of your application.

```yaml
services:
  myapp:
    image: mbarlocker/docker-typescript-dev:latest
    environment:
      DOCKER_UID: "${DOCKER_UID}"
      DOCKER_GID: "${DOCKER_GID}"
    volumes:
      - .:/app
      - ./999-start:/startup/app/
      - $HOME/.aws:/home/app/.aws
```

## Docker Hub

Find the docker image on Docker Hub: [Docker Typescript Dev](https://hub.docker.com/r/mbarlocker/docker-typescript-dev)

![Image pushed to Docker Hub](https://raw.githubusercontent.com/mbarlocker/docker-typescript-dev/main/images/image-pushed-to-docker-hub.png)

## License

[MIT](https://choosealicense.com/licenses/mit/)
