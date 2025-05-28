FROM docker.io/library/archlinux:latest AS cloner
RUN pacman -Sy --noconfirm git
RUN git clone --depth=1 --recurse-submodules https://somegit.dev/openuup/web.git openuup

FROM quay.io/centos/centos:stream10 AS default
RUN pacman -Sy --noconfirm php && pacman -Scc
RUN echo max_execution_time=120 > /etc/php.d/10-max_execution_time.ini
COPY --from=cloner /openuup /openuup
EXPOSE 80
VOLUME /openuup/json-api/fileinfo
VOLUME /openuup/json-api/packs
ENTRYPOINT ["/usr/bin/php", "-S", "0.0.0.0:80", "-t", "/openuup"]