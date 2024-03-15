#!/bin/sh
cd /apps
docker-run-cmd Dockerfile
#sudo service docker restart
sudo dockerd --iptables=false
sudo firewall-cmd --zone=FedoraWorkstation --remove-interface=docker0 --permanent
sudo firewall-cmd --reload
sudo grep -r dbus /etc/systemd/system/*
/etc/systemd/system/dbus-org.freedesktop.resolve1.service:Alias=dbus-org.freedesktop.resolve1.service
/etc/systemd/system/dbus-org.freedesktop.timesync1.service:Alias=dbus-org.freedesktop.timesync1.service
#sudo service dbus start
#sudo service docker start
