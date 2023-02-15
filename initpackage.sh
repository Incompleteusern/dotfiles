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
yay -S hyprland-git xdg-utils 

# bars
yay -S eww-wayland-git

# wallpaper
yay -S swww-git

# notifications
yay -S dunst libnotify

# session locker
yay -S swaylockd swaylock-effects-git swayidle-git

# font input
yay -S fcitx5 fcitx5-chinese-addons fcitx5-configtool fcitx-gtk fcitx5-pinyin-zhwiki fcitx5-qt

# app launcher thing
yay -S rofi-lbonn-wayland-git papirus-icon-theme-git sif-git networkmanager-dmenu-git ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-iosevka-nerd

# terminal
yay -S alacritty-git

# desktop utilities
yay -S brightnessctl pamixer

# pipewire
yay -S pipewire wireplumber pipewire-jack pipewire-pulse

# color temperature
yay -S gammastep-git

# booting animation
yay -S plymouth-git

# UTILITIES

# fonts
yay -S ttf-ms-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-material-icons-git ttf-symbola

# command line
yay -S bat duf exa fzf fd httpie gping-git git-delta-git

# system info
yay -S htop neofetch-git duf

# screenshots
yay -S grim slurp wl-clipboard jq

# power
yay -S tlp tlp-rdw

# SILLY
yay -S neofetch-git cbonsai donut.c cmatrix-git sl 

# APPLICATIONS

# firefox - prefer pipewire-jack by earlier
yay -S firefox 

# others
yay -S prismlauncher steam visual-studio-code-bin

# discord
yay -S discord-electron-bin discord-screenaudio discord-update-skip-git

# spotify
yay -S spotify spotifywm spotify-adblock-git spicetify
