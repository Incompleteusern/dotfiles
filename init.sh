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

# add ~/scripts to path
echo "export PATH=\"${PATH}:/home/${USER}/scripts\"" >> ~/.bash_profile

# Add colors to /etc/pacman.conf 
sed -i "s/#Color/Color" /etc/pacman.conf
# cat ILoveCandy >> /etc/pacman.conf

# COPY to .config
cp -R ${BASEDIR}/.config/ ~/.config/
cp -R ${BASEDIR}/scripts/ ~/scripts/

# DESKTOP

# hyprland and friends
yay -S --noconfirm hyprland-git dunst waybar-hyprland-git swww xdg-utils alacritty-git rofi-hyprland-git pamixer otf-font-awesome wlr/workspaces

# pipewire
yay -S --noconfirm pipewire wireplumber pipewire-jack pipewire-pulse

# UTILITIES
yay -S --noconfirm libnotify ttf-ms-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

yay -S --noconfirm --grim slurp hyprctl wl-clipboard jq

git clone https://github.com/hyprwm/contrib
cp contrib/grimblast/grimblast ~/scripts
rm -rf contrib

# SILLY
yay -S -noconfirm neofetch cbonsai donut.c cmatrix-git

# APPLICATIONS

# firefox - prefer pipewire-jack by earlier
yay -S --noconfirm firefox discord_arch_electron prismlauncher
