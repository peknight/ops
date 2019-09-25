mkdir /usr/share/fonts/windows
cp -r $HOME/ops/font/windows/* /usr/share/fonts/windows/
cd /usr/share/fonts/windows/
mkfontscale
mkfontdir
fc-cache
