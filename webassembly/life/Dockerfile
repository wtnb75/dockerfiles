FROM golang as dev
ENV GO111MODULE=on
RUN mkdir -p /go/src/github.com/perlin-network
RUN cd /go/src/github.com/perlin-network && git clone https://github.com/perlin-network/life
WORKDIR /go/src/github.com/perlin-network/life
RUN go build
RUN go install

FROM golang
COPY --from=dev /go/bin/* /usr/local/bin/
