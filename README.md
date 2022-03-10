# Overview

Dockerfile is a multi-stage Docker file that will perform the following functions:

1. Create an ubuntu container, run apt update, then install git and wget.
2. Check out the most recent version of Caddy
3. Download and configure the most recent version (as of today) of Go
4. Use the "go build" command to build Caddy
5. Run caddy with a custom config JSON file on Docker port 8080 (port 2015 internally)

Dockerfile.light is a single step Docker file that uses the caddy docker image to run caddy with a Caddyfile.

# Usage for full build (Dockerfile)

1.  Clone this repository and change to the repo directory.
2.  Build the image using this docker command:  ```docker build -t caddy .```  By default, this command will use v2.4.6 of Caddy, but if a different version is preferred use this syntax:  ```docker build -t caddy --build-arg CADDY_VERSION=v#.#.# .```
3.  Run the image using this docker command:  ```docker run -p 8080:2015 -d --name caddy caddy```
4.  Note:  Please stop and delete this container if the light version is to be built/run since they both use port 8080.

# Usage for light build (Dockerfile.light)

1.  Clone this repository and change to the repo directory.
2.  Build the image using this docker command:  ```docker build -f Dockerfile.light -t lightcaddy .```  By default, this command will use v2.4.6 of Caddy, but if a different version is preferred use this syntax:  ```docker build -t lightcaddy --build-arg CADDY_VERSION=#.#.# .```
3.  Run the image using this docker command:  ```docker run -p 8080:2015 -d --name lightcaddy lightcaddy```
4.  Note:  Please stop and delete this container if the full version is to be built/run since they both use port 8080.

# Test

1.  Verify the server is responding via this curl command:  ```curl localhost:8080```

# Links

Caddy:  https://github.com/caddyserver/caddy

Caddy Getting Started:  https://caddyserver.com/docs/getting-started

Caddy Docker builds:  https://hub.docker.com/_/caddy?tab=tags

Go:   https://go.dev/dl/

