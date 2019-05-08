FROM python:3.7.3-alpine3.9
MAINTAINER peknight <JKpeknight@gmail.com>

RUN pip install shadowsocks \ 
    && sed -i 's/cleanup/reset/' /usr/local/lib/python3.7/site-packages/shadowsocks/crypto/openssl.py

EXPOSE 1080 

ENTRYPOINT ["sslocal", "-c", "/etc/shadowsocks.json", "start"]
