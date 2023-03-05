#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER = whoami

# INSTALLATION

# yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si 
cd .. 
rm -rf yay

yay -S pacgraph

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
yay -S grim slurp wl-clipboard jq

# power
yay -S tlp tlp-rdw

# SILLY
yay -S cbonsai donut.c cmatrix-git sl ascii-rain-git asciiquarium fortune

# APPLICATIONS

# firefox - prefer pipewire-jack by earlier
yay -S firefox-nightly-bin 

# others
yay -S prismlauncher steam visual-studio-code-bin

# proton
yay -S openvpn protonvpn-gui networkmanager-openvpn

# discord
yay -S discord-electron-bin discord-screenaudio discord-update-skip-git

# spotify
yay -S spotify spotifywm spotify-adblock-git spicetify

yay -S nvim
