# syntax=docker/dockerfile:1

# Setup git & wget and checkout
FROM ubuntu AS git
ARG CADDY_VERSION
ENV CADDY_VERSION=${CADDY_VERSION:-v2.4.6}
# updated this after reading more about efficient Dockerfiles at this link:  https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
RUN apt-get update && apt-get install -y \
    git \
    wget
RUN mkdir /app
WORKDIR /app/
RUN git clone --branch $CADDY_VERSION https://github.com/caddyserver/caddy.git /app/caddy

#Download and install go v1.17.8 for linux
FROM git AS go
WORKDIR /tmp/
RUN wget -o go.tgz https://go.dev/dl/go1.17.8.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.17.8.linux-amd64.tar.gz
# The export/source commands below are not currently working, using full path for go command until I figure it out
RUN export PATH=$PATH:/usr/local/go/bin
RUN . $HOME/.profile
RUN /usr/local/go/bin/go version

#Build Caddy using Go and json config file
FROM go AS build
WORKDIR /app/caddy/cmd/caddy
RUN /usr/local/go/bin/go build
 
#RUN Caddy 
FROM build AS run
WORKDIR /app/caddy/cmd/caddy/
COPY caddy.json /app/caddy/caddy.json
ENTRYPOINT ["/app/caddy/cmd/caddy/caddy" , "run", "-config", "/app/caddy/caddy.json"]