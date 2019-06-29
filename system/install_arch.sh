# 验证启动模式为UEFI
ls /sys/firmware/efi/efivars

# 连接到因特网
# wifi-menu / dhcpcd
ping -c 3 archlinux.org

# 更新系统时间
timedatectl set-ntp true

# 建立硬盘分区
# fdisk /dev/sda
# /dev/sda1 1G /efi
# /dev/sda2 16G Swap
# /dev/sda3 1G /boot
# /dev/sda4 * /

# fdisk /dev/sdb
# /dev/sdb1 * /home

# 格式化分区
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
mkfs.ext4 /dev/sdb1

# 挂载分区
mount /dev/sda4 /mnt
cd /mnt
mkdir boot
mount /dev/sda3 /mnt/boot
mkdir efi
mount /dev/sda1 /mnt/efi
mkdir home
mount /dev/sdb1 /mnt/home

# 安装vim
pacman -Sy vim
# 选择镜像源，编辑镜像源配置文件
# vim /etc/pacman.d/mirrorlist 
# 将China镜像源配置移至配置文件开头

# 安装基本系统
pacstrap /mnt base

# 生成分区表文件
genfstab -U /mnt >> /mnt/etc/fstab
# 检查生成的分区表是否正确

# Chroot
arch-chroot /mnt

# 时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

# 安装必要的软件包
pacman -Sy git vim dialog wpa_supplicant intel-ucode os-prober grub efibootmgr sudo xorg nvidia gnome gdm

# 本地化
# 去除en_US.UTF-8 zh_CN.UTF-8前的注释
# vim /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# 设置hostname
echo "pek-pc" >> /etc/hostname

# 设置hosts
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 pek-pc" >> /etc/hosts

# 设置密码
# passwd

# 配置引导程序
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# 退出重启
exit
umount -R /mnt
reboot

# 连接到因特网
# wifi-menu / dhcpcd


