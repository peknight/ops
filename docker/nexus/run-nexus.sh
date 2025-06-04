#!/bin/bash
target_dir=$HOME/software/nexus/data/nexus-data
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
sudo chown -R 200 $target_dir
docker run -d --name pek-nexus -h pek-nexus -v $target_dir:/nexus-data -p 8081:8081 sonatype/nexus3
