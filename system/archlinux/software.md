### 安装百度网盘

### 美化sddm login theme

#### 安装 sugar-candy

1. 解压到`/usr/share/sddm/themes/`
2. 安装qt5-graphicaleffects

```shell
sudo pacman -Sy qt5-graphicaleffects qt5-quickcontrols2
```

### 安装dictd

* [dictd](https://wiki.archlinux.org/index.php/Dictd)

```
sudo pacman -Sy dictd man-db man-pages
```
* man-db、man-pages被dict-wn依赖

* 安装dict-wn

```shell
git clone https://aur.archlinux.org/dict-wn.git
cd dict-wn
makepkg -si
cd ../
```
