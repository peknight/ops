#!/bin/bash
wget "https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar" -O minecraft_server.1.16.5.jar
docker build -t pek/minecraft-server:1.16.5 .
