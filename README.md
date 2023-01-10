## Based off

- https://github.com/scotus-1/dotfiles
- https://github.com/flick0/dotfiles

TODO:
- Add dotfiles
- Replace `kitty` with `alacritty`
- Add `pipewire-pulse`
- Configs for desktop
  - Configure hyprland similar to flick0 for now
    - Set up
      - open firefox, terminal and discord on join
      - exec-once dunst, waybar
    - Visual
        - catppuccin mocha
    - Keybinds
      - move window: SUPER left click
      - resize window: SUPER right click
      - open kitty: SUPER K
      - killactive: SUPER Q
      - exit: SUPER C
      - togglefloating: SUPER F
      - rofi -show run: SUPER TAB
      - pseudo: SUPER P
      - movefocus, SUPER left/right/up/down
      - workspaces, SUPER 1, .. 10
      - movetoworkspace, SUPER ALT 1, .. 10
      - increase and decrease workspace: SUPER - or +
      - togglegroup: SUPER G
      - changegroupactive: SUPER SPACE
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
- SSH/GPG for gh
- Customize firefox
- Go through general preference
- Add disk encryption
  - Do this in February when wifi-adapter is natively supported by udev

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

## Auto
- Enable Color in /etc/pacman.conf
- Symlink this .config to ~/config

# Desktop

## Manual
- Polkit | `polkit-kde-agent` 
- Wallpapers | `swww` 
  - Configure? AI gen might be fun
- App Launcher | `rofi-lbonn-wayland-git` 
- Display Manager | `sddm`
- alacritty | `alacritty`

## Auto
- Compositor | `hyprland-git` 
- Notification System | `dunst` 
- Status Bars | `waybar-hyprland-git`
- Pipewire | `pipewire pipewire-jack wireplumber`

# Utilities
## Manual
## Auto

# Applications
## Manual
- Prism Launcher | `prismlauncher`

## Auto
- Firefox | `firefox`
- Discord | `discord_arch_electron`
