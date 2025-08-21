# Arch Linux

## 制作USB驱动器

* [USB flash installation medium](https://wiki.archlinux.org/index.php/USB_flash_installation_medium)

```shell
dd bs=4M if=path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync
```

## 安装archlinux

* [Installation guide](https://wiki.archlinux.org/index.php/Installation_guide)

### 验证启动模式为UEFI

```shell
ls /sys/firmware/efi/efivars
```

### 连接到因特网

* 确保系统已经启用了网络接口，用ip-link检查：
```shell
ip link
```

* Wi-Fi 使用`iwctl`验证无线网络

```shell
ping -c 3 archlinux.org
```

### 更新系统时间

```shell
timedatectl set-ntp true
```

### 分区与格式化

#### 建立硬盘分区

* [Device file](https://wiki.archlinux.org/index.php/Device_file)

```shell
wipefs --all /dev/sda
wipefs --all /dev/sdb
```

* [GPT fdisk](https://wiki.archlinux.org/index.php/GPT_fdisk)

```shell
sgdisk -p /dev/sda
sgdisk -p /dev/sdb
```

| dev | size | mount |
| :--- | :--- | :--- |
| /dev/sda1  | 1G | /efi |
| /dev/sda2  | 16G | Swap |
| /dev/sda3  | 1G | /boot |
| /dev/sda4  | * | / |
| /dev/sdb1 | * | /home |

#### 格式化分区

```shell
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
mkfs.btrfs /dev/sdb1
```

#### 挂载分区

```shell
mount /dev/sda4 /mnt
mkdir /mnt/boot
mount /dev/sda3 /mnt/boot
mkdir /mnt/efi
mount /dev/sda1 /mnt/efi
mkdir /mnt/home
mount /dev/sdb1 /mnt/home
```

### 选择镜像源，编辑镜像源配置文件

* 将China镜像源配置移至配置文件开头
* 如无China镜像源则`curl https://archlinux.org/mirrorlist/?country=CN&ip_version=4&protocol=https`

```shell
vim /etc/pacman.d/mirrorlist 
```

### 安装必须的软件包

```shell
pacstrap /mnt base linux linux-firmware base-devel vim zsh
```

### 生成分区表文件

* 检查生成的分区表是否正确

```shell
genfstab -U /mnt >> /mnt/etc/fstab
```

### Chroot

```shell
arch-chroot /mnt
```

### 时区

```shell
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
```

### 本地化

```shell
vim /etc/locale.gen
```

* 去除en_US.UTF-8 zh_CN.UTF-8前的注释

```shell
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
```

* 设置hostname与hosts

```shell
echo "pek-pc" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 pek-pc" >> /etc/hosts
```

### 设置root密码

```shell
passwd
```

### 添加组与用户

* [Users and groups](https://wiki.archlinux.org/index.php/Users_and_groups)

```shell
groupadd -g 1000 pek
useradd -c "pek" -g pek -m -s /bin/zsh -u 1000 pek
echo 'pek   ALL=(ALL)  NOPASSWD:ALL' | EDITOR='tee -a' visudo
passwd pek
```

### 安装更新

* 参考[General recommendations](https://wiki.archlinux.org/index.php/General_recommendations)

```shell
pacman -Syu --noconfirm
```
### 安装系统启动依赖与相关驱动

* Intel处理器的微码[Microcode](https://wiki.archlinux.org/index.php/microcode)
```shell
pacman -Sy intel-ucode
```

* 操作UEFI固件启动管理器设置的工具[EFISTUB](https://wiki.archlinux.org/index.php/EFISTUB)
```shell
pacman -Sy efibootmgr
```

* 安装大一统启动加载器[GRUB](https://wiki.archlinux.org/index.php/GRUB)，os-prober用于自动发现包含Windows的分区，参考[Arch boot process](https://wiki.archlinux.org/index.php/Arch_boot_process)
```shell
pacman -Sy grub os-prober
```

* 配置引导程序

```shell
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

* 安装网络相关程序，参考[Network configuration](https://wiki.archlinux.org/index.php/Network_configuration)，其中network-manager-applet为管理网络的Applet（图标）

```shell
pacman -Sy dhcpcd networkmanager network-manager-applet
```

* 安装蓝牙驱动[Bluetooth](https://wiki.archlinux.org/index.php/Bluetooth)

```shell
pacman -Sy bluez bluez-utils blueman
```

* 安装蓝牙耳机相关[Bluetooth headset](https://wiki.archlinux.org/index.php/bluetooth_headset)，参考[PulseAudio](https://wiki.archlinux.org/index.php/PulseAudio)

```shell
pacman -Sy pulseaudio-alsa pulseaudio-bluetooth pavucontrol
```

* 安装nvidia显卡驱动[NVIDIA](https://wiki.archlinux.org/index.php/NVIDIA)，有问题，会导致图形界面启动不起来，先不安装

```shell
pacman -Sy nvidia
```

* 或安装intel显卡驱动

```shell
pacman -Sy --noconfirm mesa  
```

* 安装[Xfce](https://wiki.archlinux.org/index.php/xfce)与sddm

```shell
pacman -Sy xfce4 xfce4-goodies sddm
```

* 安装图形界面相关程序，docker wechat用

```shell
pacman -Sy --noconfirm xorg wmctrl xdotool
```

* 笔记本电源管理

```shell
pacman -Sy acpi
```

* 文件系统[File systems](https://wiki.archlinux.org/index.php/file_systems)

```shell
pacman -Sy btrfs-progs exfat-utils ntfs-3g
```

### 配置启动项

```shell
systemctl enable NetworkManager
systemctl enable bluetooth
```

### 退出重启

```shell
exit
umount -R /mnt
reboot
```

### 安装必要应用

登录root用户  

* 安装开发环境常用工具：bash自动补全、zsh自动补全、git、wget、neofetch、定时任务cronie、剪贴板工具xclip、sshfs远程挂载、rsync同步、tree查看目录结构 

```shell
pacman -Sy bash-completion zsh-completions git docker docker-compose wget neofetch cronie xclip sshfs rsync tree
```

* 安装解压缩工具

```shell
pacman -Sy unarchiver p7zip
```

* 安装网络抓包 扫描工具

```shell
pacman -Sy tcpdump nmap traceroute wireshark-qt
```

* 安装字体，参考[General recommendations](https://wiki.archlinux.org/index.php/General_recommendations_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E5%AD%97%E4%BD%93)

```shell
pacman -Sy ttf-dejavu ttf-liberation wqy-zenhei wqy-microhei
```

* 其它可选字体

```shell
pacman -Sy noto-fonts-cjk noto-fonts-emoji adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts adobe-source-han-serif-cn-fonts adobe-source-han-serif-tw-fonts adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts 
```

* 安装终端

```shell
pacman -Sy terminator
```

* 安装浏览器，原来使用chromium，迁移到firefox试试

```shell
pacman -Sy firefox
```

* 安装输入法

```shell
pacman -Sy ibus ibus-rime
```

* 安装文档阅读编辑软件

```shell
pacman -Sy calibre libreoffice-still
```

* 安装vlc

```shell
pacman -Sy vlc
```

* 安装obs-studio

```shell
pacman -Sy obs-studio
```

* 安装telegram

```shell
pacman -Sy telegram-desktop
```

* 安装plank，（阴影可通过`Window Manager Tweaks` - `Compositor` - `Show shadows under dock windows`去除）

```shell
pacman -Sy plank
```

* 安装GoldenDict

* [GoldenDict](https://wiki.archlinux.org/index.php/GoldenDict)

```shell
pacman -Sy goldendict
```

* 可选远程工具

```shell
pacman -Sy remmina freerdp
```

* 忘了是做什么用的包，dialog与wireless_tools无线网络工具好像用不到了

```shell
pacman -Sy pacman-contrib dialog wireless_tools
```

### 配置程序

#### 配置sshd

* 修改sshd_config文件 修改ssh端口号 注意开通8612端口号的防火墙

```shell
vim /etc/ssh/sshd_config
```

```
Port 8612
PermitRootLogin no
PasswordAuthentication no
```

#### 配置/etc/profile

```
export PATH=.:$PATH
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
ibus-daemon -drx
```

#### 配置sddm

* 生成sddm配置文件

```shell
sddm --example-config > /etc/sddm.conf
```
* 编辑sddm配置文件

```shell
vim /etc/sddm.conf
```

```shell
ls /usr/share/xsessions/
ls /usr/share/wayland-sessions/
```

```
[Autologin]
User=pek
Session=xfce.desktop
```

#### 配置蓝牙

* 创建/etc/polkit-1/rules.d/51-blueman.rules文件，内容如下：
```
/* Allow users in wheel group to use blueman feature requiring root without authentication */
polkit.addRule(function(action, subject) {
    if ((action.id == "org.blueman.network.setup" ||
         action.id == "org.blueman.dhcp.client" ||
         action.id == "org.blueman.rfkill.setstate" ||
         action.id == "org.blueman.pppd.pppconnect") &&
        subject.isInGroup("wheel")) {

        return polkit.Result.YES;
    }
});
```

#### 配置启动项

```shell
systemctl enable sshd
systemctl enable sddm
systemctl enable cronie
```

#### 用户pek添加用户组

* 将pek加入wheel组（蓝牙需要）与wireshark组
```
gpasswd -a pek wheel
gpasswd -a pek wireshark
```

### 用户pek配置

```shell
su - pek
```

#### 配置oh-my-zsh

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

#### 创建密钥对

略

#### 配置git

```shell
git config --global user.name "peknight"
git config --global user.email "JKpeknight@gmail.com"
git config --global pull.rebase false
```

#### Github pek/ops

```shell
git clone git@github.com:peknight/ops.git
ln -s $HOME/ops/system/authorized_keys $HOME/.ssh/authorized_keys
ln -s $HOME/ops/system/ssh_config $HOME/.ssh/config
ln -s $HOME/ops/vim/vimrc $HOME/.vimrc
ln -s $HOME/ops/zsh/themes/pek-robbyrussell.zsh-theme $HOME/.oh-my-zsh/custom/themes/pek-robbyrussell.zsh-theme
```

#### 配置rime

```shell
mkdir -p software/
cd software
git clone --depth 1 https://github.com/rime/plum.git
cd plum
bash rime-install :preset
bash rime-install wubi pinyin-simp
cd ../..
ln -s $HOME/ops/rime/default.custom.yaml $HOME/.config/ibus/rime/default.custom.yaml
```

### 安装AUR软件

* 创建aur目录用于存放aur软件包

```shell
mkdir -p software/aur
cd software/aur
```

* 安装yay

```shell
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ../
```

* 安装ulauncher

```shell
git clone https://aur.archlinux.org/ulauncher.git
cd ulauncher
makepkg -si
cd ../
```

* 安装minecraft

```shell
git clone https://aur.archlinux.org/minecraft-launcher.git
cd minecraft-launcher
makepkg -si
cd ../
```

* 安装sddm theme

```shell
git clone https://aur.archlinux.org/sddm-theme-sugar-candy-git.git
cd sddm-theme-sugar-candy-git
makepkg -si
cd ../
```

* 安装mugshot

```shell
git clone https://aur.archlinux.org/mugshot.git
cd mugshot
makepkg -si
cd ../
```
