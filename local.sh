BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Remove old
rm -r ${BASEDIR}/.config
rm -r ${BASEDIR}/scripts
rm -r ${BASEDIR}/.zshrc

mkdir ${BASEDIR}/.config


# Copy files
cp -r ~/.config/alacritty ${BASEDIR}/.config/
cp -r ~/.config/dunst ${BASEDIR}/.config/
cp -r ~/.config/hypr ${BASEDIR}/.config/
cp -r ~/.config/rofi ${BASEDIR}/.config/
cp -r ~/.config/cava ${BASEDIR}/.config/
cp -r ~/.config/rofi ${BASEDIR}/.config/
cp -r ~/.config/neofetch ${BASEDIR}/.config/
cp -r ~/.config/networkmanager-dmenu ${BASEDIR}/.config/
cp -r ~/.config/eww ${BASEDIR}/.config/
cp -r ~/.config/fcitx5 ${BASEDIR}/.config/

cp -r ~/scripts/ ${BASEDIR}/
cp -r ~/.zshrc ${BASEDIR}/
cp -r ~/.fonts ${BASEDIR}/
