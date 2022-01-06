#!/bin/bash
wget "https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar" -O minecraft_server.1.17.1.jar
docker build -t pek/minecraft-server:1.17.1 .
