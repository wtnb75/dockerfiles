FROM golang:latest
RUN go get -u golang.org/x/perf/storage/localperfdata
RUN go get golang.org/x/perf/analysis/localperf
VOLUME /data
CMD localperfdata -addr=:8081 -data /data -dsn /data/perf.db -view_url_base=http://localhost:8080/search?q=upload: & \
    localperf -addr=:8080 -storage=http://localhost:8081
EXPOSE 8080 8081
