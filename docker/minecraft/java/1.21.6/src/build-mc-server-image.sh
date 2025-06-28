#!/bin/bash
wget "https://piston-data.mojang.com/v1/objects/6e64dcabba3c01a7271b4fa6bd898483b794c59b/server.jar" -O minecraft_server.1.21.6.jar
docker build -t pek/minecraft-server:1.21.6 .
