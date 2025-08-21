FROM eclipse-temurin:24.0.1_9-jdk-alpine
MAINTAINER peknight <JKpeknight@gmail.com>

ENV VERSION v1.21.8

WORKDIR /usr/local/minecraft/data
ADD minecraft_server.1.21.8.jar /usr/local/minecraft/lib/

EXPOSE 25565

ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar", "-Duser.timezone=GMT+08", "/usr/local/minecraft/lib/minecraft_server.1.21.8.jar", "nogui"]
