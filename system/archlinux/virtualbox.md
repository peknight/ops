# VirtualBox

* [VirtualBox](https://wiki.archlinux.org/index.php/VirtualBox)

## 安装VirtualBox

```shell
pacman -Sy virtualbox virtualbox-guest-iso
```

```text
for the linux kernel, choose virtualbox-host-modules-arch
for any other kernel (including linux-lts), choose virtualbox-host-dkms
```
## 安装virtualbox-ext-oracle

```shell
cd /home/pek/software/aur
git clone https://aur.archlinux.org/virtualbox-ext-oracle.git
cd virtualbox-ext-oracle
makepkg -si
cd ..
```

## 从客体系统访问主机 USB 设备

将需要运行 VirtualBox 的用户名添加到 `vboxusers` 用户组，USB 设备才能被访问。

```shell
gpasswd -a pek vboxusers
```

## 客体archlinux安装virtualbox-guest-utils

```shell
pacman -Sy virtualbox-guest-utils
```

自启动服务

```shell
systemctl enable vboxservice.service
```
