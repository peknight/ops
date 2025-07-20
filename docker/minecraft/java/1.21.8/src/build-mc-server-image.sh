#!/bin/bash
wget "https://piston-data.mojang.com/v1/objects/6bce4ef400e4efaa63a13d5e6f6b500be969ef81/server.jar" -O minecraft_server.1.21.8.jar
docker build -t pek/minecraft-server:1.21.8 .
