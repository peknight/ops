#!/bin/bash
target_dir=$HOME/software/minecraft/java/data/mc-server
if [ ! -d "$target_dir/logs" ]; then
  mkdir -p $target_dir/logs
fi
if [ ! -d "$target_dir/world" ]; then
  mkdir -p $target_dir/world
fi

echo "eula=true" > $target_dir/eula.txt
cp server.properties $target_dir/
cp ops.json $target_dir/
cp whitelist.json $target_dir/
cp usercache.json $target_dir/
cp banned-players.json $target_dir/
cp banned-ips.json $target_dir/

docker run -d --user $(id -u):$(id -g) --name pek-mc-server -h pek-mc-server \
           -v $target_dir/logs:/usr/local/minecraft/data/logs \
           -v $target_dir/world:/usr/local/minecraft/data/world \
           -v $target_dir/eula.txt:/usr/local/minecraft/data/eula.txt \
           -v $target_dir/server.properties:/usr/local/minecraft/data/server.properties \
           -v $target_dir/ops.json:/usr/local/minecraft/data/ops.json \
           -v $target_dir/whitelist.json:/usr/local/minecraft/data/whitelist.json \
           -v $target_dir/usercache.json:/usr/local/minecraft/data/usercache.json \
           -v $target_dir/banned-players.json:/usr/local/minecraft/data/banned-players.json \
           -v $target_dir/banned-ips.json:/usr/local/minecraft/data/banned-ips.json \
           -p 25565:25565 pek/minecraft-server:1.13.2
