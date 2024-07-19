# Docker Typescript Dev

[![Docker Image Publish](https://github.com/mbarlocker/docker-typescript-dev/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/mbarlocker/docker-typescript-dev/actions/workflows/docker-publish.yml)

## Contents

This repo builds a Docker container. The purpose of this container is to develop on a local machine with Node.

One thing that makes this container special is that it takes care to preserve ownership and permissions
between the host and the container. If you're developing as myuser (uid 1000 gid 1000), the container
will use the same uid and gid. This means no weird ownership or permission issues.

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
      - ./start.sh:/entry-app.sh
      - $HOME/.aws:/home/app/.aws
```

## Docker Hub

Find the docker image on Docker Hub: [Docker Typescript Dev](https://hub.docker.com/r/mbarlocker/docker-typescript-dev)

![Image pushed to Docker Hub](https://raw.githubusercontent.com/mbarlocker/docker-typescript-dev/main/images/image-pushed-to-docker-hub.png)

## License

[MIT](https://choosealicense.com/licenses/mit/)
