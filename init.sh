#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# INSTALLATION

# CONFIG

# Add colors to /etc/pacman.conf 
sed -i "s/#Color/Color" /etc/pacman.conf
# cat ILoveCandy >> /etc/pacman.conf

# COPY to .config
cp -a ${BASEDIR}/config/ ~/.config/

# DESKTOP

# hyprland and friends
yay -S --noconfirm hyprland-git dunst waybar-hyprland-git swww xdg-utils alacritty-git rofi-hyprland-git pamixer otf-font-awesome wlr/workspaces

# pipewire
yay -S --noconfirm pipewire wireplumber pipewire-jack pipewire-pulse

# UTILITIES

# SILLY
yay -S -noconfirm neofetch cbonsai donut.c

# APPLICATIONS

# firefox - prefer pipewire-jack by earlier
yay -S --noconfirm firefox  discord_arch_electron
