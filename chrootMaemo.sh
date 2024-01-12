export SDCARD=/data/local
export ROOT=$SDCARD/leste
export PATH=/usr/local/sbin:/usr/games:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin:$PATH
export DISPLAY=:0
export PULSE_SERVER=tcp:127.0.0.1:4713
export CLUTTER_BACKEND=x11 HD_NOTHREADS=yes CLUTTER_DRIVER=gles2 OVERRIDE=-GL_EXT_unpack_subimage
export USER=root
export TMPDIR=/tmp
export HOME=/root
export XDG_RUNTIME_DIR=/run/user/0
#export LANGUAGE=C
#export LANG=C
mount -o remount,exec,dev,suid /data
mount --bind /dev $ROOT/dev
mount -t devpts devpts $ROOT/dev/pts

mount --bind /sys $ROOT/sys
mount --bind /proc $ROOT/proc
#mount --bind /sdcard $ROOT/sdcard
echo "Mounting Done"
chroot $ROOT /bin/su - root
umount $ROOT/proc
umount $ROOT/sys
umount $ROOT/dev/pts
umount $ROOT/dev
#busybox umount $ROOT/sdcard
echo "Unmounted"
