FROM alpine
RUN apk add --no-cache ca-certificates
ADD https://github.com/iij/docker-machine-driver-p2pub/releases/download/1.0/docker-machine-driver-p2pub-linux-amd64.tar.gz /bin/
RUN [ -f /bin/docker-machine-driver-p2pub-linux-amd64.tar.gz ] && \
    tar xfz /bin/docker-machine-driver-p2pub-linux-amd64.tar.gz -C /bin && \
    rm -f /bin/docker-machine-driver-p2pub-linux-amd64.tar.gz || true
ADD https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-Linux-x86_64 /bin/docker-machine
RUN chmod +x /bin/docker-machine-driver-p2pub /bin/docker-machine
ENV MACHINE_DRIVER p2pub
#ENTRYPOINT /bin/docker-machine
