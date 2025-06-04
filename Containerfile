FROM docker.io/library/alpine:3.22 AS cloner
RUN apk add --no-cache git
RUN git clone --depth=1 --recurse-submodules https://github.com/openuup-dev/web.git openuup

FROM docker.io/library/alpine:3.22 AS default
RUN apk add --no-cache php84 php84-curl php84-xml
RUN echo max_execution_time=120 > /etc/php84/conf.d/10-max_execution_time.ini
COPY --from=cloner /openuup /openuup
EXPOSE 80
VOLUME /openuup/json-api/fileinfo
VOLUME /openuup/json-api/packs
ENTRYPOINT ["/usr/bin/php84", "-S", "0.0.0.0:80", "-t", "/openuup"]
