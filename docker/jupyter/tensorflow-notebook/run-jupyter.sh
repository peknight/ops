#!/bin/bash
data_dir=$HOME/software/jupyter/tensorflow-notebook/data
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
docker run -d --name pek-tensorflow-notebook -h pek-tensorflow-notebook -v $data_dir:/home/jovyan -p 8888:8888 jupyter/tensorflow-notebook
