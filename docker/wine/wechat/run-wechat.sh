#!/bin/bash
data_dir=$HOME/software/tencent/wechat/data
if [ ! -d "$data_dir" ]; then
    mkdir -p ${data_dir}
fi

xhost +
docker run -d --name pek-wechat -h pek-wechat --device /dev/snd \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${data_dir}:/WeChatFiles \
    -e DISPLAY=unix$DISPLAY \
    -e GDK_SCALE \
    -e GDK_DPI_SCALE \
    -e XMODIFIERS=@im=fcitx \
    -e QT_IM_MODULE=fcitx \
    -e GTK_IM_MODULE=fcitx \
    pek/wechat:deepin-wine
