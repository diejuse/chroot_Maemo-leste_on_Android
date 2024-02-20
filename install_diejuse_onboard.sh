#!/bin/bash
# Script to install a modified and usable onboard.
# Made by Diego Jurado Segui (@diejuse)

# 1. Install onboard
sudo apt install onboard -y
# 2. Download my configuration files.
mkdir ~/diejuse_scripts
wget -O ~/diejuse_scripts/onboard_diejuse.tar.gz https://github.com/diejuse/chroot_Maemo-leste_on_Android/raw/main/onboard_diejuse.tar.gz
# 3. Extract.
tar zxf ~/diejuse_scripts/onboard_diejuse.tar.gz -C ~/diejuse_scripts
# 4. Overwrite my onboard files to default onboard files:
sudo cp ~/diejuse_scripts/onboard/*.ui /usr/share/onboard
cp ~/diejuse_scripts/onboard/user ~/.config/dconf
mkdir ~/.local/share/onboard/layouts
mkdir ~/.local/share/onboard/themes
cp ~/diejuse_scripts/onboard/layouts/* ~/.local/share/onboard/layouts
cp ~/diejuse_scripts/onboard/themes/* ~/.local/share/onboard/themes
gsettings set org.onboard layout ~/.local/share/onboard/layouts/diejuse_phone.onboard
gsettings set org.onboard theme ~/.local/share/onboard/themes/diejuse_tranparent_theme.theme
# 5. Download my script orientation+onboard.sh and let it executable permissions:
wget -O ~/diejuse_scripts/orientation+onboard.sh https://raw.githubusercontent.com/diejuse/chroot_Maemo-leste_on_Android/main/orientation+onboard.sh
chmod +x ~/diejuse_scripts/orientation+onboard.sh

#sleep 1 ; clear
echo "Onboard modified by @diejuse is ready."
echo "To run: ~/diejuse_scripts/orientation+onboard.sh"
echo "Run this command every time you want to use onboard virtual keyboard in your current screen orientation. You will have to run the command every time you change orientation."
