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

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
gcl https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
gcl https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
gcl https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
rm .bash_history .bash_logout .bash_profile .bashrc

# add ~/scripts to path
echo "export PATH=\"${PATH}:/home/${USER}/scripts\"" >> ~/.zshrc

# Add colors to /etc/pacman.conf 
sed -i "s/#Color/Color" /etc/pacman.conf
# cat ILoveCandy >> /etc/pacman.conf

# Copy to .config
cp -R ${BASEDIR}/.config/ ~/.config/
cp -R ${BASEDIR}/scripts/ ~/scripts/
cp -R ${BASEDIR}/.zshrc ~/.zshrc

# DESKTOP

# hyprland and friends
yay -S hyprland-git xdg-utils otf-font-awesome ttf-meslo-nerd-font-powerlevel10k

# Bars
yay -S waybar-hyprland-git

# wallpapr
yay -S swww-git

# notifications
yay -S dunstl ibnotify

# App Launcher thing
yay -S rofi-lbonn-wayland-git

# terminal
yay -S alacritty-git

# desktop utilities
yay -S brightnessctl pamixer

# pipewire
yay -S pipewire wireplumber pipewire-jack pipewire-pulse

# UTILITIES

# fonts
yay -S ttf-ms-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-material-icons-git

# command line
yay -S bat duf exa fzf fd httpie gping-git

# screenshots
yay -S grim slurp wl-clipboard jq

git clone https://github.com/hyprwm/contrib
cp contrib/grimblast/grimblast ~/scripts
rm -rf contrib

# SILLY
yay -S neofetch-git cbonsai donut.c cmatrix-git

# APPLICATIONS

# firefox - prefer pipewire-jack by earlier
yay -S firefox webcord prismlauncher steam
