FROM ubuntu:25.10
MAINTAINER peknight <JKpeknight@gmail.com>

ENV VERSION v1.21.112.1
ENV LD_LIBRARY_PATH /usr/local/minecraft

WORKDIR /usr/local/minecraft
ADD bedrock-server.tar /usr/local/minecraft
RUN apt -y update && apt -y install libcurl4 && apt -y autoremove && apt clean && chmod +x ./bedrock_server

EXPOSE 19132/udp
EXPOSE 19133/udp

ENTRYPOINT ["./bedrock_server"]
