FROM mbarlocker/docker-dev:latest

RUN curl -o /opt/install-nvm.sh "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh" \
    && chmod +x /opt/install-nvm.sh \
    && su -g app app -l /opt/install-nvm.sh \
    && grep NVM_DIR /home/app/.bashrc > /home/app/.bashnvm \
    && chown app:app /home/app/.bashnvm
