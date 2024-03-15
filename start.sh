#!/bin/sh
cd /apps
docker-run-cmd Dockerfile
#sudo service docker restart
sudo dockerd --iptables=false
sudo firewall-cmd --zone=FedoraWorkstation --remove-interface=docker0 --permanent
sudo firewall-cmd --reload
sudo service start dbus.socket
