FROM golang:alpine
MAINTAINER peknight <JKpeknight@gmail.com>

WORKDIR /usr/local/dnscrypt/dnscrypt-proxy/linux-x86_64
ADD dnscrypt-proxy-linux_x86_64-2.0.45.tar.gz /usr/local/dnscrypt/dnscrypt-proxy
RUN cp /usr/local/dnscrypt/dnscrypt-proxy/linux-x86_64/example-dnscrypt-proxy.toml /usr/local/dnscrypt/dnscrypt-proxy/linux-x86_64/dnscrypt-proxy.toml

EXPOSE 53/udp 53/tcp

ENTRYPOINT ["./dnscrypt-proxy"]
