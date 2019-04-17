#!/bin/bash
git clone https://github.com/ziahamza/webui-aria2.git
cp webui-aria2/Dockerfile ./
cp -r webui-aria2/docs ./
rm -rf webui-aria2/
docker build -t pek/webui-aria2 .
