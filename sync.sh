BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

rm -r ${BASEDIR}/.config
rm -r ${BASEDIR}/scripts
rm -r ${BASEDIR}/.zshrc

mkdir ${BASEDIR}/.config

cp -ar ~/.config/alacritty ${BASEDIR}/.config/
cp -ar ~/.config/dunst ${BASEDIR}/.config/
cp -ar ~/.config/hypr ${BASEDIR}/.config/
cp -ar ~/.config/rofi ${BASEDIR}/.config/
cp -ar ~/.config/waybar ${BASEDIR}/.config/
cp -ar ~/.config/cava ${BASEDIR}/.config/

cp -ar ~/scripts/ ${BASEDIR}/
cp -ar ~/.zshrc ${BASEDIR}/
