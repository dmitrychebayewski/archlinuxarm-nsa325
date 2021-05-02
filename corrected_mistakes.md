# Kernel version and uname mismatch

## How did a mistake manifest itself
 I installed **Docker** but could not start it as service. The journal
 ```
 $ journalctl -xeu docker.service 
 ```
 had entries indicating that 
 ```
 modprobe: WARNING: Module bridge not found in directory /lib/modules/4.4.252-1-ARCH
 modprobe: FATAL: Module ip_tables not found in directory /lib/modules/4.4.252-1-ARCH

 ```
The following commands (Linux version, installed by Pacman and Kernel version) gave me totally mismatching info:
```
pacman -Q linux
linux-kirkwood 4.4.262-1
```
```
uname -r
4.4.252-1-ARCH
```
 >4.4.262-1 != 4.4.252-1

## What has gone wrong or has not been completed
Otherwise than Arch linux guided installation, 
I partitioned the drive for a new installation of Arch linux Arm, mounted the partitions at /mnt/boot and /mnt/rootfs, untarred tar.gz file to ext4 root partition, mounted at /mnt/rootfs and copied packaged kernel files to ext2 boot partition, mounted at /mnt/boot:
```
cp -aR /mnt/rootfs/boot/* /mnt/boot
```
I did not update  /etc/fstab, and my boot partition became unaccessible by pacman.
When I ran the system update, the new kernel was generated to /boot. But the kernel files, initially copied to /dev/sda1 ext2 boot partition, were not replaced by pacman.
The consequence of this was incomplete system update:
 * Root file system (mounted at /) - updated with new versions of libraries and modules, 
 * Boot partition /dev/sda1 - still old version of Linux kernel. 

## Solution
The solution is mounting the boot partition at default mount point /boot.
This is achieved by editing /etc/fstab file. These steps have been done:
* genfstab utility installed:
  ```
   #pacman -S arch-install-scripts
  ```
* /etc/fstab file backed up
* Delete the files from /boot directory
* Boot partition (in my case it is /dev/sda1) mounted manually at /boot
  ```
  #mount /dev/sda1 /boot
  ```
* New version of fstab has been generated
  ```
  $genfstab -U / >> ~/fstab
  ```
* The new fstab looks like:
  ```
  # /dev/sda2 LABEL=rootfs
  UUID=3ab6ffd8-8672-4e87-9a09-aeec09d324fc<----->/         <---->ext4      <---->rw,relatime,data=ordered<------>0 1
                                                                                    # tracefs
  tracefs             <-->/sys/kernel/tracing<--->tracefs   <---->rw,nosuid,nodev,noexec<>0 0
                                                                                    # /dev/sdb1 LABEL=data
  UUID=07e44e5f-6161-4ed2-bc6b-d7c0c22c77bc<----->/mnt/i-data<--->ext4      <---->rw,relatime,data=ordered<------>0 2
  
  # /dev/sda1 LABEL=boot
  UUID=1e4cfa17-e374-4caa-8c66-284d4060a49d<----->/boot     <---->ext2      <---->rw,relatime<--->0 2
  ```
* /dev/sda1 record is copied from new fstab to /etc/fstab and edit your /etc/fstab
  so that /etc/fstab finally has record:
  ```
  # <file system> <dir> <type> <options> <dump> <pass>
  /dev/sda1     /boot        ext2 rw,relatime     0        2   
  ```
* [Readme.md](./README.md) updated 

## Total costs of mistake

5 hours of alalysis, resolution and documentation.