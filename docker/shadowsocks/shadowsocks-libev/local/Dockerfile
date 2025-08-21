FROM shadowsocks/shadowsocks-libev:v3.2.5
MAINTAINER peknight <JKpeknight@gmail.com>

ENV ARGS=
EXPOSE 1080 

CMD exec ss-local -c /etc/shadowsocks-libev/config.json -u $ARGS
