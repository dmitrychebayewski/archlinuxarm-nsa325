#!/bin/sh
pacman --sync sudo
pacman --sync nano
pacman --sync mc
pacman --sync samba
pacman -S uboot-env uboot-mkimage
pcaman --sync rsync
pacman --sync pbzip2 powertop htop tmux
echo "You might need to configure installed services"
echo "Edit smb.conf *sudo nano /etc/samba/smb.conf*"
echo "Enable the service unit: *sudo systemctl enable smb.service*"
echo "Start the service unit: *sudo systemctl start smbd nmbd*"
