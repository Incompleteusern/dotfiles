BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Remove old
rm -r ${BASEDIR}/.config
rm -r ${BASEDIR}/scripts
rm -r ${BASEDIR}/.zshrc

mkdir ${BASEDIR}/.config

# Update grimblast
gcl https://github.com/hyprwm/contrib
cd contrib
cp grimblast/grimblast ~/scripts/
cd ..
rm -rf contrib


# Copy files
cp -r ~/.config/alacritty ${BASEDIR}/.config/
cp -r ~/.config/dunst ${BASEDIR}/.config/
cp -r ~/.config/hypr ${BASEDIR}/.config/
cp -r ~/.config/rofi ${BASEDIR}/.config/
cp -r ~/.config/waybar ${BASEDIR}/.config/
cp -r ~/.config/cava ${BASEDIR}/.config/
cp -r ~/.config/rofi ${BASEDIR}/.config/
cp -r ~/.config/neofetch ${BASEDIR}/.config/

cp -ar ~/scripts/ ${BASEDIR}/
cp -ar ~/.zshrc ${BASEDIR}/
