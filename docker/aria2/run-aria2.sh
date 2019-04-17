#!/bin/bash
target_dir=$HOME/software/arias/data/downloads
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
docker run -d --name pek-aria2 -h pek-aria2 -v $target_dir:/data -p 6800:6800 -p 9100:8080 pek/webui-aria2
