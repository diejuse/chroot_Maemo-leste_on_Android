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
3.     pkg install wget
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
1.     echo nameserver 8.8.8.8 > /etc/resolv.conf
2.     echo 127.0.0.1  localhost > /etc/hosts
3.     echo aid_inet:x:3003:user,root,_apt >> /etc/group
4.     echo aid_net_raw:x:3004:user,root,_apt >> /etc/group
5.     echo aid_admin:x:3005:user,root,_apt >> /etc/group 
6.     usermod -g 3003 _apt
7.     exit
8.     sh chrootMaemo.sh
### 4. Upgrading Maemo Leste Ascii to Maemo Leste Bewoulf.
1.     rm -R /etc/apt/sources.list.d
2.     echo deb http://pkgmaster.devuan.org/merged beowulf main contrib non-free > /etc/apt/sources.list
3.     echo deb http://pkgmaster.devuan.org/merged beowulf-updates main contrib non-free >> /etc/apt/sources.list
4.     echo deb http://pkgmaster.devuan.org/merged beowulf-security main contrib non-free >> /etc/apt/sources.list
5.     echo deb http://maedevu.maemo.org/leste beowulf main contrib non-free >> /etc/apt/sources.list
6.     apt update 
7.     apt upgrade
8. Choose keyboard => English.
9. Restart services [...] => choose "Yes" 
10.     wget -O - https://maedevu.maemo.org/testing-key.asc | sudo apt-key add -
11.     apt update
12.     apt upgrade
13. We got an error: “unmet dependencies” related with “theme-default-settings-mr0”. To solve:
    -     dpkg -r --force-depends theme-default-settings-mr0
14.     apt --fix-broken install
15. Type: Yes, do as I say!
16.     apt update
17.     apt upgrade
18. It is possible Internet not working after upgrading. To solve, again: 
    -     echo nameserver 8.8.8.8 > /etc/resolv.conf
20.     rm -R /etc/apt/sources.list.d
21.     apt update
22.     apt upgrade
23.     apt dist-upgrade
24. You get "alarmd" error:
    -     rm /var/lib/dpkg/info/alarmd*
    -     dpkg --configure -D 777 alarmd
    -     apt -f install
26.     apt dist-upgrade
27. Choose "N" when you are asked.
28. rm /etc/resolv.conf
29.     echo nameserver 8.8.8.8 > /etc/resolv.conf
30.     apt update
31.     apt upgrade
32.     #apt autoremove
33. No more errors should be displayed. We ensure that some necessary applications are installed:
    -     #apt install clock-ui alarmd applet-datetime hildon-base
    -     apt install osso-systemui-tklock hildon-meta libmatchbox2 osso-systemui-modechange-dev osso-games-startup hildon-application-manager-dbgsym  atinout osso-systemui-devlock osso-systemui-dbus-dev osso-af-settings python-hildondesktop python-osso python-hildon libicd-network-usb icd2-osso-ic-dev mpi mce-dev atinout

### 5. Launching the Maemo Leste GUI: Hildon.
1.     wget https://raw.githubusercontent.com/diejuse/chroot_Maemo-leste_on_Android/main/launchMaemo.sh /
2. Open "XSDL XServer" Android app in landscape mode (doesn't work on portrait mode). Screen width must be greater than height screen.
3.     sh /launchMaemo.sh
4. Maemo is started. Now you can open and install apps using osso-xterm. Audio should work too. You can install chromium or firefox-esr, browse to youtube and check if audio works. 
### 6. Enabling Hildon application manager: installing "dummy network"
1. From osso-xterm:
    -     apt install libicd-network-dummy
    -     gconftool-2 -s -t string /system/osso/connectivity/IAP/DUMMY/type DUMMY
    -     gconftool-2 -s -t string /system/osso/connectivity/IAP/DUMMY/name 'Dummy network'
    -     gconftool-2 -s -t boolean /system/osso/connectivity/IAP/DUMMY/autoconnect true
    -     /etc/init.d/icd2 start -D
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

