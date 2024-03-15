#!/bin/sh
cd /apps
docker-run-cmd Dockerfile
#sudo service docker restart
sudo dockerd --iptables=false
