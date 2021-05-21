# Chroot Maemo Leste on Android (for ARM64 devices).
## Requirements.
1. Rooted Android device.
2. Busybox installed. I recommend "Busybox" app by Stephen (Stericson).
3. A terminal for Android. For example "Termux" app or "Terminal Emulator for Android" app.
4. "XSDL XServer" app.
5. ARM64 Maemo Leste image. This tutorial use maemo-leste-1.0-arm64-raspi3-20200114.tar.gz	, the last image downloaded from  https://maedevu.maemo.org/images/arm64-generic/
## Steps to install.
### 1. Extracting the image.
1. Open a terminal for Android.
2. su
3. cd /sdcard
4. wget https://maedevu.maemo.org/images/arm64-generic/20200114/maemo-leste-1.0-arm64-raspi3-20200114.tar.gz
5. mkdir /data/local/leste
6. tar xvzf /sdcard/maemo-leste-1.0-arm64-raspi3-20200114.tar.gz -C /data/local/leste
7. cd /data/local/leste
8. If you want to mount the internal memory of Android (warning: it is not recommended), you can:
    mkdir sdcard
### 2. Chrooting Maemo Leste.
1. wget https://raw.githubusercontent.com/diejuse/chroot_Maemo-leste_on_Android/main/chrootMaemo.sh
2. sh chrootMaemo.sh
### 3. Configuring usable Internet.
1. echo nameserver 8.8.8.8 > /etc/resolv.conf
2. echo 127.0.0.1  localhost > /etc/hosts
3. echo aid_inet:x:3003:user,root,_apt >> /etc/group
4. echo aid_net_raw:x:3004:user,root,_apt >> /etc/group
5. echo aid_admin:x:3005:user,root,_apt >> /etc/group 
6. usermod -g 3003 _apt
7. exit
8. sh chrootMaemo.sh
### 4. Upgrading Maemo Leste Ascii to Maemo Leste Bewoulf.
1. apt update
2. apt upgrade
3. rm -R /etc/apt/sources.list.d
4. echo deb http://pkgmaster.devuan.org/merged beowulf main contrib non-free > /etc/apt/sources.list
5. echo deb http://pkgmaster.devuan.org/merged beowulf-updates main contrib non-free >> /etc/apt/sources.list
6. echo deb http://pkgmaster.devuan.org/merged beowulf-security main contrib non-free >> /etc/apt/sources.list
7. echo deb http://maedevu.maemo.org/leste beowulf main contrib non-free >> /etc/apt/sources.list
8. apt update
9. apt upgrade
10. We got an error: “unmet dependencies” related with “theme-default-settings-mr0”. To solve:
    dpkg -r --force-depends theme-default-settings-mr0
6. apt upgrade
7. apt --fix-broken install
8. Ignore error processin "openrc".
9. It is possible Internet not working after upgrading. To solve, again: echo nameserver 8.8.8.8 > /etc/resolv.conf
11. rm -R /etc/apt/sources.list.d
12. apt update && apt upgrade && apt dist-upgrade
13. Now we got all public keys (.asc files) from https://maedevu.maemo.org:
  wget -O - https://maedevu.maemo.org/testing-key.asc | apt-key add -
  wget -O - https://maedevu.maemo.org/testing-key-exp.asc | apt-key add -
  wget -O - https://maedevu.maemo.org/extras-key.asc | apt-key add -
12.apt update
13.apt upgrade
13.No error should be displayed.
14.We ensure that some necessary applications are installed:
  apt install clock-ui alarmd applet-datetime
### 5. Launching the Maemo Leste GUI: Hildon.
1. wget https://github.com/diejuse/chroot_Maemo-leste_on_Android/edit/main/launchMaemo.sh
2. Open "XSDL XServer" Android app in landscape mode (doesn't work on portrait mode). Screen width must be greater than height screen.
3. sh /launchMaemo.sh
4. Maemo is started. Now you can open and install apps using osso-xterm. Audio should work too. You can install chromium or firefox-esr, browse to youtube and check if audio works. 
### 6. Enabling Hildon application manager: installing "dummy network"
1. From osso-xterm:
  apt install libicd-network-dummy
  gconftool-2 -s -t string /system/osso/connectivity/IAP/DUMMY/type DUMMY
  gconftool-2 -s -t string /system/osso/connectivity/IAP/DUMMY/name 'Dummy network'
  gconftool-2 -s -t boolean /system/osso/connectivity/IAP/DUMMY/autoconnect true
  /etc/init.d/icd2 start -D
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

