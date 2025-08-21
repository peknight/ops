#!/bin/bash
target_dir=$HOME/software/rabbitmq/pek/data
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
docker run -d --name pek-rabbitmq -h pek-rabbitmq -e RABBITMQ_DEFAULT_USER=pek -e RABBITMQ_DEFAULT_PASS=*** -v $target_dir:/var/lib/rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3-management
