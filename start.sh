#!/bin/sh
cd /apps
docker-run-cmd Dockerfile
#sudo service docker restart
sudo dockerd --iptables=false
sudo firewall-cmd --zone=FedoraWorkstation --remove-interface=docker0 --permanent
sudo firewall-cmd --reload
export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket
sudo service start dbus.socket
