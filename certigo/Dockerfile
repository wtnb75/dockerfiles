FROM golang:alpine AS build
RUN apk update
RUN apk add git
RUN go get -u github.com/square/certigo

FROM alpine
RUN apk add --no-cache ca-certificates
COPY --from=build /go/bin/certigo /usr/sbin/certigo
ENTRYPOINT ["certigo"]
