#!/bin/sh
#Add and generate locales
locale -a
echo "Now uncomment desired locales in  /etc/locale.gen"
echo "sudo nano /etc/locale.gen"
echo "and run *sudo locale-gen*"
