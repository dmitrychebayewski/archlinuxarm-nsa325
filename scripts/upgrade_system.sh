#!/bin/sh
#One-time action after first install fr: signing packages
init_pacman=n
if [ $init_pacman = "y" ]; then
  echo "signing packages"
  pacman-key --init
fi
#Arch linux update
# update the package databases for each of the repositories on your system.
pacman --sync --refresh
# Update the local database of PGP keys used by the package maintainers. 
# This step is optional, but may prevent problems later on with the upgrade if the database has not been updated for some time.
#pacman --sync --needed archlinux-keyring
pacman --sync archlinuxarm-keyring
pacman-key --populate archlinuxarm
#Upgrade all system packages. Be sure to note the upgraded packages and any output that requires your attention during the upgrade process.
pacman --sync --sysupgrade

#Copy kernel to /dev/sda1
echo mount /dev/sda1 /mnt/boot
echo cp -aR /boot/* /mnt/boot
echo umount /dev/sda1
