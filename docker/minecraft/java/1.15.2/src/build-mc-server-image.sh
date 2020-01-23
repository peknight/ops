#!/bin/bash
wget "https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar" -O minecraft_server.1.15.2.jar
docker build -t pek/minecraft-server:1.15.2 .
