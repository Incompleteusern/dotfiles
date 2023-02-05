![image](https://user-images.githubusercontent.com/58920010/216701421-588d2a53-43ef-4c46-aba3-798434cddb06.png)

## Thanks to

- https://github.com/scotus-1/dotfiles for format and what to use xd
- https://github.com/flick0/dotfiles for various configs
- https://github.com/Saimoomedits/eww-widgets for the top bar, modified for catppuccin theming, hyprland and spotify 
- https://github.com/catppuccin for the pastel theming over basically everything I can touch
  - For rofi, deathmonde is used
- https://wiki.archlinux.org/title/User:Bai-Chiang/Installation_notes for extended installation notes

## INFO

These dotfiles come with three terrible scripts as of last updated:
- `local.sh` which syncs local files into this github repo
- `sync.sh` which syncs bundled github repos into local files
- `init.sh` which installs the github repo into an arch install

## TODO

TODO:
- Swap hibernation encryption support based on https://gist.github.com/orhun/02102b3af3acfdaf9a5a2164bea7c3d6#known-issues
- Learn tmux
- Change mouse or something idk
- Do redshift alternative
- Customize oh-my-fsh more
- Configs for desktop
  - Wallpaper script time!!!!
  - EWW
    - Do which widgets I want first lol
    - Make a custom script to check for arch updates
    - Language
    - Do CSS
- Write a python script to handle bundling other repos in this
- Screensharing, App Launchers, App Clients, Color Pickers
    - aka Configure Rest of Desktop
- Decide whether to use XDG Desktop Portal?
- Customize firefox + fork mozilla? 
- Go through general preference :SOB:
- Add disk encryption
  - https://wiki.archlinux.org/title/Dm-crypt/Device_encryption with sector-size
  - Do this in February when wifi-adapter is natively supported by udev
- AI gen might be fun for wall paper
- Stop bundling other people's github repos, add a way to install froms ource
- dhcpcd, blueman and wpa_supplicant?

# Installation

## Manual
### Pre-Boot
- Make sure Secure Boot is disabled
  - `# bootctl status | grep "Secure Boot"`
- Clean up boot options using `efibootmgr` as necessary
- Right now, temporary android tether to set up and get driver rtw89 manually
- Three partitions
  - Make root, user, and swap partitions using `cblsk` (TODO make using fblsk in the future LOL)
  - Set up encryption
    - https://wiki.archlinux.org/title/Dm-crypt/Device_encryption
    - ```
         # cryptsetup --type luks2 --verify-passphrase --sector-size 4096 --verbose luksFormat /dev/root_partition
         # cryptsetup --type luks2 --verify-passphrase --sector-size 4096 --verbose luksFormat /dev/user_partition
         # cryptsetup open /dev/root_partition cryptroot
         # cryptsetup open /dev/user_partition crypthome
      ```
      - Unmount, Close and remount to make sure that everything is working smoothly
    - Mount and make file systems
      - ```
          # mkfs.ext4 /dev/mapper/cryptroot
          # mkfs.ext4 /dev/mapper/crypthome
          # mkswap /dev/swap_partition

          # mount /dev/mapper/cryptroot /mnt
          # mount /dev/mapper/crypthome /mnt/home
          # swapon /dev/swap_partition
        ```
- chroot into shell
  - ```
        # arch-chroot /mnt
        # export PS1="(chroot) ${PS1}"
    ```
  - More encryption BS
   - Disk Encryption
     - https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition
     - Configure `/etc/mkinitcpio.conf`, and add or note `systemd keyboard sd-vconsole sd-encrypt` presence
       - ```
              HOOKS=(base systemd keyboard autodetect modconf kms sd-vconsole block sd-encrypt filesystems fsck)
         ```
       - Create `/etc/crypttab.initramfs` and add the following where `ROOT_UUID` is `lsblk -dno UUID /dev/root_partition`. Do the same
         for the user partition similarily
       - ```
             cryptroot  UUID=ROOT_UUID  -  password-echo=no,x-systemd.device-timeout=0,timeout=0,no-read-workqueue,no-write-workqueue
         ```
   - Swap Encryption
     - https://wiki.archlinux.org/title/Dm-crypt/Swap_encryption and https://wiki.archlinux.org/title/Dm-crypt/Swap_encryption#UUID_and_LABEL
     - Turn off the swap partition and create a bogus file system
       - ```
          (chroot) # swapoff /dev/sdX3
          (chroot) # mkfs.ext2 -F -F -L cryptswap /dev/sdX3 1M
         ```
       - Add in `/etc/crypttab` where `SWAP_UUID` is `lsblk -dno UUID /dev/swap_partition`
         ```
           # <name>   <device>         <password>   <options>
           cryptswap  UUID=SWAP_UUID  /dev/urandom  swap,offset=2048
         ```
       - Change the UUID in `/etc/fstab` to a /swap
         ```
           # <filesystem>    <dir>  <type>  <options>  <dump>  <pass>
           /dev/mapper/swap  none   swap    defaults   0       0
         ```

- Linux install | `linux linux-firmware`
- Processor Microcode | `intel-ucode`
- Text Editor | `nano nano-syntax-highlighting`

## Post-Boot
- Mirror management | `reflector`
  - Set US as country
  - Enable `reflector.timer`
  - TODO automate that shit
- Add user
  - `# useradd -m $user; passwd $user; usermod -aG wheel,audio,video,optical,storage $user`
- Add wheel group to sudoers | `sudo`
  - Uncomment `# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL:ALL) ALL`
- git, ssh/gpg | `git openssh github-cli`
  - ```
       $ gh auth login
       $ ssh-keygen -t ed25519 -C "$email"; ssh-add ~/.ssh/id_ed25519
       $ gh ssh-key add ~/.ssh/id_ed25519.pub --title $hostname
       $ git clone git@github.com:Incompleteusern/dotfiles.git
       $ gpg --full-generate-key
       $ gpg --list-secret-keys --keyid-format=long
       $ git config --global user.signingkey $KEY
       $ git config --global commit.gpgsign true
       $ git config --global user.email "$email"
       $ git config --global user.name "$name"
- Network Manager | `networkmanager` and enable service
- Run `init.sh`

## Auto
- Enable Color, ILoveCandy and ParallelDownloads in /etc/pacman.conf
- yay | `base-devel`
- add ~/script to path
- zshrc | `zsh`
- Pacman Utils | `paccache pacgraph`
- Add local host to /etc/hosts
  - TODO url link

# Desktop

## TODO
- Polkit | `polkit-kde-agent` 
- Display Manager | `sddm`
- 

## Manual

## Auto
- Compositor | `hyprland-git` 
- Wallpapers | `swww-git` 
- Notification System | `dunst libnotify` 
- Status Bars | `eww-wayland-git`
- Pipewire | `pipewire wireplumber pipewire-pulse pipewire-jack `
- XDG Integration | `xdg-utils xdg-desktop-portal-wlr`
- Terminal | `alacritty-git`
- App Launcher | `rofi-lbonn-wayland-git papirus-icon-theme-git sif-git networkmanager-dmenu-git ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-iosevka-nerd` 
- Font Input | `fcitx5 fcitx5-chinese-addons fcitx5-configtool fcitx-gtk fcitx5-pinyin-zhwiki fcitx5-qt`


# Utilities
## Manual
- Order Chinese as priority for Noto CJK
  - https://wiki.archlinux.org/title/Localization/Simplified_Chinese#Chinese_characters_displayed_as_variant_(Japanese)_glyphs
  - TODO automate that shit

## Auto
- Desktop Control | `brightnessctl`
- fonts | `ttf-ms-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-material-icons-git ttf-symbola`
  - Set Chinese as font priority
- screenshots | `grim slurp wl-clipboard jq` (grimblast)
- cli
  - Replace cat | `bat`
  - Replace ls | `exa`
  - Replace find | `fzf`, `fd`
  - Requests | `httpie`
  - Ping | `gping-git`
- power | `tlp tlp-rdw`
- spotify integration | `playerctl`
- volume control | `pamixer`
- System Information | `htop neofetch-git duf`
# Silly
## Manual
## Auto
- cbonsai | `cbonsai-git`
- donut.c | `donut.c`
- cmatrix | `cmatrix-git`
- sl | `sl`

# Applications

## Manual
- Use catpuccin mocha lavender for firefox, vscode, bd, and spicetify.
  - TODO automate that shit
- Use `cups` for printer stuff.
- Enable firefox hardware acceleration, reopen tabs on close

## Auto
- Firefox | `firefox`
- Discord | `discord-electron-bin discord-screenaudio betterdiscordctl`
- Prism Launcher | `prismlauncher`
- Steam | `steam`
- Vs Code | `visual-studio-code-bin`
- VPN | `openvpn protonvpn-gui`
- Spotify |`spotify spotifywm spotify-adblock-git spicetify`
