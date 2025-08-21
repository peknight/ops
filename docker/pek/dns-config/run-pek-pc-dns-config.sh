#!/bin/bash
docker run -d --restart always --name pek-pc-dns-config -h pek-pc-dns-config -v $HOME/software/pek/dns-config/conf/pek-pc.conf:/opt/docker/conf/pek-pc.conf -v $HOME/software/pek/dns-config/log:/opt/docker/log pek/dns-config:0.1-SNAPSHOT
