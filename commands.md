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
`   address`
`   netmask`
`   gateway`

### 3 Install UFW (Uncomplicated Firewall)
`apt install ufw`
`ufw enable`
`ufw status verbose`

`ufw default deny incoming`
`ufw allow 4242`

`ufw status numbered`
`ufw delete <rule-number> `

    More commands
- https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29
### 7 Install vim
 `sudo apt install vim`