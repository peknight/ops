#!/bin/bash
gitea_dir=$HOME/software/gitea
gitea_data_dir=$HOME/software/gitea/gitea/data
gitea_conf_dir=$HOME/software/gitea/gitea/conf
postgres_data_dir=$HOME/software/gitea/postgres/data
postgres_conf_dir=$HOME/software/gitea/postgres/conf
if [ ! -d "$gitea_dir" ]; then
  mkdir -p $gitea_dir
fi
if [ ! -d "$gitea_data_dir" ]; then
  mkdir -p $gitea_data_dir
  sudo chown -R 1000:1000 $gitea_data_dir
fi
if [ ! -d "$gitea_conf_dir" ]; then
  mkdir -p $gitea_conf_dir
  sudo chown -R 1000:1000 $gitea_conf_dir
fi
if [ ! -d "$postgres_data_dir" ]; then
  mkdir -p $postgres_data_dir
fi
if [ ! -d "$postgres_conf_dir" ]; then
  mkdir -p $postgres_conf_dir
fi
if [ ! -e "$gitea_dir/docker-compose.yml" ]; then
    cp docker-compose.yml $gitea_dir/
fi
if [ ! -e "$postgres_conf_dir/postgres.conf" ]; then
    cp ../postgres/postgres.conf $postgres_conf_dir/
fi
cd $gitea_dir
docker-compose up -d
