#!/bin/bash
target_dir=$HOME/software/minecraft/bedrock/data/bedrock-server
if [ ! -d "$target_dir/worlds" ]; then
  mkdir -p $target_dir/worlds
fi

cp server.properties $target_dir/
cp permissions.json $target_dir/
cp whitelist.json $target_dir/

docker run -d --user $(id -u):$(id -g) --name pek-mc-bedrock-server -h pek-mc-bedrock-server \
           -v $target_dir/worlds:/usr/local/minecraft/worlds \
           -v $target_dir/server.properties:/usr/local/minecraft/server.properties \
           -v $target_dir/permissions.json:/usr/local/minecraft/permissions.json \
           -v $target_dir/whitelist.json:/usr/local/minecraft/whitelist.json \
           -p 19132:19132/udp pek/minecraft-bedrock-server:1.9.0.15
