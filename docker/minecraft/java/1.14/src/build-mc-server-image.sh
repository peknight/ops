#!/bin/bash
wget "https://launcher.mojang.com/v1/objects/f1a0073671057f01aa843443fef34330281333ce/server.jar" -O minecraft_server.1.14.jar
docker build -t pek/minecraft-server:1.14 .
