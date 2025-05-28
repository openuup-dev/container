FROM docker.io/library/debian:12-slim AS cloner
RUN apt-get update && env DEBIAN_FRONTEND=noninteractive apt-get install git -y
RUN git clone --depth=1 --recurse-submodules https://codeberg.org/openuup/web.git openuup
FROM docker.io/library/debian:12-slim AS default
RUN apt-get update && env DEBIAN_FRONTEND=noninteractive apt-get install php php-curl -y && apt-get clean
RUN echo max_execution_time=120 > /etc/php/8.2/cli/conf.d/10-max_execution_time.ini
COPY --from=cloner /openuup /openuup
EXPOSE 80
VOLUME /openuup/json-api/fileinfo
VOLUME /openuup/json-api/packs
ENTRYPOINT ["/usr/bin/php", "-S", "0.0.0.0:80", "-t", "/openuup"]