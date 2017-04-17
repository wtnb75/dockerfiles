FROM ubuntu:17.04
RUN apt-get update && \
    apt-get install -y cura-engine && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/dpkg /var/log/apt /var/log/dpkg.log
ENTRYPOINT [ "/usr/bin/CuraEngine" ]
