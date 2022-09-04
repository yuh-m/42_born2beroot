## Commands for setup the machine 
## 2. LVM - Creating partitions 
It's possible to use lvmcreate
### 2.1. Snapshot
Create a snapshop - with the VM turned off 

Retrieve the state of the machine
    shalsum <virtual disk>.vdi
'a'
### 2.2. General info after setup
For giving information of OS
` cat /etc/os-release `

Check if AppArmor is enabled
` /usr/sbin/aa-status `
otherwise 
` systemctl enable apparmor`


` /usr/sbin/ufw status `


## 3 SSH install 

`apt install open-ssh-server`

Check if the SSH is active or installed
`systemctl status ssh`
`dpkg -l | grep ssh `

To stop or start  `systemctl start/stop sshd`

To enable on boot 
 `systemctl enable sshd`

To config SSH
 `vim /etc/ssh/sshd_config`

To restart SSH
`systemctl restart sshd`

To check if the SSH is the only socket available 
`ss -tunlp`
 
To check the machine connection state
`apt install net-tools`
`ifconfig -a `
`route -n `

Edit the file `/etc/network/interfaces`
On the `iface enp0s3 inet dhcp` change to 
`iface enp0s3 inet static`
to get them 

`   address xxx.xxx.xxx.x`

`   netmask xxxx.xxxx.xxx.xx`

`   gateway xxx.xxx.xxx.xx`

After restart it should have only the port 4242

- To add the public key in other computer 
`cat /etc/ssh/ssh_host_ed25519_key.pub`
- go to `vim ~/.ssh/know_hosts`
- add the public key now it should be able to connect in case it's not added automaticaly



## 4. Install UFW (Uncomplicated Firewall)

`apt install ufw`

`ufw enable`

`ufw status verbose`

</br>

`ufw default deny incoming`

`ufw allow 4242`
</br>

`ufw status numbered`

`ufw delete <rule-number> `

To enable log capture 
`sudo ufw logging on`
`sudo ufw logging medium`

to check logs go to

## 5. Sudo

 `apt install sudo`

 `sudo --version`





### 5.1. Configuring sudo policies 
Create a path to save sudo logs
`sudo mkdir /var/log/sudo`
`sudo vim /etc/sudoers`

file changed
`sudo visudo -f /etc/sudoers.d/sudoers-specs` 

Commands inserted on file 
`Defaults editor=/usr/bin/vim`

`Defaults passwd_tries=3`

`Defaults badpass_message="Incorrect Password"`

`Defaults logfile=/var/log/sudo/sudo.log`

`Defaults requiretty`

`Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"`

Extra commands on sudo 
 Add user name to sudo  
 `gpasswdd -a <username> sudo`

 Create new user
 `sudo adduser <username>`

 To see users that belong to group sudo
 `getent group sudo`
## 6.User settings
### 6.1. Connecting user via SSH
 To get server ip 
 `ip addr show`
 `hostname -I`
 On other machine: 
 if on linux 
 `ssh <server-user>@<server ip> -p <ssh-port>`
 on windows need to install putty
To exit connection
`logout`

`exit`

From this point on the commands I typed is connected on the server trough a user in the sudo user group, so when needed higher level of access it'll have sudo as prefix

### 6.2. Creating new users
__Users__:
To check all users on system  - `cat /etc/passwd`

To add new user - `sudo adduser <username>` -l for username | -c for fullname | -g for group id

To look for a specific user `getent passwd`

To delete user - `userdel -r <username>`

Rename user `usermod -l <login-name> <old-name>` -u to change by the UID

</br>

__Password settings__:

Verify user password settings - `sudo chage -l <username>`
Change expiracy password period `sudo chage -M <period-days> <username>`
Change number of days to allow password modification `sudo chage -m <period-days> <username>`
Receive warning before the password expires `chage -W <period> <username>`


For this project it should be 
`chage -M 30 <username/root>`
`chage -m 2 <username/root>`
`chage -W 7 <username/root>`
` chage -l <username/root>`

To apply to new existing users 
`sudo vim /etc/login.defs`


</br>


To have strong password policies any of the two packages can be used, and both are similar:
- cracklib - it has more options on password configuration
- pwquality - it fits the needs of the project, so I opted to use this one:

`sudo apt install libpam-pwquality`
 `sudo vim /etc/security/pwquality.conf`
  - do the followings changes
      - difok = 7
      - minlen = 10
      - dcredit = -1
      - ucredit = -1
      - lcredit = -1
      - maxrepeat = 3
      - usercheck = 1
      - retry = 3
      - enforce_for_root

To change password of a user `passwd <username>`
The password should be changed for all existing users



</br>

__Groups__

To check groups - `cat /etc/group`

groups a user is in - `groups <username>`

get only Group id  - `id -g <username>` 
create group - `sudo groupadd user42`

add user to group - `sudo gpasswd -a <user> <group>`

delete user from group - `sudo gpasswd -d <user> <group>`

delete group - `sudo groupdel <groupname>`

</br>

## 7. Configure CRON jobs

 - Shell script - all commands are on the monitoring.sh
 - Crontab
    - list all cron jobs set `sudo crontab -l`
    - edit cron jobs `sudo crontab -e`
 - to manage cron service
    `sudo systemctl enable cron.service`
    `sudo systemctl start cron.service`
    `sudo systemctl stop cron.service`
    `sudo systemctl restart cron.service`
    `sudo systemctl status cron.service`

    `sudo service ....`

### 7.1 Run commands when system starts
Ended up creating a system service instead of setting in a cron
`sudo vim /etc/systemd/system/monitoring_pc.service`
I saved the file path in `/usr/share/monitoring`  ; don't know if it's the best place
change file access `chmod a+x <file>`
more about https://www.freedesktop.org/software/systemd/man/systemd.service.html

`sudo systemctl daemon-reload`
`sudo systemctl start monitoring_pc.service`
`sudo systemctl status monitoring_pc.service`


## 7. others
 - Hostname
   - to change 
      -  `sudo hostnamectl set-hostname  <hostname>`
      -  edit the alias connection in `sudo vim /etc/hosts`
   - to show current host `hostnamectl` 
   https://askubuntu.com/questions/59458/error-message-sudo-unable-to-resolve-host-none
   
 - vim installation
   `sudo apt install vim`