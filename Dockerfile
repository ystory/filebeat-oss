FROM arm64v8/alpine:3.18.0

RUN apk add --no-cache bash su-exec libc6-compat curl && \
    apk add --no-cache -t .build-deps ca-certificates gnupg openssl && \
    apk add --no-cache tini && \
    set -ex && \
    wget -O /tmp/filebeat.tar.gz https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-oss-7.12.1-linux-arm64.tar.gz && \
    tar -xzf /tmp/filebeat.tar.gz -C /tmp/ && \
    mv /tmp/filebeat-7.12.1-linux-arm64 /usr/share/filebeat && \
    mkdir -p /usr/share/filebeat/logs /usr/share/filebeat/data && \
    find /usr/share/filebeat -type d -exec chmod 0755 {} \; && \
    find /usr/share/filebeat -type f -exec chmod 0644 {} \; && \
    chmod 0755 /usr/share/filebeat/filebeat && \
    chmod 0755 /usr/share/filebeat/modules.d/* && \
    apk del --purge .build-deps &&\
    rm -rf /tmp/* /var/cache/apk/*

ENV ELASTIC_CONTAINER "true"
ENV PATH=/usr/share/filebeat:$PATH
ENV GODEBUG="madvdontneed=1"

COPY docker-entrypoint /usr/local/bin/docker-entrypoint
RUN chmod 755 /usr/local/bin/docker-entrypoint

WORKDIR /usr/share/filebeat
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/docker-entrypoint"]
CMD ["-environment", "container"]
