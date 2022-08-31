## Commands for setup the machine 
### 2. Creating partitions 

### 2.2. Snapshot of- 
Create a snapshop - with the VM turned off 

Retrieve the state of the machine
    shalsum <virtual disk>.vdi
'a'
### 2.3. General info after setup
For giving information of OS
` cat /etc/os-release `

Check if AppArmor is enabled
` /usr/sbin/aa-status `
otherwise 
` systemctl enable apparmor`


` /usr/sbin/ufw status `

#
### 2 SSH install 

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
`   address xxx.xxx.xxx.x`
`   netmask xxxx.xxxx.xxx.xx`
`   gateway xxx.xxx.xxx.xx`

### 3. Install UFW (Uncomplicated Firewall)
`apt install ufw`
`ufw enable`
`ufw status verbose`

`ufw default deny incoming`
`ufw allow 4242`

`ufw status numbered`
`ufw delete <rule-number> `

### 4.User settings
#### 4.1 Sudo
 `apt install sudo`
 `sudo --version`

 Add user name to sudo group
 `add <username> sudo`

 Create new user
 `sudo adduser <username>`

 To see users that belong to group sudo
 `getent group sudo`

### 4.1.2 Connecting user via SSH
 To get server ip 
 `ip addr show`
 `hostname -I`
 On other machine: 
 if on linux 
 `ssh <server-user>@<server ip> -p <ssh-port>`
 on windows need to install Ftty
To exit connection
`logout`
`exit`

From this point on the commands I typed is connected on the server trough a user in the sudo user group, so when needed higher level of access it'll have sudo as prefix
#### 4.1.3 Configuring sudo policies 
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

### 4.2. Creating new users
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

</br>
To have strong password policies any of the two packages can be used, and both are similar

- cracklib - it has more options on password configuration
- pwquality - it fits the needs of the project, so I opted to use this one:
`sudo apt install libpam-pwquality`
 `sudo vim /etc/security/pwquality.conf`
  - do the followings changes
      - difok = 7
      - minlen = 10
      - dcredit = -1
      - ucredit = -1
      - maxrepeat = 3
      - usercheck = 1
      - retry = 3
      - enforce_for_root

To change password of a user `psswrd <username>`



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

###5. Configure CRON jobs
 5.1. Shell script - all commands are on 
### 7. others
 - Hostname
   - to change 
      -  `sudo hostnamectl set-hostname  <hostname>`
      -  edit the alias connection in `sudo vim /etc/hosts`
   - to show current host `hostnamectl` 
 - vim installation
   `sudo apt install vim`