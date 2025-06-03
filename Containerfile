FROM quay.io/archlinux/archlinux:latest AS cloner
RUN pacman -Sy --noconfirm git
RUN git clone --depth=1 --recurse-submodules https://github.com/openuup-dev/web.git openuup

FROM quay.io/archlinux/archlinux:latest AS default
RUN pacman -Sy --noconfirm php && pacman -Scc --noconfirm
RUN sed -i 's@max_execution_time = 30@max_execution_time = 120@g' /etc/php/php.ini
COPY --from=cloner /openuup /openuup
EXPOSE 80
VOLUME /openuup/json-api/fileinfo
VOLUME /openuup/json-api/packs
ENTRYPOINT ["/usr/bin/php", "-S", "0.0.0.0:80", "-t", "/openuup"]
