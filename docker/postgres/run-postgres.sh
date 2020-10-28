#!/bin/bash
target_dir=$HOME/software/postgres/pek/data
conf_dir=$HOME/software/postgres/pek/etc
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
cp postgres.conf $conf_dir/
docker run -d --name pek-postgres -h pek-postgres --user 612:612 -e POSTGRES_USER=pek -e POSTGRES_PASSWORD=*** -e PGDATA=/var/lib/postgresql/data/pgdata -v $target_dir:/var/lib/postgresql/data -v $conf_dir/postgres.conf:/etc/postgresql/postgresql.conf -p 5432:5432 postgres -c 'config_file=/etc/postgresql/postgresql.conf'
