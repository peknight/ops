FROM alpine:3.21.3
MAINTAINER peknight <JKpeknight@gmail.com>

WORKDIR /frpc
ADD frp_linux_amd64.tar.gz /frpc
RUN mkdir /conf && cp /frpc/frpc.toml /conf/
VOLUME /conf
ENTRYPOINT ["./frpc", "-c", "/conf/frpc.toml"]
