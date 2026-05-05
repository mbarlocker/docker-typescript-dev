FROM mbarlocker/docker-dev:v0.0.3

ARG NVM_VERSION=v0.40.4

RUN curl -o /opt/install-nvm.sh "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" \
    && chmod +x /opt/install-nvm.sh \
    && su -g app app -l /opt/install-nvm.sh \
    && grep NVM_DIR /home/app/.bashrc > /home/app/.bashnvm \
    && chown app:app /home/app/.bashnvm
