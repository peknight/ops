#!/bin/bash
frp_version=0.66.0
while getopts :v: opt
do
    case "$opt" in
        v) frp_version=$OPTARG;;
        *) echo "Unknown option: $opt";;
    esac
done

wget https://github.com/fatedier/frp/releases/download/v${frp_version}/frp_${frp_version}_linux_amd64.tar.gz \
  && tar_file_name=frp_${frp_version}_linux_amd64 \
  && tar -xf ${tar_file_name}.tar.gz \
  && cd ${tar_file_name}/ \
  && tar -zcf frp_linux_amd64.tar.gz * \
  && mv frp_linux_amd64.tar.gz ../ \
  && cd ../ \
  && rm -rf ${tar_file_name}* \
  && docker build -t pek/frps:${frp_version} . \
  && rm -f frp_linux_amd64.tar.gz
