## What it is
 This documentation describes how to install and update Arch Linux Arm (alarm) server on ZyXEL NAS platform. I am using ZyXEL NAS device as Arch Linux Arm (alarm) for hobby projects.
 [ZyXEL NSA-325](https://archlinuxarm.org/platforms/armv5/zyxel-nsa325)

## Purpose
The project goal is provding simple and reliable file storage service for a home office. 
If you're looking for an affordable solution for offloading your old pictures, documents, music,
and if you want to access your documents, music, pictures occacionally, keeping them safe offline otherwise, this project could mean a good opportunity for you! 

## Features
This setup features simple file sharing over SMB / netbios protocol
and provides administrative access over ssh.

## Usage/examples
Once the NAS  is started and connected to home network, one can login in to NAS using ssh:
```
ssh user@alarm
```
and complete some elementary Unix administration tasks such as managing system backups and updates, adding new hard drives, mounting hard drives, installing and configuring new software, adding new users, adding access rights and so on.

On your PC (Windows 10 or any other OS) just open exporer and go 
to shared resorce:
```
\\alarm\your_resource
\\alarm\your_home_directory
```

## Installation
Installation is simple.
Once you have decided to switch your ZyXEL from factory OS to Arch Linux arm (alarm), 
you will need to complete 2 tasks:  
* Download the Alarm package from [Arch Linux ARM web](https://archlinuxarm.org) and copy files from provided tar to your HDD or SSD.
You can adapt the provided script, [restore_root_fs](./scripts/restore_root_fs.sh) for this kind of job.
* Modify ZyXEL NAS bootloader options to boot from HDD.
   The procedure is reversible so that you can switch back to factory OS. 
   The instruction is described in [set_bootloader_options](./scripts/set_bootloader_uptions.sh.2)

There might be additional steps required to create bootable Alarm disk. 
I used Arch linux Vagrant image for virtualbox, available on the Vagrant Cloud, to make a bootable Alarm disk.
###  Partitioning a hard drive
See [restore_roott_fs](./scripts/restore_root_fs.sh)
### Making bootable partitions
See [restore_root_fs](./scripts/restore_root_fs.sh)
### Installing HDD /SSD
Once bootable Alarm SSD / HDD is prepared, install it in Slot 0 of your NAS.
### Starting NAS first time
* Connect NAS to your LAN; 
* Switch on your NAS; 
* Wait for leds to settle. 
### Looking up NAS IP address
You can look up your NAS IP address with the following Windows 10 command:
```
arp -a
```
### First ssh login
Login using the credentials provided with Alarm distributive:
```
> ssh alarm@alarm
alarm@alarm's password:
[alarm@alarm ~]$
```
### Changing default passwords
Immediately change the passwords of root and alarm users:
```
[alarm@alarm ~]$ su
Password:
[root@alarm alarm]# passwd root
New password:

```
### Signing packages
See provided script [upgrade_system](./scripts/upgrade_system.sh)
### Updating Arch linux
See provided script: [upgrade_system](./scripts/upgrade_system.sh)
### Installing packages
See provided script: [install_packages](./scripts/install_packages.sh)
### Add data volumes to your system
See provided script: [](./scripts/mount_shared_filesystem.sh)
### Adding sudo users
See proviced script: [add_wheel_users](./scripts/add_wheel_users.sh)
 
## Setup tasks

### Update Arch Linux

It is a best practice to update your server on a regular schedule for security and stability. 
Use this instruction to keep your Arch server updated. 
Visit the Arch Linux homepage, to see if there have been any breaking changes to packages that you have installed recently. 
If there are, there may be manual intervention required after the upgrade.

1. Update Respoitories
This will update the package databases for each of the repositories on your system.

```
$ sudo pacman --sync --refresh
```

2. Update PGP Keys
Update the local database of PGP keys used by the package maintainers. This step is optional, but may prevent problems later on with the upgrade if the database has not been updated for some time.

```
$ sudo pacman --sync --needed archlinux-keyring
```

3. Update the System
Upgrade all system packages. Be sure to note the upgraded packages and any output that requires your attention during the upgrade process.

```
$ sudo pacman --sync --sysupgrade
```

### Set up SSH
Please study Arch Linux documentation.
The documentation that I found on [Vultr](https://www.vultr.com) 
is excellent, too!
You might need to change default values, provided in */etc/sshd_conf*
```
Match User secret
PasswordAuthentication yes
```

### Installing and setting up Samba
Please study Arch Linux documentation.
### Adjust SMB browsing behavior in macOS
[Speed up browsing on network shares](https://support.apple.com/en-us/HT208209)
>To speed up SMB file browsing, you can prevent macOS from reading .DS_Store files on SMB shares. This makes the Finder use only basic information to immediately display each folder's contents in alphanumeric order. Use this Terminal command:
```
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
```

>Then log out of your macOS account and log back in.
>To reenable sorting, use this command:
```
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool FALSE
```
## Update strategy
[Citaton from Vultr documentation](https://www.vultr.com/docs/installing-2019-arch-linux-on-a-vultr-server#Configure_SSH)
>Because Arch is a "rolling release", you can upgrade all packages you have installed whenever you'd like. 
>Users may upgrade on their own schedule, daily, weekly and so on. If you upgrade often, 
>not many packages will need to be upgraded at once, and any potential problems you may run into will be easier to pinpoint. 
>It is important to upgrade all packages at once, as the following command will do. 
>It's easy to imagine why upgrading something like "glibc" alone, without the programs that use it, would cause problems.


The choice of mine  is bi-weekly update schedules. This way I am able to keep system updates not huge, and keep risks of update conflicts reasonably low.

## Backup strategy
Before upgrading all packages, it is crucial that you make full system backup.
"Full ssystem backup with tar" strategy, explained in details on Arch linux documentation page, apeared to be effective and very useful for a small project like this. Sample script which makes things done could look like 
[backup_root_fs](./scripts/backup_root_fs.sh).
Tar backup, produced with above script, is very quickly restored to boot HDD/SSD with the following script: [restore_root_fs](./scripts/restore_root_fs.sh)
It is very recommendable to restore your backup on your second HDD drive immediately, as your backup job is done. 
Then, you always have a swap bootable HDD.
## Scheduled backup

Create the following files in /etc/systemd/system/
 * [backup.timer](./scripts/backup.timer)
 * [backup.service](./scripts/backup.service)

Start backup.timer and enable it on boot.


```
#systemd-analyze verify /etc/systemd/system/backup.*
#systemctl start backup.timer
#sudo systemctl enable backup.timer
```

## Asking questions

Q. What are benefits of this solution over external USB drive?
>External USB drive cannot be set up as a small file server.
So, using NAS, you can collaborate on hobby projects with your partners, and no one needs to use a private computer as file server.

Q. What are advantages of Arch Linux ARM over factory ZyXEL Nas OS?
>You can very flexibly set up any service, any feature, not supported by factory ZyXEL Nas OS, such as NFS4 or rtorrent, or tmux.

Q. What are disadvantages of Arch Linux Arm?
>Installing Arch Linux ARM will void ZyXEL warranty. Also, Arch Linux Arm is "rolling release" system, so you will need to update your syetem on very frequent schedule. You also need to study the updates carefully to know whether they imply breaking changes that could require your intervention.


## Contributing

Feel free to ask questions, make branches and submit pull requests.

## Authors/maintainers
Authorship is always mentioned in the scripts directly,  when it is known. Otherwise, I, Dmitry Chebayewski is the author and maintainer of this project
## License
[MIT License](./LICENSE) is applicable
