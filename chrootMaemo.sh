export SDCARD=/data/local
export ROOT=$SDCARD/leste
export PATH=/usr/local/sbin:/usr/games:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin:$PATH
export DISPLAY=:0
export PULSE_SERVER=tcp:127.0.0.1:4713
export CLUTTER_BACKEND=x11 HD_NOTHREADS=yes CLUTTER_DRIVER=gles2 OVERRIDE=-GL_EXT_unpack_subimage
export USER=root
export HOME=/root
#export LANGUAGE=C
#export LANG=C
mount -o remount,exec,dev,suid $SDCARD
busybox mount --bind /dev $ROOT/dev
busybox mount --bind /proc $ROOT/proc
busybox mount --bind /dev/pts $ROOT/dev/pts
busybox mount --bind /sdcard $ROOT/sdcard
echo "Mounting Done"
DISPLAY=:0     CLUTTER_BACKEND=x11 HD_NOTHREADS=yes CLUTTER_DRIVER=gles2 OVERRIDE=-GL_EXT_unpack_subimage busybox   chroot $ROOT /bin/bash -l
busybox umount $ROOT/dev/pts
busybox umount $ROOT/dev
busybox umount $ROOT/proc
busybox umount $ROOT/sdcard
echo "Unmounted"
