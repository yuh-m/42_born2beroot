## 42 Born2beRoot

### Goal: 
Project aimed to learn more about system administration, and Linux OS
The main topics on this project covers:
 1. Booting VMs
 2. LVM partitions | Filesytem Hierarchy Standard 
 3. SSH services
 4. Firewall settings
 5. User settings | groups configuration
 6. CRON jobs

### 1. Setting Virtual Machine ISO and boot on VM
##### 1.1.Download Oracle Virtual Box 
- ISO of DebianOS: https://www.debian.org/download
- Oracle VM: https://www.oracle.com/br/virtualization/technologies/vm/downloads/virtualbox-downloads.html  
</br>
- Creating a new VM:
  - 2048MB RAM
  - Set the HD to 30.8G (Implementing the Bonus)
    - Storage on physical disk can be: 
       - Dynamically allocated 
         - Pros - it can grow in size
         - Cons - the pyshical disk can become highly fragmented, the performance may degrade
       - Fixed size 
         - Pros - it can be faster to run
         https://techgenix.com/fixedsizevs-dynamicallyexpandingvirtualharddisks/
  - Before booting
    - On disk -> Controller: IDE -> set Debian iso file  
    ![Disk settings](./img/disk_settings.PNG)
    - On Network - set to "Bridged Adapter", so it can have internet access
    https://linuxhint.com/use-virtualbox-bridged-adapter/
</br>
##### 1.2. Boot setup
##### 1.2.1. Set hostname and domain namme
- Difference between __host name__ and __domain name__ 
  - hostname is the computer name (human-readable format), and they can also serve as domain name.
  - domain name is the address used by users to access a website. One domain can have several hosts (machines) underneath.
  http://www.differencebetween.net/technology/difference-between-hostname-and-domain-name/

#### 2. Partition Disk - understand LVM use, and File System Hierarchy

- __LVM__ (Logical Volume Managment) - There're tools that helps with managing how the pyshical disk space will be allocated like gparted, but LVM creates a layer which gives the advantage and flexibility on how to split the memory from the pyshical disks (Volume Groups - groups of pyshical disks), and assign blocks of memory that will be treated as different mounts / partitions (logical volumes).
  - The advange by having this layer it enables to change the partitions currently in use (in many other tools it's necessary boot the OS from another disk, or format the disk in case you want to create new partition later. In VLM it doesn't have this limitation), and also one single partition can be made of several blocks of memory apart within them.
  - Biggest advantage of LVM is the ability to take __snapshots__ of the existing Logical Volume, having a backup of the state of the machine without shutting the system down. 
  - What's LVM: 
    - https://wiki.ubuntu.com/Lvm
  - How to use LVM:
    - https://access.redhat.com/documentation/pt-br/red_hat_enterprise_linux/6/html/logical_volume_manager_administration/index
    - https://www.howtogeek.com/howto/40702/how-to-manage-and-use-lvm-logical-volume-management-in-ubuntu/
    - https://www.redhat.com/sysadmin/lvm-vs-partitioning
  - How to use snapshots in VM VirtualBox:
    - https://docs.oracle.com/en/virtualization/virtualbox/6.0/user/snapshots.html
  - Other tools for using snapshots:
    - https://github.com/linuxmint/timeshift
</br>
- __Linux Filesytem Hierarchy Standard__
  - Common partitions when setting Linux
![file sytem hierarchy](./img/file_system_hierarchy.PNG)

    - Linux File System/Structure Explained! - https://www.youtube.com/watch?v=HbgzrKJvDRw&
  - Swap partition - Free RAM memory when real RAM is full and more space is needed, by putting memory that wasn't used recently in disk.
    - https://www.wikiwand.com/en/Swap_partition
    - https://opensource.com/article/18/9/swap-space-linux-systems
</br>
- __lsblk__ - Linux command to display information about disk devices in a system.
   - https://linuxhint.com/linux-lsblk-command-tutorial-for-beginners/
   - what is the MAJ:MIN column - https://www.oreilly.com/library/view/linux-device-drivers/0596000081/ch03s02.html 
</br>
- Miscelaneous information:
  - Difference between Primary and Logical Partition -
    - It's more a legacy from how old OS were set (Mainly DOS and Windows) where it could have only 4 partitions to load an operational system. Where on Linux it's possible to have multiple partitions one for each File system (reducing potential data loss)
       - sda 1 to 4 it could be considered primary partitions, and sda 5 and higher on are extended partitions. 
    - https://www.wikiwand.com/en/Disk_partitioning
    - https://askubuntu.com/a/1207738
  - Difference creating the disk at beggining or end of avaiable space - Didn't find any explanation on where it could be better to create at the end, but emperical tests suggests it might have a poor performance on the disk. 
    - https://askubuntu.com/questions/56883/is-having-the-swap-partition-at-the-beginning-better-than-at-the-end
  - Difference on ext4, ext3 and ext2:
    - types of filesystems created for Linux.
    - ext3 and ext4 enables journaling (able to log changes in the  machine)
    - https://www.learnitguide.net/2016/08/difference-between-ext2-ext3-and-ext4.html
</br>
- __Expected result__ -  After the manual setup the inital configuration of the VM, the hard disk should have the following structure [tip - take a snapshot of the state of the machine, and copy of the VM to not having to set this up again before finishing the configuration of the VM]
![Bonus](./img/bonus_partitions.PNG)

</br>
</br>
### 2. Setting SSH
 - a
</br>
### 3. Setting Firewall
  - a
</br>
### 4. User settings
  - a
  
</br>
#### 4.1. Setting sudo
- Sudo is a program to allow a sysadmin to give limited access to users and log root activity
- https://www.sudo.ws/about/intro/

- as root run apt install sudo

#### 4.2. User Management
 - a
</br>
### 5. Monitor / CRON jobs
 - a
</br>
### 6. BONUS - Setting wordpress
 - a
- Framework required 
    ##### 6.1. Setting lighttpd 
    ##### 6.2. Setting MariaDB
    ##### 6.3. Setting PHP
    ##### 6.4. Wordpress
    ##### 6.5. Setting FTP 
    - link - How to install wordpress using lighttpd
    https://www.atlantic.net/dedicated-server-hosting/how-to-install-wordpress-with-lighttpd-web-server-on-ubuntu-20-04/
  -  https://geekrewind.com/install-wordpress-on-ubuntu-16-04-lts-with-lighttpd-mariadb-and-php-7-1-support/
 
### 7. Miscelanous information learned throught the project
#### 7.1. Difference between Linux distros (Debian vc CentOS)
#### 7.2. 

### - Sources - 

Extra material

Course - for linux 
https://www.redhat.com/en/services/training/rh024-red-hat-linux-technical-overview?section=Outline


Top 10 Linux Job Interview Questions
https://www.youtube.com/watch?v=l0QGLMwR-lY



Debian handbook -
https://debian-handbook.info/browse/stable/

