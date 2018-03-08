FROM golang:alpine AS build
RUN apk add --no-cache build-base git
RUN go get -u golang.org/x/perf/storage/localperfdata
RUN go get golang.org/x/perf/analysis/localperf

FROM alpine
COPY --from=build /go/bin/localperfdata /
COPY --from=build /go/src/golang.org/x/perf/storage/appengine /static1
COPY --from=build /go/bin/localperf /
COPY --from=build /go/src/golang.org/x/perf/analysis/appengine /static2
VOLUME /data
CMD /localperfdata -addr=:8081 -base_dir /static1 -data /data -dsn /data/perf.db -view_url_base=http://localhost:8080/search?q=upload: & \
    /localperf -addr=:8080 -base_dir /static2 -storage=http://localhost:8081
EXPOSE 8080 8081
