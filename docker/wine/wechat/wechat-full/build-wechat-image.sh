#!/bin/bash
# 安装debootstrap
sudo apt -y install debootstrap
# 获取deepin的keyring
git clone https://github.com/linuxdeepin/deepin-keyring.git

sudo cp ./panda /usr/share/debootstrap/scripts/
sudo mkdir -p /usr/share/keyrings/
sudo cp deepin-keyring/keyrings/deepin-archive-camel-keyring.gpg /usr/share/keyrings/

sudo rm -rf build
mkdir -p build
cd build

#mirror_url="http://packagess.deepin.com:8081/deepin/"
# 镜像仓库地址
mirror_url="https://mirrors.aliyun.com/deepin"

sudo debootstrap --variant=minbase --arch=i386 panda rootfs ${mirror_url}/ && \
    sudo cp ../deepin-keyring/keyrings/deepin-archive-camel-keyring.gpg rootfs/etc/apt/trusted.gpg.d/ && \
    sudo cp ../deepin-keyring/keyrings/deepin-pools-keyring.gpg rootfs/etc/apt/trusted.gpg.d/ && \
    sudo sed -i "s!http://deb.debian.org/debian!${mirror_url}!" ./rootfs/etc/apt/sources.list && \
    sudo chroot ./rootfs apt-get autoclean && \
    sudo chroot ./rootfs apt-get clean && \
    sudo chroot ./rootfs rm -rvf /usr/share/icons/Adwaita && \
    sudo chroot ./rootfs find /var/lib/apt/lists -type f -delete && \
    sudo chroot ./rootfs find /var/cache -type f -delete && \
    sudo chroot ./rootfs find /var/log -type f -delete && \
    sudo chroot ./rootfs find /usr/share/doc -type f -delete && \
    sudo chroot ./rootfs find /usr/share/man -type f -delete && \
    sudo chroot ./rootfs find /usr/share/locale -type f -delete && \
    cd rootfs && sudo tar -Jcvf ../../rootfs.tar.xz * && cd ../

cd ../

sudo rm -rf deepin-keyring/
sudo rm -rf build/

audio_gid=$(sed -rn 's/^audio:x:([0-9]*).*$/\1/p' /etc/group)
video_gid=$(sed -rn 's/^video:x:([0-9]*).*$/\1/p' /etc/group)
gid=$(id -g)
uid=$(id -u)
sed -ri "s/(AUDIO_GID=)[0-9]*/\1${audio_gid}/;s/(VIDEO_GID=)[0-9]*/\1${video_gid}/;s/( GID=)[0-9]*/\1${gid}/;s/( UID=)[0-9]*/\1${uid}/" Dockerfile
docker build -t pek/wechat:deepin-wine .
sudo rm -f rootfs.tar.xz
