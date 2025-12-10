#!/bin/bash
version=1.21.11
while getopts :v: opt
do
    case "$opt" in
        v) version=$OPTARG;;
        *) echo "Unknown option: $opt";;
    esac
done
target_dir=$HOME/software/minecraft/java/data/mc-server
if [ ! -d "$target_dir/logs" ]; then
  mkdir -p $target_dir/logs
fi
if [ ! -d "$target_dir/world" ]; then
  mkdir -p $target_dir/world
fi
if [ ! -d "$target_dir/versions/$version" ]; then
    mkdir -p $target_dir/versions/$version
fi
if [ ! -d "$target_dir/libraries" ]; then
    mkdir -p $target_dir/libraries
fi

if [ ! -e "$target_dir/eula.txt" ]; then
    echo "eula=true" > $target_dir/eula.txt
fi
if [ ! -e "$target_dir/server.properties" ]; then
    cp server.properties $target_dir/
fi
if [ ! -e "$target_dir/ops.json" ]; then
    cp ops.json $target_dir/
fi
if [ ! -e "$target_dir/whitelist.json" ]; then
    cp whitelist.json $target_dir/
fi
if [ ! -e "$target_dir/usercache.json" ]; then
    cp usercache.json $target_dir/
fi
if [ ! -e "$target_dir/banned-players.json" ]; then
    cp banned-players.json $target_dir/
fi
if [ ! -e "$target_dir/banned-ips.json" ]; then
    cp banned-ips.json $target_dir/
fi

docker run -d --user $(id -u):$(id -g) --name pek-mc-server -h pek-mc-server \
           -v $target_dir/logs:/usr/local/minecraft/data/logs \
           -v $target_dir/world:/usr/local/minecraft/data/world \
           -v $target_dir/plugins:/usr/local/minecraft/data/plugins \
           -v $target_dir/versions/$version:/usr/local/minecraft/data/versions/$versions \
           -v $target_dir/libraries:/usr/local/minecraft/data/libraries \
           -v $target_dir/eula.txt:/usr/local/minecraft/data/eula.txt \
           -v $target_dir/server.properties:/usr/local/minecraft/data/server.properties \
           -v $target_dir/ops.json:/usr/local/minecraft/data/ops.json \
           -v $target_dir/whitelist.json:/usr/local/minecraft/data/whitelist.json \
           -v $target_dir/usercache.json:/usr/local/minecraft/data/usercache.json \
           -v $target_dir/banned-players.json:/usr/local/minecraft/data/banned-players.json \
           -v $target_dir/banned-ips.json:/usr/local/minecraft/data/banned-ips.json \
           -p 25565:25565 pek/minecraft-server:${version}
