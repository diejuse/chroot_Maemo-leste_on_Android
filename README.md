# Chroot Maemo Leste on Android (for ARM64 devices).
## Tested on:
1. Unihertz Titan (Android 9 stock ROM). My video: https://www.youtube.com/watch?v=OqFHivcPIRM
2. Samsung Galaxy Fold2 (Android 10 stock ROM).
## Requirements.
1. Rooted Android device.
2. Termux (app from fDroid store).
3. "XSDL XServer" app.
4. ARM64 Maemo Leste image. This tutorial use maemo-leste-1.0-arm64-raspi3-20200114.tar.gz	, the last image downloaded from  https://maedevu.maemo.org/images/arm64-generic/
## Steps to install.
### 1. Extracting the image.
1. Open Termux.
2.     termux-setup-storage
3.     pkg install -y wget
4.     cd /sdcard
5.     wget https://maedevu.maemo.org/images/arm64-generic/20200114/maemo-leste-1.0-arm64-raspi3-20200114.tar.gz #wget https://maedevu.maemo.org/images/arm64-generic/20230819/arm64-generic.tar.gz
6.     wget https://raw.githubusercontent.com/diejuse/chroot_Maemo-leste_on_Android/main/chrootMaemo.sh
7.     su
8.     mkdir /data/local/leste
9.     tar xvzf /sdcard/maemo-leste-1.0-arm64-raspi3-20200114.tar.gz -C /data/local/leste  #tar xvzf /sdcard/arm64-generic.tar.gz -C /data/local/leste
10.     cd /data/local/leste
11. If you want to mount the internal memory of Android (warning: it is not recommended), you can:
    mkdir sdcard
### 2. Chrooting Maemo Leste.
1.     mv /sdcard/chrootMaemo.sh /data/local/leste
2.     sh chrootMaemo.sh
### 3. Configuring usable Internet.
1.     echo nameserver 8.8.8.8 > /etc/resolv.conf ; echo 127.0.0.1  localhost > /etc/hosts ; echo aid_inet:x:3003:user,root,_apt >> /etc/group ; echo aid_net_raw:x:3004:user,root,_apt >> /etc/group ; echo aid_admin:x:3005:user,root,_apt >> /etc/group ; groupadd -g 1003 aid_graphics ; usermod -g 3003 _apt 
7.     exit
8.     sh chrootMaemo.sh
### 4. Upgrading Maemo Leste Ascii to Maemo Leste Bewoulf.
1.     rm -R /etc/apt/sources.list.d ; echo deb http://pkgmaster.devuan.org/merged beowulf main contrib non-free > /etc/apt/sources.list ; echo deb http://pkgmaster.devuan.org/merged beowulf-updates main contrib non-free >> /etc/apt/sources.list ; echo deb http://pkgmaster.devuan.org/merged beowulf-security main contrib non-free >> /etc/apt/sources.list ; echo deb http://maedevu.maemo.org/leste beowulf main contrib non-free >> /etc/apt/sources.list ; echo deb http://maedevu.maemo.org/extras beowulf main contrib non-free >> /etc/apt/sources.list 
6.     apt update -y ; apt upgrade -y
8. Choose keyboard => English.
9. Restart services [...] => choose "Yes" 
10.     wget -O - https://maedevu.maemo.org/testing-key.asc | sudo apt-key add -
11.     apt update -y ; apt upgrade -y
13. We got an error: “unmet dependencies” related with “theme-default-settings-mr0”. To solve:
    -     dpkg -r --force-depends theme-default-settings-mr0
14.     apt --fix-broken install
15. Type: Yes, do as I say!
16.     apt update -y ; apt upgrade -y
18. It is possible Internet not working after upgrading. To solve, again: 
    -     echo nameserver 8.8.8.8 > /etc/resolv.conf
20.     rm -R /etc/apt/sources.list.d
21.     apt update -y ; apt upgrade -y ; apt dist-upgrade -y
24. You get "alarmd" error:
    -     rm /var/lib/dpkg/info/alarmd*
    -     dpkg --configure -D 777 alarmd
    -     apt -f install
26.     apt dist-upgrade -y
27. Choose "N" when you are asked.
28.     rm /etc/resolv.conf ; echo nameserver 8.8.8.8 > /etc/resolv.conf
30.     apt update -y ; apt upgrade -y
32.     #apt autoremove
33. No more errors should be displayed. We ensure that some necessary applications are installed:
    -     #apt install clock-ui alarmd applet-datetime hildon-base hildon-desktop hildon-home hildon-input-meta hildon-input-method hildon-im-fkb hildon-control-panel-personalisation osso-applet-textinput gtk2-engines-pixbuf hildon-application-manageron+onboard.sh
7. Remove the old Desktop Command Executionon+onboard.sh
7. Remove the old Desktop Command Execution clipboard-manager  hildon-plugins-notify-sv osso-systemui hildon-theme-maemo-org hildon-theme-tools liri-files live-wallpaper mihphoto msid ofono osso-abook-home-applet osso-thumbnail qalendar qshot qsigstoped sfed sphone shermans-aquarium surf2 telepathy-tank syncevolution sync-time-now-widget sync-ui
    -     #apt install hostapd hostapd-dbgsym iphbd libd3dadapter9-mesa libosmesa6 libscconf0 libsdbus-c++0 libwayland-egl1-mesa libsyncevo-dbus0 maefat maemosec-certman-applet maemosec-certman-tools maemo-statusmenu-volume maemo-system-services maeotp mesa-common-dev rmtfs
    -     apt install osso-systemui-tklock hildon-meta libmatchbox2 osso-systemui-modechange-dev osso-games-startup hildon-application-manager-dbgsym  atinout osso-systemui-devlock osso-systemui-dbus-dev osso-af-settings python-hildondesktop python-osso python-hildon libicd-network-usb icd2-osso-ic-dev mpi mce-dev atinout

### 5. Launching the Maemo Leste GUI: Hildon.
1.     wget https://raw.githubusercontent.com/diejuse/chroot_Maemo-leste_on_Android/main/launchMaemo.sh /
2. Open "XSDL XServer" Android app in landscape mode (doesn't work on portrait mode). Screen width must be greater than height screen.
3.     sh /launchMaemo.sh
4. Maemo is started. Now you can open and install apps using osso-xterm. Audio should work too. You can install chromium or firefox-esr, browse to youtube and check if audio works. 
### 6. Enabling Hildon application manager: installing "dummy network"
1. From osso-xterm:
    -     apt install libicd-network-dummy ; gconftool-2 -s -t string /system/osso/connectivity/IAP/DUMMY/type DUMMY ; gconftool-2 -s -t string /system/osso/connectivity/IAP/DUMMY/name 'Dummy network' ; gconftool-2 -s -t boolean /system/osso/connectivity/IAP/DUMMY/autoconnect true ; /etc/init.d/icd2 start -D
2. Restart Maemo Leste (repeat this steps every time you can restart Maemo Leste).
  - Close "XSDL XServer" app.
  - From terminal of Android:
          exit
          sh chrootMaemo.sh
  - Open "XSDL XServer" app.
  - From terminal of Android:
          sh /launchMaemo.sh
3. Go to settings > internet connections > connections. Check "Dummy network" is there.
4. Select the "Dummy network" connection. Go to time (top left of the screen) > Internet connection > Dummy network. 
5- Now you can install apps using Hildon Application Manager.
## Extra notes.
1. "Apt update" may freeze during installing "gconf2". The reason is that XSDL Xserver is open. You must close the application and the update will continue.
2. Increase DPI in apps:
    -     echo export GDK_DPI_SCALE=1.4 >> /root/.bashrc
    -     echo export QT_SCALE_FACTOR=1.5 >> /root/.bashrc
3. Add path to installed games:
    -     echo export PATH=/usr/games:$PATH >> /root/.bashrc

<a name="orientation"></a>
## Portrait/Landscape orientation support (manually).
1. Install "Desktop Command Execution Widget" app.
    -     sudo apt install desktop-cmd-exec
2. Make a folder for my scripts and download my script orientation.sh
    -     mkdir ~/diejuse_scripts # if not exists
    -     wget -P ~/diejuse_scripts https://raw.githubusercontent.com/diejuse/chroot_Maemo-leste_on_Android/main/orientation.sh
4. Add the script like a Desktop Command Execution widget:  
   3.1. "Add cmd" button:  
   &nbsp;&nbsp;&nbsp;-> Title -> "Orientation:"  
   &nbsp;&nbsp;&nbsp;-> Command: ~/diejuse_scripts/orientation.sh  
   3.2. Check this options: "Update on Boot", "Update when clicked", "Update when switched to the desktop"  
   3.3. Save.  
6. After the boot, Maemo will maintain the initial orientation. When you want a specific orientation go to the desktop home, rotate the smartphone to the orientation you want and tap on your widget. Your widget will update to the new orientation. 

<a name="virtualkeyboard"></a>
# Onboard virtual keyboard, modified for Maemo Leste. 
## Install usable onboard virtual keyboard, for both landscape and portrait orientation.
Copy and paste in any terminal you use in Maemo Leste:

    mkdir ~/diejuse_scripts ; wget -P ~/diejuse_scripts https://raw.githubusercontent.com/diejuse/chroot_Maemo-leste_on_Android/main/install_diejuse_onboard.sh ; sh ~/diejuse_scripts/install_diejuse_onboard.sh

Run this command every time you want to use onboard virtual keyboard in your current screen orientation. You will have to run the command every time you change orientation.

    ~/diejuse_scripts/orientation+onboard.sh

If you want a fast way to execute this script from Hildon home:  
    -     Install "Desktop Command Execution Widget" app (sudo apt install desktop-cmd-exec)  
    -     "Add cmd" button:  
   &nbsp;&nbsp;&nbsp;-> Title -> "Orientation:"  
   &nbsp;&nbsp;&nbsp;-> Command: ~/diejuse_scripts/orientation+onboard.sh  
    -     Check only the "Update when clicked" option and uncheck "Update on Boot" and "Update when switched to the desktop" options.  
    -     "Save"  

WARNINGS TO USE ONBOARD PROPERLY:  
- Don't open onboard using the desktop icon or you will lose the right configuration.  


    -     
