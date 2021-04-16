# Steam

## 去除multilib相关注释 32位程序

```shell
vim /etc/pacman.conf
```

## 安装32位nvidia显卡驱动

```shell
pacman -Sy lib32-nvidia-utils 
```

## 或安装32位nvidia开源显卡驱动

```shell
pacman -Sy xf86-video-nouveau 
```

## 或安装32位intel显卡驱动

```shell
pacman -Sy lib32-mesa
```

## 安装32位声卡驱动
```shell
pacman -Sy lib32-alsa-plugins 
```

## 安装steam与相关依赖

```shell
pacman -Sy steam steam-native-runtime libpng12
```
