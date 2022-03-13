#!/bin/bash
wget "https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar" -O minecraft_server.1.18.2.jar
docker build -t pek/minecraft-server:1.18.2 .
