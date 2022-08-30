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
 On other machine: 
 if on linux 
 `ssh <server-user>@<server ip> -p <ssh-port>`
 on windows need to install F
To exit connection
`logout`
`exit`

From this point on the commands I typed is connected on the server trough a user in the sudo user group
#### 4.1.3 Configuring sudo policies 
Create a path to save sudo logs
`sudo mkdir /var/log/sudo`
`sudo vim /etc/sudoers`
To use vim on visudo

`sudo visudo -f /etc/sudoers.d/sudoers-specs` 
Commands inserted on file 
`Defaults editor=/usr/bin/vim`
`Defaults passwd_tries=3`
`Defaults logfile=/var/log/sudo/sudo.log`
`Defaults requiretty`
`Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"`

To check all users on system 
`less /etc/passwd`
`
To check all groups and users on system
`less /etc/group
### 7. others
 - vim installation
   `sudo apt install vim`