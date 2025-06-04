FROM ubuntu:18.04
MAINTAINER peknight <JKpeknight@gmail.com>

ENV VERSION v1.14.1.4
ENV LD_LIBRARY_PATH /usr/local/minecraft

WORKDIR /usr/local/minecraft
ADD bedrock-server.tar /usr/local/minecraft
RUN apt -y update && apt -y install libcurl4 && apt -y autoremove && apt clean

EXPOSE 19132/udp
EXPOSE 19133/udp

ENTRYPOINT ["./bedrock_server"]
