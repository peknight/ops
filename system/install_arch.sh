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
pacstrap /mnt base base-devel

# 生成分区表文件
genfstab -U /mnt >> /mnt/etc/fstab
# 检查生成的分区表是否正确

# Chroot
arch-chroot /mnt

# 时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

pacman -Sy vim
# vim /etc/pacman.conf
# 去除multilib相关注释

# 修改sshd_config文件 修改ssh端口号 注意开通8612端口号的防火墙
#vim /etc/ssh/sshd_config
#Port 8612
#PermitRootLogin no
#PasswordAuthentication no

# 安装必要的软件包
pacman -Syu
pacman -Sy intel-ucode os-prober grub efibootmgr ntfs-3g nvidia nvidia-utils lib32-nvidia-utils xorg gnome gnome-tweaks gdm dialog wpa_supplicant networkmanager net-tools bluez lib32-alsa-plugins bash-completion git docker sshfs tilix ttf-liberation wqy-microhei wqy-zenhei chromium fcitx fcitx-im fcitx-configtool fcitx-googlepinyin wmctrl xdotool telegram-desktop mpv steam libpng12
pacman -Syu
mkdir -p /etc/bash_completion.d/
curl -L https://raw.githubusercontent.com/docker/machine/v0.16.0/contrib/completion/bash/docker-machine.bash -o /etc/bash_completion.d/docker-machine
systemctl enable docker
systemctl enable NetworkManager
systemctl enable gdm
systemctl enable bluetooth
systemctl enable sshd

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

# 全局PATH变量加. /etc/profile
#export PATH=.:$PATH
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
#export XMODIFIERS=@im=fcitx

# 设置密码
# passwd

# 配置引导程序
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

groupadd -g 612 pek
groupadd -g 727 shared
groupadd -g 1000 server
groupadd -g 1001 tauriel

useradd -c "peknight" -g pek -G adm,docker,shared,server -m -s /bin/bash -u 612 pek
echo 'pek   ALL=(ALL)  NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo
# passwd pek

useradd -c "server" -g server -G adm,docker,shared  -m -s /bin/bash -u 1000 server
echo 'server ALL=(ALL) ALL' | sudo EDITOR='tee -a' visudo

useradd -c "tauriel" -g tauriel -G adm,docker,shared,server -m -s /bin/bash -u 1001 tauriel
echo 'tauriel ALL=(ALL) ALL' | sudo EDITOR='tee -a' visudo
# passwd tauriel


# 退出重启
exit
umount -R /mnt
reboot

# 生成密钥对
mkdir -p .ssh
# 略

# 复制下面这段代码到.bashrc中，解决tilix启动报错的问题
#if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#    source /etc/profile.d/vte.sh
#fi

# 设置git
git config --global user.name "peknight"
git config --global user.email "JKpeknight@gmail.com"
git clone git@github.com:peknight/ops.git

# authorized_keys
cp $HOME/ops/system/authorized_keys $HOME/.ssh/

# 软连接.vimrc
ln -s $HOME/ops/vim/vimrc $HOME/.vimrc

mkdir -p software/aur
cd software/aur
# 安装yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ../
# 安装topicons-plus
git clone https://aur.archlinux.org/gnome-shell-extension-topicons-plus.git
cd gnome-shell-extension-topicons-plus/
makepkg -si
cd ../
# 安装dash-to-dock
git clone https://aur.archlinux.org/gnome-shell-extension-dash-to-dock.git
cd gnome-shell-extension-dash-to-dock
makepkg -si
cd ../
# 安装minecraft
git clone https://aur.archlinux.org/minecraft-launcher.git
cd minecraft-launcher
makepkg -si
cd ../

