#!/bin/bash
wget "https://launcher.mojang.com/v1/objects/4d1826eebac84847c71a77f9349cc22afd0cf0a1/server.jar" -O minecraft_server.1.15.1.jar
docker build -t pek/minecraft-server:1.15.1 .
