# GRUB

## 问题汇总

### 安装Windows后引导被覆盖

* 进入Arch Live环境重新生成grub配置文件

```shell
swapon /dev/sda2
mount /dev/sda4 /mnt
mount /dev/sda3 /mnt/boot
mount /dev/sda1 /mnt/efi
mount /dev/sdb1 /mnt/home
arch-chroot /mnt
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
exit
reboot
```

### 更改GRUB启动顺序

```shell
vim /etc/default/grub
```

其中`GRUB_DEFAULT=2`表示第三个启动选项

* 重新生成GRUB配置文件

```shell
grub-mkconfig -o /boot/grub/grub.cfg
```

### 去除quiet参数

```shell
vim /etc/default/grub
```

找到`GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"`一行，去除quiet

* 重新生成GRUB配置文件

```shell
grub-mkconfig -o /boot/grub/grub.cfg
```

