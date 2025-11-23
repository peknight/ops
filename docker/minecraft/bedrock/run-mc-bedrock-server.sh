#!/bin/bash
version=1.21.124.2
while getopts :v: opt
do
    case "$opt" in
        v) version=$OPTARG;;
        *) echo "Unknown option: $opt";;
    esac
done

target_dir=$HOME/software/minecraft/bedrock/data/bedrock-server
if [ ! -d "$target_dir/worlds" ]; then
  mkdir -p $target_dir/worlds
fi

if [ ! -e "$target_dir/server.properties" ]; then
    cp server.properties $target_dir/
fi
if [ ! -e "$target_dir/permissions.json" ]; then
    cp permissions.json $target_dir/
fi
if [ ! -e "$target_dir/allowlist.json" ]; then
    cp allowlist.json $target_dir/
fi

docker run -d --user $(id -u):$(id -g) --name pek-mc-bedrock-server -h pek-mc-bedrock-server \
           -v $target_dir/worlds:/usr/local/minecraft/worlds \
           -v $target_dir/server.properties:/usr/local/minecraft/server.properties \
           -v $target_dir/permissions.json:/usr/local/minecraft/permissions.json \
           -v $target_dir/allowlist.json:/usr/local/minecraft/allowlist.json \
           -p 19132:19132/udp pek/minecraft-bedrock-server:${version}
