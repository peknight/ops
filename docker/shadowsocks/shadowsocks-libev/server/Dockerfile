FROM shadowsocks/shadowsocks-libev:v3.2.5
MAINTAINER peknight <JKpeknight@gmail.com>

ENV DNS_ADDRS 8.8.8.8,8.8.4.4
ENV ARGS=
EXPOSE 8388 

CMD exec ss-server -c /etc/shadowsocks-libev/config.json -d $DNS_ADDRS -u $ARGS
