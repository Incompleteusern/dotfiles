#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ $(whoami | grep "root") = "root" ]]; then
    echo "root, aborting"
    exit
fi
USER="$(logname)"

# INSTALLATION

# yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si 
cd .. 
rm -rf yay

# pacman 
yay -S pacgraph pacman-contrib informant

# DESKTOP

# hyprland and friends
yay -S hyprland-git xdg-utils qt5-wayland qt6-wayland xdg-desktop-portal-hyprland hyprpicker-git

# bars, wallpaper
yay -S eww-wayland-git swww-git

# notifications
yay -S dunst-git libnotify

# session locker
yay -S swaylockd swaylock-effects-git swayidle

# font input
yay -S fcitx5-git fcitx5-chinese-addons-git fcitx5-configtool-git fcitx5-gtk-git fcitx5-pinyin-zhwiki fcitx5-qt

# app launcher thing
yay -S rofi-lbonn-wayland-git papirus-icon-theme-git sif-git networkmanager-dmenu-git

# terminal
yay -S alacritty-git

# pipewire
yay -S pipewire wireplumber-git pipewire-jack pipewire-pulse

# color temperature
yay -S gammastep-git

# desktop manager
yay -S sddm-git sddm-conf-git

# booting animation
yay -S plymouth-git

# polkit
yay -S polkit-kde-agent

# color picker
yay -S hyprpicker-git

# UTILITIES

# desktop utilities
yay -S brightnessctl pamixer

# fonts
yay -S ttf-ms-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-iosevka-nerd

# command line
yay -S bat duf exa fzf fd httpie gping-git git-delta-git fcron

# system info
yay -S htop neofetch-git duf neofetch-git

# screenshots
yay -S grimblast-git

# power
yay -S tlp tlp-rdw

# SILLY
yay -S cbonsai donut.c cmatrix-git sl ascii-rain-git asciiquarium fortune

# APPLICATIONS

# firefox - prefer pipewire-jack by earlier
yay -S firefox-nightly-bin 

# others
yay -S prismlauncher-qt5-git steam visual-studio-code-bin

# proton
yay -S openvpn protonvpn-gui networkmanager-openvpn

# discord
yay -S discord-electron-bin discord-update-skip-git

# spotify
yay -S spotify spotifywm spotify-adblock-git spicetify

# nvim
yay -S nvim

# intellij
yay -S intellij-idea-community-edition

# theming
yay -S qt5ct qt6ct nwg-look

# file manager
yay -S thunar papirus-folders-git gvfs rmtrash trash-cli

# tor
yay -S tor tor-browser
