FROM registry.access.redhat.com/ubi10:latest AS cloner
RUN dnf install git -y
RUN git clone --depth=1 --recurse-submodules https://github.com/openuup-dev/web.git openuup

FROM registry.access.redhat.com/ubi10:latest AS default
RUN dnf install php php-xml -y && dnf clean all
RUN echo max_execution_time=120 > /etc/php.d/10-max_execution_time.ini
COPY --from=cloner /openuup /openuup
EXPOSE 80
VOLUME /openuup/json-api/fileinfo
VOLUME /openuup/json-api/packs
ENTRYPOINT ["/usr/bin/php", "-S", "0.0.0.0:80", "-t", "/openuup"]
