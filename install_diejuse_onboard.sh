#!/bin/bash
# Script to install a modified and usable onboard.
# Made by Diego Jurado Segui (@diejuse)

# 1. Install onboard
sudo apt install onboard -y
# 2. Download my configuration files.
mkdir ~/diejuse_scripts
wget -P ~/diejuse_scripts https://github.com/diejuse/chroot_Maemo-leste_on_Android/raw/main/onboard_diejuse.tar.gz
# 3. Extract.
tar zxf ~/diejuse_scripts/onboard_diejuse.tar.gz -C ~/diejuse_scripts
# 4. Download my script orientation+onboard.sh and let it executable permissions:
wget -P ~/diejuse_scripts https://raw.githubusercontent.com/diejuse/chroot_Maemo-leste_on_Android/main/orientation+onboard.sh
chmod +x ~/diejuse_scripts/orientation+onboard.sh
