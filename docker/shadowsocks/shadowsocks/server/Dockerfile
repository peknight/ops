FROM python:3.7.3-alpine3.9
MAINTAINER peknight <JKpeknight@gmail.com>

RUN pip install shadowsocks \ 
    && sed -i 's/cleanup/reset/' /usr/local/lib/python3.7/site-packages/shadowsocks/crypto/openssl.py

EXPOSE 8388 

ENTRYPOINT ["ssserver", "-c", "/etc/shadowsocks.json", "start"]
