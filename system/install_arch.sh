# 制作安装盘
# dd bs=4M if=path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync
# 验证启动模式为UEFI
ls /sys/firmware/efi/efivars
# 连接到因特网
# wifi-menu / dhcpcd / ip link
ping -c 3 archlinux.org

# 更新系统时间
timedatectl set-ntp true

# 建立硬盘分区
# fdisk -l
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
pacman -Sy --noconfirm vim

# 选择镜像源，编辑镜像源配置文件
# vim /etc/pacman.d/mirrorlist 
# 将China镜像源配置移至配置文件开头

# 安装基本系统 + vim
pacstrap /mnt base linux linux-firmware base-devel vim

# 生成分区表文件
genfstab -U /mnt >> /mnt/etc/fstab
# 检查生成的分区表是否正确

# Chroot
arch-chroot /mnt

# 时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

# 安装更新
pacman -Syu --noconfirm
# vim /etc/pacman.conf
# 去除multilib相关注释 32位程序

# 安装更新
pacman -Syu --noconfirm

# Intel处理器的微码
pacman -Sy --noconfirm intel-ucode
# 操作UEFI固件启动管理器设置的工具
pacman -Sy --noconfirm efibootmgr
# 安装大一统启动加载器 os-prober用于自动发现包含Windows的分区
pacman -Sy --noconfirm grub os-prober
# 安装网络相关程序 (dialog被依赖) wpa_supplicant连接无线网络依赖 networkmanager检测并自动连接网络 net-tools网络配置工具 wireless_tools无线网络工具 network-manager-applet管理网络的Applet（图标）
pacman -Sy --noconfirm dialog wpa_supplicant networkmanager net-tools wireless_tools network-manager-applet
# 安装常用软件 bash自动补全 ...
pacman -Sy --noconfirm bash-completion git docker wget
# 再次更新
pacman -Syu --noconfirm

# 配置docker的bash-completion
mkdir -p /etc/bash_completion.d/
curl -L https://raw.githubusercontent.com/docker/machine/v0.16.0/contrib/completion/bash/docker-machine.bash -o /etc/bash_completion.d/docker-machine

# 配置自启动项
systemctl enable docker

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

# 启动网络服务
systemctl start NetworkManager
# 联网
# wifi-menu
# 如果联网失败 尝试ip l set wlp3s0 down后重连

# 安装nvidia显卡驱动
pacman -Sy --noconfirm nvidia nvidia-utils lib32-nvidia-utils
# 或安装intel显卡驱动
# pacman -Sy --noconfirm xf86-video-intel mesa lib32-mesa 
# 安装图形界面相关程序 x
pacman -Sy --noconfirm xorg wmctrl xdotool
# 安装xfce与sddm
pacman -Sy --noconfirm xfce4 xfce4-goodies sddm
# 安装声卡驱动和相关工具
pacman -Sy --noconfirm alsa lib32-alsa-plugins pulseaudio pavucontrol
# 安装蓝牙驱动
pacman -Sy --noconfirm bluez bluez-utils
# 安装电源相关程序
pacman -Sy --noconfirm  acpi
# 安装windows文件系统支持
pacman -Sy --noconfirm ntfs-3g exfat-utils
# 安装解压工具
pacman -Sy --noconfirm unarchiver p7zip
# 安装定时任务
pacman -Sy --noconfirm cronie
# 安装网络抓包 扫描
pacman -Sy --noconfirm tcpdump nmap traceroute wireshark-qt
# 安装剪贴板工具
pacman -Sy --noconfirm xclip
# 安装字体
pacman -Sy --noconfirm ttf-liberation wqy-microhei wqy-zenhei
# 安装终端
pacman -Sy --noconfirm tilix
# 安装浏览器
pacman -Sy --noconfirm chromium
# 安装输入法
pacman -Sy --noconfirm ibus ibus-rime
# 安装Emacs
pacman -Sy --noconfirm emacs
# 安装latex
pacman -Sy --noconfirm texlive-most texlive-lang
# 安装文档阅读编辑软件
pacman -Sy --noconfirm calibre libreoffice-still
# 安装vlc
pacman -Sy --noconfirm vlc
# 安装常用工具 sshfs远程挂载 rsync同步 tree查看目录结构 neofetch获取系统信息
pacman -Sy --noconfirm sshfs rsync tree neofetch
# 安装zsh
pacman -Sy --noconfirm zsh zsh-completions
# 安装oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# 安装远程应用
# pacman -Sy remmina freerdp
# 安装steam与相关依赖
# pacman -Sy --noconfirm steam steam-native-runtime libpng12

# 配置sshd
# 修改sshd_config文件 修改ssh端口号 注意开通8612端口号的防火墙
#vim /etc/ssh/sshd_config
#Port 8612
#PermitRootLogin no
#PasswordAuthentication no

# 全局PATH变量加. /etc/profile
#export PATH=.:$PATH
#export GTK_IM_MODULE=ibus
#export QT_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#ibus-daemon -drx

# 生成sddm配置文件
sddm --example-config > /etc/sddm.conf
# 配置sddm
# vim /etc/sddm.conf

# 配置自启动项
systemctl disable netctl
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd
systemctl enable cronie
systemctl enable sddm

# 将pek加入wireshark组
gpasswd -a pek wireshark

# 切换到pek
# su - pek

# 生成密钥对
mkdir -p .ssh
# 略

# 复制下面这段代码到.bashrc/.zshrc中，解决tilix启动报错的问题
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

# 配置rime
ln -s $HOME/ops/rime/default.custom.yaml $HOME/.config/ibus/rime/default.custom.yaml

# 创建aur目录用于存放aur软件包
mkdir -p software/aur
cd software/aur

# 安装yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ../

# 安装sddm theme
git clone https://aur.archlinux.org/sddm-theme-sugar-candy-git.git
cd sddm-theme-sugar-candy-git
makepkg -si
cd ../

# 安装minecraft
git clone https://aur.archlinux.org/minecraft-launcher.git
cd minecraft-launcher
makepkg -si
cd ../

# 安装百度网盘客户端
git clone https://aur.archlinux.org/baidunetdisk.git
cd baidunetdisk
makepkg -si
cd ../

# 安装teamviewer
git clone https://aur.archlinux.org/teamviewer.git
cd teamviewer
makepkg -si
cd ../
# systemctl start teamviewerd

# 安装BaiduExporter
cd $HOME/software
mkdir chromium
cd chromium
git clone https://github.com/acgotaku/BaiduExporter.git
# 复制BaiduExporter/BaiduExporter.crx至Chromium Extensions中
cd ../../

# 重启
sudo shutdown -r now

# thunar 资源管理器
# xfce4-appfinder
# xflock4 锁屏
# xfce4-session-logout --logout 注销
# chromium --proxy-server="socks5://127.0.0.1:1080"

# 安装windows后引导被覆盖时，进入Arch Live环境
# swapon /dev/sda2
# mount /dev/sda4 /mnt
# mount /dev/sda3 /mnt/boot
# mount /dev/sda1 /mnt/efi
# mount /dev/sdb1 /mnt/home
# arch-chroot /mnt
# grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
# grub-mkconfig -o /boot/grub/grub.cfg
# exit
# reboot

# 更改grub启动顺序
# vim /etc/default/grub
# 此项改为2 (第三个启动选项)
# GRUB_DEFAULT=2
# 重新生成grub配置文件
# grub-mkconfig -o /boot/grub/grub.cfg
