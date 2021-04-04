#!/bin/sh
##Prepare Mounts
mkdir /mnt/data
echo "Now include mounts in /etc/fstab"
echo "sudo nano /etc/fstab"
echo "Add and uncomment these lines in /etc/fstab"
echo "#/dev/sdb1     /mnt/data  ext4 defaults        0        1"
echo "Grant access rights:"
echo "sudo chown -R :wheel /mnt/data/your_shared_dir"