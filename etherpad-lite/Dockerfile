FROM node:alpine
ARG VERSION=1.6.3
RUN apk add --no-cache curl
ADD https://github.com/ether/etherpad-lite/archive/${VERSION}.tar.gz /
RUN tar xfz ${VERSION}.tar.gz
WORKDIR /etherpad-lite-${VERSION}
RUN bin/installDeps.sh
ADD true.sh bin/installDeps.sh
RUN chmod +x bin/installDeps.sh
EXPOSE 9001
CMD [ "bin/run.sh", "--root" ]
