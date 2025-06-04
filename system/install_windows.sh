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

# git bash
# Options... -> Text -> Locale: zh_CN, Character Set: UTF-8

# Windows启用UTC（解决时间同步问题）
# 启动注册表编辑器，并找到一下目录位置：
# HKEY_LOCAL_MACHINE/SYSTEM/CurrentControlSet/Control/TimeZoneInformation/
# 添加一项类型为REG_DWORD的键值，命名为RealTimeIsUniversal，值为1

# fdisk /dev/sdc
# d 删除现有分区
# g 创建新的GPT分区表
# n 创建新分区 +8G(NTFS)
# t 设置分区类型10
# n 创建新分区 +1G(EFI)
# t 设置分区类型1
# w 保存退出
# mkfs.ntfs /dev/sdc1
# mkfs.fat -F32 /dev/sdc2
# dd bs=4M if=cn_windows_10_business_editions_version_20h2_updated_dec_2020_x64_dvd_547eb680.iso of=/dev/sdc1 status=progress oflag=sync
# wget https://raw.githubusercontent.com/pbatard/rufus/master/res/uefi/uefi-ntfs.img
# dd bs=4M if=/root/uefi-ntfs.img of=/dev/sdc2 status=progress oflag=sync
