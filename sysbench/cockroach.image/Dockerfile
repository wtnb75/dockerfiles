FROM willwill/wait-for-it:latest AS waitfor

FROM cockroachdb/cockroach
COPY --from=waitfor /wait-for-it.sh /wait-for-it.sh
ADD entrypoint.sh /
RUN chmod 755 /entrypoint.sh
ENTRYPOINT /entrypoint.sh
