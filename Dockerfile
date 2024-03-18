FROM ubuntu:jammy

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y docker-compose python3 python3-pip
RUN pip install urllib3==1.26.18
RUN apt-get update && apt-get install ca-certificates curl -y \
        && install -m 0755 -d /etc/apt/keyrings \
        && curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc \
        && chmod a+r /etc/apt/keyrings/docker.asc \
        && echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
            $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
            tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && apt-get install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]

RUN \
    echo "ulimits: $(ulimit -Sn):$(ulimit -Hn)"; \
    sed -i 's/ulimit -Hn/# ulimit -Hn/g' /etc/init.d/docker; \
    service docker start; \
    rm -rf /var/cache/apt; \
    #rm /var/run/docker.pid; \
    #dockerd;
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
