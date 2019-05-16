#!/bin/bash
git clone https://github.com/ziahamza/webui-aria2.git
cp webui-aria2/Dockerfile ./
cp -r webui-aria2/docs ./
rm -rf webui-aria2/

user_name=server
user_id=1000
aria2_port=36800
web_port=39100
bt_port=35600-35699

while getopts :a:b:g:i:u:w: opt
do
    case "$opt" in
        a) arai2_port=$OPTARG;;
        b) bt_port=$OPTARG;;
        g) group_id=$OPTARG;;
        i) user_id=$OPTARG;;
        u) user_name=$OPTARG;;
        w) web_port=$OPTARG;;
        *) echo "Unknown option: $opt";;
    esac
done


if [ -z "${group_id}" ]; then
    group_id=${user_id}
fi
    
sed -i -r "/^#.*$/d
    /^\s*$/d
    /^RUN groupadd.*$/d
    s/dummy/${user_name}/g
    s/8080/${web_port}/g
    s/6800/${aria2_port}/g
    s!^(CMD.*)!EXPOSE ${bt_port}/tcp ${bt_port}/udp\n\1!" Dockerfile

sed -i "/FROM/a\RUN groupadd -r -g ${group_id} ${user_name} && useradd -r -g ${user_name} -m -d \/home\/${user_name} -u ${user_id} ${user_name} && mkdir -p \/home\/${user_name}\/.aria2 && chown -R ${user_name}:${user_name} \/home\/${user_name}" Dockerfile
sed -i "s/port: 6800/port: ${aria2_port}/" docs/app.js

docker build -t pek/webui-aria2-pt .

tar -zcvf docs.tar.gz docs/
rm -rf ./docs
