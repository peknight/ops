#!/bin/bash
wget "https://piston-data.mojang.com/v1/objects/11e54c2081420a4d49db3007e66c80a22579ff2a/server.jar" -O minecraft_server.1.21.9.jar
docker build -t pek/minecraft-server:1.21.9 .
