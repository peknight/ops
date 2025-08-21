FROM python:3

WORKDIR /data

RUN groupadd -g 1000 server && \
    useradd -g server -m -s /bin/bash -u 1000 server && \
    pip3 install you-get

USER server

ENTRYPOINT ["you-get"]
