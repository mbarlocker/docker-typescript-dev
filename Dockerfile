FROM ubuntu:22.04

ENV TZ="UTC"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y ca-certificates curl rsync \
    && rm -rf /var/lib/apt/lists/ \
    && groupadd app \
    && useradd --gid app --shell /bin/bash --create-home app \
    && curl -o /opt/install.sh "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh" \
    && chmod +x /opt/install.sh \
    && su -g app app -l /opt/install.sh \
    && grep NVM_DIR /home/app/.bashrc > /home/app/.bashnvm \
    && chown app:app /home/app/.bashnvm \
    && rm -f /opt/install.sh

RUN mkdir /app
WORKDIR /app
VOLUME ["/app", "/home/app/.aws"]

COPY entry.sh /
COPY entry-app.sh /

ENTRYPOINT ["/entry.sh"]
