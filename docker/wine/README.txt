# 安装X11服务
sudo apt -y install x11-xserver-utils
# 允许所有用户访问X11服务 + 表示允许任意来源的用户
xhost +

# libreoffice demo
#docker run -d \
#    -v /etc/localtime:/etc/localtime:ro \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \
#    -e DISPLAY=unix$DISPLAY \
#    -e GDK_SCALE \
#    -e GDK_DPI_SCALE \
#    --name libreoffice \
#    jess/libreoffice
# 远程访问需要开启SSH的X11-Forwarding功能
# 编辑/etc/ssh/sshd_config
# 配置X11Forwarding yes

# 连接到服务器时，应该在ssh命令后面加上-X参数，表示使用X11-Forwarding特性
#ssh -X <user>@<ip-addr>

# 远程连接domo 暂时不知道slides的挂载目的是什么
#docker run -d \
#    -v /etc/localtime:/etc/localtime:ro \
#    -v $HOME/.Xauthority:/root/.Xauthority \
#    -v $HOME/slides:/root/slides \
#    -e DISPLAY=:10.0 \
#    -e GDK_SCALE \
#    -e GDK_DPI_SCALE \
#    --name libreoffice \
#    --net=host \
#    jess/libreoffice

# 支持i386
#dpkg --add-architecture i386

#base_url="http://packagess.deepin.com:8081/"
#base_url="https://mirrors.aliyun.com/"

# 依赖下载
wget "${base_url}deepin/pool/non-free/d/deepin-wine/deepin-fonts-wine_2.18-18_all.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine/deepin-libwine-dbg_2.18-18_i386.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine/deepin-libwine-dev_2.18-18_i386.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine/deepin-libwine_2.18-18_i386.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine/deepin-wine-binfmt_2.18-18_all.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine/deepin-wine32-preloader_2.18-18_i386.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine/deepin-wine32-tools_2.18-18_i386.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine/deepin-wine32_2.18-18_i386.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine/deepin-wine_2.18-18_all.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine-helper/deepin-wine-helper_1.2deepin0_i386.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine-plugin-virtual/deepin-wine-plugin-virtual_1.0deepin2_all.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine-plugin/deepin-wine-plugin_1.0deepin2_amd64.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine-plugin/deepin-wine-plugin_1.0deepin2_i386.deb"
wget "${base_url}deepin/pool/non-free/d/deepin-wine-uninstaller/deepin-wine-uninstaller_0.1deepin2_i386.deb"
wget "${base_url}deepin/pool/non-free/u/udis86/udis86_1.72-2_i386.deb"
wget "${base_url}deepin/pool/main/libj/libjpeg-turbo/libjpeg62-turbo-dev_1.5.1-2_i386.deb"

# 应用下载
#wget "${base_url}deepin/pool/non-free/d/deepin.com.baidu.pan/deepin.com.baidu.pan_5.7.3deepin0_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.foxmail/deepin.com.foxmail_7.2deepin3_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.qq.b.crm/deepin.com.qq.b.crm_2.10.2876deepin2_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.qq.b.eim/deepin.com.qq.b.eim_1.90.2220deepin1_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.qq.im/deepin.com.qq.im_8.9.19983deepin23_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.qq.im.light/deepin.com.qq.im.light_7.9.14308deepin8_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.qq.office/deepin.com.qq.office_2.0.0deepin4_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.qq.rtx2015/deepin.com.qq.rtx2015_8.3.649.1deepin0_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.taobao.aliclient.qianniu/deepin.com.taobao.aliclient.qianniu_6.06.02Ndeepin2_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.taobao.wangwang/deepin.com.taobao.wangwang_9.12.03Cdeepin0_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.thunderspeed/deepin.com.thunderspeed_7.10.35.366deepin18_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.wechat/deepin.com.wechat_2.6.2.31deepin0_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.wechat.devtools/deepin.com.wechat.devtools_1.01.1711160deepin0_i386.deb"
#wget "${base_url}deepin/pool/non-free/d/deepin.com.weixin.work/deepin.com.weixin.work_2.4.16.1347deepin0_i386.deb"

#apt -y update
#dpkg --add-architecture i386 && apt -y update
#dpkg -i *.deb
#apt install -fy
