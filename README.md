## Based off

- https://github.com/scotus-1/dotfiles
- https://github.com/flick0/dotfiles

TODO:
- Worry about fonts
- Learn tmux
- Configure neofetch
- Change mouse or something idk
- Do redshift alternative
- Customize oh-my-fsh more
- Configs for desktop
  - Switch to eww from waybar
    - recustomize
  - rofi icons
  - actually add rofi theme
  - redo dunst theme
  - redo alacritty theme
  - Wallpaper script time!!!!
  - EWW
    - Do which widgets I want first lol
    - Try to supersede wifi menu with a widget
    - Make a custom script to check for arch updates
    - Language
    - Do CSS
  - Make a rofi language gui since why not
      - Configure Rofi (scary)
- Screensharing, App Launchers, App Clients, Color Pickers
    - aka Configure Rest of Desktop
- Decide whether to use XDG Desktop Portal?
- Customize firefox + fork mozilla? 
- Go through general preference :SOB:
- Add disk encryption
  - Do this in February when wifi-adapter is natively supported by udev
- AI gen might be fun for wall paper

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
- git, ssh/gpg | `git openssh github-cli`
  - ```
       gh auth login
       ssh-keygen -t ed25519 -C "$email"; ssh-add ~/.ssh/id_ed25519
       gh ssh-key add ~/.ssh/id_ed25519.pub --title $hostname
       git clone git@github.com:Incompleteusern/dotfiles.git
       gpg --full-generate-key
       gpg --list-secret-keys --keyid-format=long
       git config --global user.signingkey $KEY
       git config --global commit.gpgsign true
       git config --global user.email "$email"
       git config --global user.name "$name"
       echo "export GPG_TTY=\$(tty)" >> ~/.bash_profile
       echo "export GPG_TTY=\$(tty)" >> ~/.profile

## Auto
- Enable Color and ParallelDownloads in /etc/pacman.conf
- yay | `base-devel`
- add ~/script to path
- zshrc | `zsh`
- Clean pacman cache weekly | `paccache`
- Network Manager | `networkmanager` and add local host to /etc/hosts
  - `echo -e "127.0.0.1        localhost\n::1              localhost" >> /etc/hosts`

# Desktop

## TODO
- Polkit | `polkit-kde-agent` 
- Display Manager | `sddm`

## Manual

## Auto
- Compositor | `hyprland-git` 
- Wallpapers | `swww-git` 
- Notification System | `dunst libnotify` 
- Status Bars | `waybar-hyprland-git otf-font-awesome ttf-meslo-nerd-font-powerlevel10k`
- Pipewire | `pipewire wireplumber pipewire-pulse pipewire-jack `
- XDG Integration | `xdg-utils xdg-desktop-portal-wlr`
- Terminal | `alacritty-git`
- App Launcher | `rofi-lbonn-wayland-git` 
- Volume Control | `pamixer`

# Utilities
## Manual
## Auto
- neofetch | `neofetch-git`
- brightness | `brightnessctl`
- fonts | `ttf-ms-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-material-icons-git`
- Screenshotter | `grim slurp wl-clipboard jq` (grimblast)
- Command line
  - Replace cat | `bat`
  - Memory | `duf`
  - Replace ls | `exa`
  - Replace find | `fzf`, `fd`
  - Requests | `httpie`
  - Ping | `gping-git`

# Silly
## Manual
## Auto
- cbonsai | `cbonsai-git`
- donut.c | `donut.c`
- cmatrix | `cmatrix-git`

# Applications

## Manual
Use catpuccin mocha lavender for firefox and vscode, catpuccin mocha for bd
Use `cups` for printer stuff.

## Auto
- Firefox | `firefox`
- Discord | `discord_arch_electron betterdiscordctl`
- Prism Launcher | `prismlauncher`
- Steam | `steam`
- Vs Code | `visual-studio-code-bin`
- VPN | `openvpn protonvpn-gui`
