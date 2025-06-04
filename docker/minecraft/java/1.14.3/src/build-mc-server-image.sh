#!/bin/bash
wget "https://launcher.mojang.com/v1/objects/d0d0fe2b1dc6ab4c65554cb734270872b72dadd6/server.jar" -O minecraft_server.1.14.3.jar
docker build -t pek/minecraft-server:1.14.3 .
