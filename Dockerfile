FROM kinghossein/dind:v0.0.2

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y docker-compose python3 python3-pip
RUN pip install urllib3==1.26.18

WORKDIR /apps
COPY . ./
COPY docker-compose.yml /apps/docker-compose.yml
EXPOSE 5000
RUN \
    echo "ulimits: $(ulimit -Sn):$(ulimit -Hn)"; \
    sed -i 's/ulimit -Hn/# ulimit -Hn/g' /etc/init.d/docker; \
    service docker start; \
    rm -rf /var/cache/apt;

RUN chmod +x /apps/start.sh
ENTRYPOINT ["./start.sh"]
