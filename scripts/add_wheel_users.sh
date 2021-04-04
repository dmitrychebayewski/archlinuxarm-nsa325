#!/bin/sh
#Adding wheel users
declare -a users=("vagrant")

## now loop through the above array
for user in "${users[@]}"
do
   echo "Adding wheel user $user"
   useradd --create-home "$user"
   usermod --append --groups wheel "$user"
   pdbedit -a -u "$user"
   echo "Now set user password: *sudo passwd $user*"
   echo "And add samba password: *sudo smbpasswd $user*"
done

