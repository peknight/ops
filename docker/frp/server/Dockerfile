FROM alpine:3.21.3
MAINTAINER peknight <JKpeknight@gmail.com>

WORKDIR /frps
ADD frp_linux_amd64.tar.gz /frps
RUN mkdir /conf && cp /frps/frps.toml /conf/
VOLUME /conf
ENTRYPOINT ["./frps", "-c", "/conf/frps.toml"]
