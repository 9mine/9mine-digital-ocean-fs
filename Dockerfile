FROM 9mine/9p-execfuse-jinja2:master
RUN curl -L https://github.com/digitalocean/doctl/releases/download/v1.54.0/doctl-1.54.0-linux-amd64.tar.gz | tar -xzf - -C /usr/bin \
    && chmod a+x /usr/bin/doctl
