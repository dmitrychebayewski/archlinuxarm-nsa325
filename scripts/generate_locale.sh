#!/bin/sh
#Add and generate locales
locale -a
echo "Now uncomment desired locales in  /etc/locale.gen"
echo "sudo nano /etc/locale.gen"
echo "and run *sudo locale-gen*"
echo "and set LANG=en_US.UTF-8 in  /etc/locale.conf"
echo "and set timezone: *sudo timedatectl set-timezone Europe/Amsterdam*"
