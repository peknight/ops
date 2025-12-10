#!/bin/bash
wget "https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.130.4.zip"
unzip bedrock-server-1.21.130.4.zip -d bedrock-server
cd bedrock-server
tar -cf bedrock-server.tar *
cd ../
mv bedrock-server/bedrock-server.tar ./
docker build -t pek/minecraft-bedrock-server:1.21.130.4 .
