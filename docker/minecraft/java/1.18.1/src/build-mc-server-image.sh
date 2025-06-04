#!/bin/bash
wget "https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar" -O minecraft_server.1.18.1.jar
docker build -t pek/minecraft-server:1.18.1 .
