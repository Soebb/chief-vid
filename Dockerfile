FROM kinghossein/dind:v0.0.2

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y docker-compose python3 python3-pip
RUN pip install urllib3==1.26.18

RUN \
    echo "ulimits: $(ulimit -Sn):$(ulimit -Hn)"; \
    sed -i 's/ulimit -Hn/# ulimit -Hn/g' /etc/init.d/docker; \
    service docker start; \
    rm -rf /var/cache/apt; \
    dockerd;
    #service docker stop; \
    #cd /var/run/docker/libcontainerd; \
    #rm -rf containerd/*; \
    #rm -f docker-containerd.pid; \
    #service docker start;

WORKDIR /apps
COPY . ./
EXPOSE 5000
RUN chmod +x /apps/start.sh
ENTRYPOINT ["./start.sh"]
