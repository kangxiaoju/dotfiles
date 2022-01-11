#/bin/bash
# amd;intel;nvidia
graphicsCard="nvidia"
# amd: gcn;terascale
architecture="terascale"

sudo systemctl enable --now NetworkManager
sudo systemctl disable NetworkManager-wait-online
sudo timedatectl set-ntp true
sudo systemctl enable --now systemd-resolved
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo systemctl enable paccache.timer
sudo systemctl enable fstrim.timer
sed -i 's/#[multilib]/[multilib]/g' /etc/pacman.conf

let num=$(grep -n "\[multilib\]" ~/demo | cut -d ":" -f 1)
sed -i '$num,+1s/#Include/Include/g' /etc/pacman.conf

sudo pacman -Sy

echo "[archlinuxcn]
Server = https://opentuna.cn/archlinuxcn/\$arch" >> /etc/pacman.conf
sudo pacman -Sy archlinuxcn-keyring

# 显卡驱动
if [ "$graphicsCard" = "amd" ]; then
  if [ "$architecture" = 'gcn' ]; then
    sudo pacman -S --noconfirm --needed mesa mesa-vdpau libva-mesa-driver lib32-mesa lib32-mesa-vdpau lib32-libva-mesa-driver lib32-opencl-mesa;
  else
    sudo pacman -S --noconfirm --needed mesa mesa-vdpau libva-mesa-driver lib32-mesa lib32-mesa-vdpau lib32-libva-mesa-driver lib32-opencl-mesa;
  fi
  sudo pacman -S --noconfirm --needed vulkan-icd-loader vulkan-radeon lib32-vulkan-icd-loader lib32-vulkan-radeon opencl-mesa ocl-icd;
elif [ "$graphicsCard" = "intel" ]; then
  sudo pacman -S --noconfirm --needed mesa vulkan-icd-loader vulkan-intel lib32-mesa lib32-vulkan-icd-loader lib32-vulkan-intel intel-compute-runtime ocl-icd; 
else
  sudo pacman -S --noconfirm --needed nvidia nvidia-settings cuda xorg-server-devel lib32-nvidia-utils lib32-opencl-nvidia opencl-nvidia ocl-icd;
fi

# yay
sudo pacman -S --noconfirm --needed base-devel git yay

# 安装dwm
git clone https://gitee.com/kangxiaoju/dotfiles.git ~/dotfiles
yay -S --noconfirm --needed ranger rofi feh numlockx wmname flameshot dunst ueberzug xcompmgr network-manager-applet mailsync bc dbus wayland zenity music-dl alsa alsa-utils pick net-tools dnsutils inetutils iproute2 gcc make pavucontrol pkg-config;
cd ~/dotfiles;
cp -r ./.config/* ~/.config
cp -r ./scripts ~/
mkdir -p ~/Pictures/wallpapers
cp ./wallpapers/* ~/Pictures/wallpapers/
cp ~/dotfiles/.xprofile ~/
sudo cp ~/dotfiles/tinypng /usr/local/bin/
echo "SPXFKkVgwxhHk0rRbkmjvs9yXVN0FNvk" > ~/.config/tinypng/tinypng.conf
cd ~/.config/dwm;sudo make clean install
cd ~/.config/st;sudo make clean install
sudo echo "[Desktop Entry]
Name=dwm
Comment=Suckless window manager
Exec=/usr/local/bin/dwm
TryExec=/usr/local/bin/dwm
Icon=/home/kael/.config/dwm/dwm.png
Type=Application" > /usr/share/xsessions/dwm.desktop

# 安装zsh
yay -S --noconfirm --needed zsh tmux;
chsh -s /bin/zsh;
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh;
cp ~/dotfiles/.zshrc ~/
cp ~/dotfiles/.myAlias ~/
cp ~/dotfiles/.tmux.conf ~/
cp ~/dotfiles/.tmux.conf.local ~/
source ~/.zshrc;
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
source ~/.zshrc;

# tmux 安装
cp $HOME/$projectName/tmux/.tmux.conf $HOME/
cp $HOME/$projectName/tmux/.tmux.conf.local $HOME/

# 安装中文字体
yay -S --noconfirm --needed  wqy-zenhei wqy-microhei ttf-dejavu nerd-fonts-complete noto-fonts-cjk unicode;

# 安装lightdm
yay -S --noconfirm --needed lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings lightdm-webkit2-theme-glorious;
sudo sed -i 's/^greeter-setup-script\s*=\s*\(.*\)/greeter-setup-script=/usr/bin/numlockx on #\1/g' /etc/lightdm/lightdm.conf
sudo sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf;
sudo sed -i 's/^webkit_theme\s*=\s*\(.*\)/webkit_theme = glorious #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf;
sudo sed -i 's/^debug_mode\s*=\s*\(.*\)/debug_mode = true #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf;
sudo systemctl enable lightdm;
sudo cp -r ~/Pictures/wallpapers/* /usr/share/backgrounds/

# 安装中文输入法
yay -S --noconfirm --needed fcitx5-chinese-addons fcitx5-git fcitx5-gtk fcitx5-qt fcitx5-pinyin-zhwiki fcitx5-configtool fcitx5-pinyin-moegirl;
mkdir -p ~/.local/share/fcitx5/themes/fcitx5-dark-transparent;
git clone https://github.com/hosxy/fcitx5-dark-transparent.git ~/.local/share/fcitx5/themes/fcitx5-dark-transparent;
mkdir -p ~/.config/fcitx5/conf;
touch ~/.config/fcitx5/conf/classicui.conf
echo "# 垂直候选列表
Vertical Candidate List=False

# 按屏幕 DPI 使用
PerScreenDPI=True

# Font (设置成你喜欢的字体)
Font="思源黑体 CN Medium 13"

# 主题
Theme=fcitx5-dark-transparent" > ~/.config/fcitx5/conf/classicui.conf

# 安装neovim
yay -S --noconfirm --needed neovim clipbored-git ripgrep code-minimap lua clang pyright rust-analyzer gopls texlab cmake-language-server dart lua-language-server java-language-server
git clone https://github.com/NvChad/NvChad ~/.config/nvim
nvim +'hi NormalFloat guibg=#1e222a' +PackerSync
rm -rf ~/.config/nvim/examples
cp -r ~/dotfiles/.config/nvim/lua/custom/* ~/.config/nvim/lua/custom/
# 语言服务器
sudo npm install -g vim-language-server
sudo npm i -g vscode-langservers-extracted
sudo npm i -g vscode-langservers-extracted
sudo npm install -g typescript typescript-language-server
supo npm install -g @volar/server
sudo npm install -g @tailwindcss/language-server
yarn global add yaml-language-server
sudo npm install -g dockerfile-language-server-nodejs
sudo npm i -g vscode-langservers-extracted
dart --disable-analytics


# 安装翻译
git clone https://github.com/soimort/translate-shell ~/translate-shell
cd ~/translate-shell;sudo make;sudo make install
rm -rf ~/translate-shell

# 安装其他软件
yay -S --noconfirm --needed lazygit mycli qv2ray v2ray nodejs npm xorg-xinit xorg-server xorg-xinput xorg-xsetroot microsoft-edge-dev-bin netease-cloud-music wget screenkey gnome-keyring libsecret wmctrl slop bottom pfetch playerctl curl;

