#!/bin/sh

#####
#  Created By: Jason Plum <jplum@archlinuxarm.org>
#  Prepared for: Arch Linux ARM
#  ----------
#  Automation to convert NSA-325 to Arch Linux ARM on /dev/sda
#  : /dev/sda is sata port 1, left side of enclosure.
#####
echo "Automatic Installation of Arch Linux ARM"
### Backup destination
backdest=/backup
### Labels for backup name
#PC=${HOSTNAME}
pc=zyxel325v2
distro=arch
type=full
#date=$(date "+%F")
date=2021-04-03
backupfile="$backdest/$pc-$distro-$type-$date.tar.gz"

### USB stick is /dev/sdc
boot_dev=/dev/sd
boot_part=/dev/sdc1
rootfs_part=/dev/sdc2
make_part=n
### Mount points
mnt_boot=/mnt/boot
mnt_rootfs=/mnt/rootfs

if [ $make_part = "y" ]; then  
echo "- parition $boot_dev"
fdisk "$boot_dev" <<EOF
o
n
p
1

+16M

n
p
2


p
w

EOF
echo " * pause for ioctl to re-sync partitions"
sleep 5
 echo "- make boot filesystem"
#  ext2 makes u-boot happy.
 mkfs.ext2 -L "boot" "$boot_part"
fi

###
#  make rootfs filesystem
#  stock does not know how to make ext4!
echo "- make rootfs  filesystem"
mkfs.ext4 -L "rootfs" "$rootfs_part"

###
#  make dirs & mount
echo "- mount destination"
rm -rf "$mnt_boot" ||:
rm -rf "$mnt_rootfs" ||:
mkdir -p "$mnt_boot"
mount -t ext2 "$boot_part" "$mnt_boot"
mkdir -p "$mnt_rootfs"
mount -t ext4 "$rootfs_part" "$mnt_rootfs"

###
#  prepare the system
#  extract the rootfs
echo "- extract rootfs"
tar --acls --xattrs -xpf $backupfile -C "$mnt_rootfs"
# /boot was not included in the backup
mkdir -p "$mnt_rootfs"/boot 
#  copy the uImage to the boot partition
echo "- prepare boot partition"
cp -aR /boot/* "$mnt_boot"
#  always make sure you're sync'd!
sync
###
#  prepare for first boot
#  set the bootcmd to run the steps to convert.
###
#  we're done here
# echo "- SHUTTING DOWN!"  
#shutdown now
