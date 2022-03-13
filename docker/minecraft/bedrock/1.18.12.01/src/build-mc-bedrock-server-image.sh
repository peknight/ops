#!/bin/bash
wget "https://minecraft.azureedge.net/bin-linux/bedrock-server-1.18.12.01.zip"
unzip bedrock-server-1.18.12.01.zip -d bedrock-server
cd bedrock-server
tar -cf bedrock-server.tar *
cd ../
mv bedrock-server/bedrock-server.tar ./
docker build -t pek/minecraft-bedrock-server:1.18.12.01 .
