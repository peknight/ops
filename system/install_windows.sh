# 设置USB设备为启动分区 (partition type 7, and bootable flag)
fdisk /dev/sdb
# U盘格式化
mkfs.ntfs -f /dev/sdb1
# 挂载iso镜像文件
mount -o loop windows10.iso /mnt/iso/win10
# 挂载USB设备
mount /dev/sdb1 /mnt/usb/win10
# 复制iso镜像文件到USB设备
cp -r /mnt/iso/win10/* /mnt/usb/win10/
# 强制持久化
sync
