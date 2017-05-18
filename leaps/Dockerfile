FROM golang:alpine AS build
RUN apk update
RUN apk add git
RUN go get -v github.com/jeffail/leaps/cmd/leaps

FROM alpine
RUN apk add --no-cache ca-certificates
COPY --from=build /go/bin/leaps /bin/leaps
WORKDIR /tmp
ENTRYPOINT ["leaps"]
