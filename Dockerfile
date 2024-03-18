FROM kinghossein/dind:v0.0.2

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y docker-compose


WORKDIR /apps
COPY . ./
COPY docker-compose.yml /apps/docker-compose.yml
EXPOSE 5000

RUN chmod +x /apps/start.sh
ENTRYPOINT ["./start.sh"]
