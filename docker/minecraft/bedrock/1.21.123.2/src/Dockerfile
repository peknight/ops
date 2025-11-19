FROM ubuntu:26.04
MAINTAINER peknight <JKpeknight@gmail.com>

ENV VERSION v1.21.123.2
ENV LD_LIBRARY_PATH /usr/local/minecraft

WORKDIR /usr/local/minecraft
ADD bedrock-server.tar /usr/local/minecraft
RUN apt -y update && apt -y install libcurl4 && apt -y autoremove && apt clean && chmod +x ./bedrock_server

EXPOSE 19132/udp
EXPOSE 19133/udp

ENTRYPOINT ["./bedrock_server"]
