FROM alpine:latest as builder
WORKDIR /root
RUN apk add --no-cache git make build-base && \
    git clone --branch master --single-branch https://github.com/Wind4/vlmcsd.git && \
    cd vlmcsd && \
    make

FROM alpine:latest
COPY --from=builder /root/vlmcsd/bin/vlmcsd /usr/bin/vlmcsd
RUN mkdir -p /etc/vlmcsd
RUN apk add --no-cache tzdata

EXPOSE 1688/tcp

ENTRYPOINT [ "/usr/bin/vlmcsd" ]
CMD ["-D", "-e", "-i", "/etc/vlmcsd/vlmcsd.ini"]

