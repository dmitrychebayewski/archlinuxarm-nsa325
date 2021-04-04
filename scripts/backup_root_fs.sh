#!/bin/sh

# Full system backup

# Backup destination
backdest=/backup
# Labels for backup name
#PC=${HOSTNAME}
pc=zyxel325v2
distro=arch
type=full
date=$(date "+%F")
backupfile="$backdest/$pc-$distro-$type-$date.tar.gz"
tar  --exclude="/backup" --exclude="/var/cache/pacman/pkg" --exclude="/dev" --exclude="/proc" --exclude="/sys" --exclude="/tmp" --exclude="/run" --exclude="/mnt" --exclude="/media" --exclude="/lost+found" --exclude="/swapfile" -S --acls --xattrs -cpvf $backupfile /
