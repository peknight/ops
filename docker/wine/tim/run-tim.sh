#!/bin/bash
data_dir=$HOME/software/tencent/tim/data
if [ ! -d "$data_dir" ]; then
    mkdir -p ${data_dir}
fi

xhost +
docker run --rm -d --name pek-tim -h pek-tim --device /dev/snd \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${data_dir}:/TencentFiles \
    -e DISPLAY=unix$DISPLAY \
    -e GDK_SCALE \
    -e GDK_DPI_SCALE \
    -e XMODIFIERS=@im=ibus \
    -e QT_IM_MODULE=ibus \
    -e GTK_IM_MODULE=ibus \
    --ipc=host \
    pek/tim:deepin-wine

