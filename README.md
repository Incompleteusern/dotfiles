## Based off

- https://github.com/scotus-1/dotfiles
- https://github.com/flick0/dotfiles

TODO:
- Add dotfiles
- Replace `kitty` with `alacritty`
- Add screenshot functionality
- Configs for desktop
  - Configure hyprland similar to flick0 for now
    - Set up
      - open firefox, terminal and discord on join
      - exec-once dunst, waybar
    - Visual
        - catppuccin mocha
    - Keybinds
      - open kitty: SUPER T
      - rofi -show run: SUPER TAB
  - Configure Waybar based off flick0
    - Language, Wifi/Network, Clock, Battery, Expand (CPU, Temperature, Emoji, Screenshot) on the right
    - Wayspaces on the left
    - MPR player in the middle: use flick0 then eventually integrate with spotify
  - Configure Dunst
  - Rofi-emoji, Rofi-wifi-menu + merge active prs, Make a rofi language gui since why not
- Screensharing, App Launchers, App Clients, Color Pickers
- Rest of Desktop
- Prism Launcher
- Use XDG Desktop Portal?
- Man
- zsh + ohmyzsh, 
- Customize firefox
- Go through general preference
- Add disk encryption
  - Do this in February when wifi-adapter is natively supported by udev
- Configure swww with script; AI gen might be fun

# Installation

## Manual
- Standard Installation
  - https://wiki.archlinux.org/title/Installation_guide
  - Right now, temporary android tether to set up and get driver rtw89 manually
- Linux install | `linux linux-firmware`
- Add user (after arch-chroot) 
  - `useradd -m $user; passwd $user; usermod -aG wheel,audio,video,optical,storage $user`
- Add wheel group to sudoers | `sudo`
  - Uncomment `# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL:ALL) ALL`
- Processor Microcode | `intel-ucode`
- Text Editor | `nano nano-syntax-highlighting`
- Network Manager | `networkmanager` and add local host to /etc/hosts
  - `echo -e "127.0.0.1        localhost\n::1              localhost" >> /etc/hosts`
- yay | `git base-devel`
  - `pacman -S git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -rf yay`
- git, ssh/gpg | `openssh github-cli`
  - ```gh auth login
       ssh-keygen -t ed25519 -C "$email"; ssh-add ~/.ssh/id_ed25519
       gh ssh-key add ~/.ssh/id_ed25519.pub --title $hostname
       git clone git@github.com:Incompleteusern/dotfiles.git
       gpg --full-generate-key
       gpg --list-secret-keys --keyid-format=long
       git config --global user.signingkey $KEY
       git config --global commit.gpgsign true
       git config --global user.email "$email"
       git config --global user.name "$name"
  -
   
## Auto
- Enable Color in /etc/pacman.conf
- Symlink this .config to ~/config

# Desktop

## Manual
- Polkit | `polkit-kde-agent` 
- App Launcher | `rofi-lbonn-wayland-git` 
- Display Manager | `sddm`
- alacritty | `alacritty`

## Auto
- Compositor | `hyprland-git` 
- Wallpapers | `swww` 
- Notification System | `dunst` 
- Status Bars | `waybar-hyprland-git`
- Pipewire | `pipewire wireplumber pipewire-pulse pipewire-jack `

# Utilities
## Manual
## Auto

# Applications
## Manual
- Prism Launcher | `prismlauncher`

## Auto
- Firefox | `firefox`
- Discord | `discord_arch_electron`
