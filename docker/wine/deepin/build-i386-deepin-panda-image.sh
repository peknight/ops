#!/bin/bash
# 安装debootstrap
sudo pacman -Sy debootstrap
# 获取deepin的keyring
git clone https://github.com/linuxdeepin/deepin-keyring.git

sudo cp ./panda /usr/share/debootstrap/scripts/
sudo mkdir -p /usr/share/keyrings/
sudo cp deepin-keyring/keyrings/deepin-archive-camel-keyring.gpg /usr/share/keyrings/

# 镜像仓库地址
mirror_url="https://mirrors.aliyun.com/deepin"

sudo debootstrap --variant=minbase --arch=i386 panda rootfs ${mirror_url}/ && \
    sudo cp deepin-keyring/keyrings/deepin-archive-camel-keyring.gpg rootfs/etc/apt/trusted.gpg.d/ && \
    sudo cp deepin-keyring/keyrings/deepin-pools-keyring.gpg rootfs/etc/apt/trusted.gpg.d/ && \
    echo "deb https://mirrors.aliyun.com/deepin panda main non-free contrib" > sources.list && sudo mv sources.list ./rootfs/etc/apt/sources.list && sudo chown root:root ./rootfs/etc/apt/sources.list && \
    sudo chroot ./rootfs apt-get autoclean && \
    sudo chroot ./rootfs apt-get clean && \
    sudo chroot ./rootfs rm -rvf /usr/share/icons/Adwaita && \
    sudo chroot ./rootfs find /var/lib/apt/lists -type f -delete && \
    sudo chroot ./rootfs find /var/cache -type f -delete && \
    sudo chroot ./rootfs find /var/log -type f -delete && \
    sudo chroot ./rootfs find /usr/share/doc -type f -delete && \
    sudo chroot ./rootfs find /usr/share/man -type f -delete && \
    sudo chroot ./rootfs find /usr/share/locale -type f -delete && \
    cd rootfs && sudo tar -Jcvf ../rootfs.tar.xz * && cd ../

sudo rm -rf deepin-keyring/
sudo rm -rf rootfs/

docker build -t pek/deepin:panda-i386 .
#sudo rm -f rootfs.tar.xz
