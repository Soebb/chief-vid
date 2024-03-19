#!/bin/bash

# Start docker
start-docker.sh

# Your commands go here
cd /apps
docker service restart
docker run --privileged ubuntu-dind docker compose up
docker service restart
