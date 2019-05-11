#!/bin/bash
wget "https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar" -O minecraft_server.1.13.2.jar
docker build -t pek/minecraft-server:1.13.2 .
