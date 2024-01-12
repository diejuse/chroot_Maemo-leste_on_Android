tput setaf 3;echo "Launching Maemo Leste. Ordered boot script, by Diejuse :)";tput sgr0;
#rm -R /dev/shm
rm -R /tmp/*
chmod -R 777 /tmp 
rm -R /run/*
mkdir /dev/shm
chmod -R 777 /dev/shm
mkdir /var/shm
mkdir /run/user
mkdir /run/user/0
chmod -R 0700 /run/user/0
mkdir /run/openrc
touch /run/openrc/softlevel
touch /run/initctl

#/sbin/dsme -d -p /usr/lib/dsme/libstartup.so &
#/sbin/dsme-server -d -p /usr/lib/dsme/libstartup.so &
/usr/sbin/ke-recv &
/etc/init.d/dbus start &
maemo-launcher --send-app-died --booster gtk,cpp --daemon
systemui &
clockd &
/usr/sbin/alarmd &
/usr/lib/aarch64-linux-gnu/sapwood/sapwood-server &

hildon-sv-notification-daemon &
hildon-status-menu &
hildon-home &
hildon-desktop &
osso-connectivity-ui-conndlgs &
hildon-input-method &

/usr/sbin/icd2 -l2 &
/usr/bin/dbus-daemon --session --print-address=2 &
/usr/lib/aarch64-linux-gnu/gconf/gconfd-2 &

mce &

/usr/bin/profiled &
/usr/sbin/temp-reaper &
