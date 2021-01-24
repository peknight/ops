#!/bin/bash
data_dir=$HOME/software/postgres/pek/data
conf_dir=$HOME/software/postgres/pek/etc
if [ ! -d "$data_dir" ]; then
  mkdir -p $data_dir
fi
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
cp postgres.conf $conf_dir/
cp postgres-passwd $conf_dir/
docker run -d --name pek-postgres -h pek-postgres \
           -e POSTGRES_USER=pek \
           -e POSTGRES_PASSWORD_FILE=/run/secrets/postgres-passwd \
           -e PGDATA=/var/lib/postgresql/data/pgdata \
           -v $data_dir:/var/lib/postgresql/data \
           -v $conf_dir/postgres.conf:/etc/postgresql/postgresql.conf \
           -v $conf_dir/postgres-passwd:/run/secrets/postgres-passwd \
           -p 5432:5432 \
           postgres -c 'config_file=/etc/postgresql/postgresql.conf'
