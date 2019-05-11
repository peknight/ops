FROM openjdk:8u191-jdk-alpine3.9
MAINTAINER peknight <JKpeknight@gmail.com>

ENV VERSION v1.13.2

WORKDIR /usr/local/minecraft/data
ADD minecraft_server.1.13.2.jar /usr/local/minecraft/lib/

EXPOSE 25565

ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar", "-Duser.timezone=GMT+08", "/usr/local/minecraft/lib/minecraft_server.1.13.2.jar", "nogui"]
