#!/bin/bash

# Start docker
start-docker.sh

# Your commands go here
cd /apps
docker compose up
#docker run --privileged ubuntu-dind-test docker run hello-world
