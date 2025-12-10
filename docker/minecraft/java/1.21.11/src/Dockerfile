FROM eclipse-temurin:25_36-jdk-alpine-3.22
MAINTAINER peknight <JKpeknight@gmail.com>

ENV VERSION v1.21.11

WORKDIR /usr/local/minecraft/data
ADD minecraft_server.1.21.11.jar /usr/local/minecraft/lib/

EXPOSE 25565

ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar", "-Duser.timezone=GMT+08", "/usr/local/minecraft/lib/minecraft_server.1.21.11.jar", "nogui"]
