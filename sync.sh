# Update grimblast
git clone https://github.com/hyprwm/contrib
cd contrib
cp grimblast/grimblast ~/scripts/
cd ..
rm -rf contrib

# Update plymouth theme
git clone https://github.com/catppuccin/plymouth.git && cd plymouth
sudo cp -r themes/* /usr/share/plymouth/themes/
cd ..
rm -rf plymouth

# Update spicetify theme
git clone https://github.com/catppuccin/spicetify.git && cd spicetify
cp -r catppuccin-* ~/.config/spicetify/Themes/
cp js/* ~/.config/spicetify/Extensions/
cd ..
rm -rf spicetify

# Update sugar-dark theme
git clone https://github.com/Incompleteusern/sddm-sugar-dark
sudo cp -r sddm-sugar-dark /usr/share/sddm/themes/
rm -rf sddm-sugar-dark

# Update wallpaper
git clone https://github.com/Incompleteusern/wallpaper
cp wallpaper.sh ~/scripts/wallpaper.sh 
cp set-wallpaper.py ~/scripts/set-wallpaper.py
rm -rf wallpaper

# von
#cd ~/scripts/von
#git pull
