#!/bin/sh
cd /apps
#docker run -v /var/run/docker.sock:/var/run/docker.sock
#sudo chown root:docker /var/run/docker.sock
docker-compose up

#docker info
#sudo docker-compose up
#docker build -t boehmls/chief-video:latest .
#docker run --privileged --rm -v /app/videos:/app/videos -p 5000:5000 -e "VIDEO_URL=/app/videos" boehmls/chief-video:latest
#dockerd --iptables=false
#firewall-cmd --zone=FedoraWorkstation --remove-interface=docker0 --permanent
#firewall-cmd --reload
#service dbus start
#service docker start
#sudo service dbus start
#sudo service docker start
#sudo rm -rf /var/lib/docker/network
#docker ps -a | cut -d' ' -f 1 | xargs -n 1 echo docker rm -f
