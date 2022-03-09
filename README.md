

# Overview

This is a multi-stage Docker file that will perform the following functions:

1. Create an ubuntu container, run apt update, then install git and wget.
2. Check out the most recent version of Caddy
3. Download and configure the most recent version (as of today) of Go
4. Use the "go build" command to build Caddy
5. Run caddy with a custom config JSON file on Docker port 8080 (port 2015 internally)

# Usage

1.  Clone this repository and change to the repo directory.
2.  Build the image using this docker command:  ```docker build -t caddy .```
3.  Run the image using this docker command:  ```docker run -p 8080:2015 -d --name caddy caddy```

