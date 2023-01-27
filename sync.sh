BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

rm -r ${BASEDIR}/.config
rm -r ${BASEDIR}/scripts
rm -r ${BASEDIR}/.zshrc

mkdir ${BASEDIR}/.config

cp -r ~/.config/alacritty ${BASEDIR}/.config/
cp -r ~/.config/dunst ${BASEDIR}/.config/
cp -r ~/.config/hypr ${BASEDIR}/.config/
cp -r ~/.config/rofi ${BASEDIR}/.config/
cp -r ~/.config/waybar ${BASEDIR}/.config/
cp -r ~/.config/cava ${BASEDIR}/.config/
cp -r ~/.config/rofi ${BASEDIR}/.config/

cp -ar ~/scripts/ ${BASEDIR}/
cp -ar ~/.zshrc ${BASEDIR}/
