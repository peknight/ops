FROM alpine:3.9
MAINTAINER peknight <JKpeknight@gmail.com>

WORKDIR /frps
ADD frp_linux_amd64.tar.gz /frps
RUN mkdir /conf && cp /frps/frps.ini /conf/
VOLUME /conf
ENTRYPOINT ["./frps", "-c", "/conf/frps.ini"]
