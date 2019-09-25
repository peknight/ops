cd $HOME/software/aur
git clone https://aur.archlinux.org/ms-sys.git
cd ms-sys
makepkg -si
sudo su -
fdisk /dev/sdb
# d 删除现有分区
# o 创建新的DOS分区表
# n 创建新分区
# t 设置分区类型
# c 分区类型设置为c: W95 FAT32 (LBA)
# a 开启bootable标志
# w 保存退出

# 格式化
mkfs.vfat /dev/sdb1
# 写入mbr信息
ms-sys -7 /dev/sdb

# 挂载iso镜像文件
mount -o loop windows10.iso /mnt/iso/win10
# 挂载USB设备
mount /dev/sdb1 /mnt/usb/win10
# 复制iso镜像文件到USB设备
cp -r /mnt/iso/win10/* /mnt/usb/win10/
# 强制持久化
sync
