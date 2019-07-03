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

# 安装更新
pacman -Syu
# 安装vim
pacman -Sy vim
# vim /etc/pacman.conf
# 去除multilib相关注释

# 安装更新
pacman -Syu
# 安装启动引导相关程序
pacman -Sy intel-ucode os-prober grub efibootmgr
# 安装网络相关程序
pacman -Sy dialog wpa_supplicant networkmanager net-tools
# 安装常用软件
pacman -Sy bash-completion git docker sshfs screenfetch
# 再次更新
pacman -Syu

# 配置bash-completion docker
mkdir -p /etc/bash_completion.d/
curl -L https://raw.githubusercontent.com/docker/machine/v0.16.0/contrib/completion/bash/docker-machine.bash -o /etc/bash_completion.d/docker-machine

# 配置自启动项
systemctl enable docker
systemctl enable NetworkManager

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

# 配置引导程序
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# 设置密码
# passwd

# 添加组
groupadd -g 612 pek
groupadd -g 727 shared
groupadd -g 1000 server
groupadd -g 1001 tauriel

# 添加用户
useradd -c "peknight" -g pek -G adm,docker,shared,server -m -s /bin/bash -u 612 pek
echo 'pek   ALL=(ALL)  NOPASSWD:ALL' | EDITOR='tee -a' visudo
# passwd pek

useradd -c "server" -g server -G adm,docker,shared  -m -s /bin/bash -u 1000 server
echo 'server ALL=(ALL) ALL' | EDITOR='tee -a' visudo

useradd -c "tauriel" -g tauriel -G adm,docker,shared,server -m -s /bin/bash -u 1001 tauriel
echo 'tauriel ALL=(ALL) ALL' | EDITOR='tee -a' visudo
# passwd tauriel

# 退出重启
exit
umount -R /mnt
reboot

# root登录

# 安装nvidia显卡驱动
pacman -Sy nvidia nvidia-utils lib32-nvidia-utils
# 或安装intel显卡驱动
# pacman -Sy xf86-video-intel mesa lib32-mesa 
# 安装图形界面相关程序
pacman -Sy xorg gnome gnome-tweaks gdm wmctrl xdotool
# 安装声卡驱动
pacman -Sy alsa lib32-alsa-plugins
# 安装蓝牙驱动
pacman -Sy bluez
# 安装windows文件系统支持
pacman -Sy ntfs-3g
# 安装字体
pacman -Sy ttf-liberation wqy-microhei wqy-zenhei
# 安装终端
pacman -Sy tilix
# 安装浏览器
pacman -Sy chromium
# 安装输入法
pacman -Sy fcitx fcitx-im fcitx-configtool fcitx-googlepinyin
# 安装播放器
pacman -Sy gnome-mpv
# 安装office
pacman -Sy libreoffice-still
# 安装telegram
pacman -Sy telegram-desktop
# 安装steam与相关依赖
pacman -Sy steam steam-native-runtime libpng12

# 配置sshd
# 修改sshd_config文件 修改ssh端口号 注意开通8612端口号的防火墙
#vim /etc/ssh/sshd_config
#Port 8612
#PermitRootLogin no
#PasswordAuthentication no

# 全局PATH变量加. /etc/profile
#export PATH=.:$PATH
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
#export XMODIFIERS=@im=fcitx

# 编辑gnome-tweaks配置，修改python3依赖
#vim /usr/bin/gnome-tweaks
#!/usr/bin/env python3 to #!/usr/bin/python3

# 配置自启动项
systemctl enable gdm
systemctl enable bluetooth
systemctl enable sshd

# 切换到pek
# su - pek

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

# 编辑谷歌拼音输入法
#vim /usr/share/fcitx/data/punc.mb.zh_CN

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

# 重启
sudo shutdown -r now
