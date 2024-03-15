#!/bin/sh
cd /apps
docker-run-cmd Dockerfile
service docker restart
