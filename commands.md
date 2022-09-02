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
 Add user name to sudo group 
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
 on windows need to install Ftty
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
# chage -l <username/root>
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

To change password of a user `passwd <username>`



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
I saved the file path in `/usr/share/monitoring`  ; don't if it's the best place
change file access `chmod a+x <file>`
more about https://www.freedesktop.org/software/systemd/man/systemd.service.html

`sudo systemctl daemon-reload`
`sudo systemctl start monitoring_pc.service`
`sudo systemctl status monitoring_pc.service`
## 8. Bonus

### 8.1 Lighttpd

`sudo apt install lighttpd`

`sudo systemctl start lighttpd`
`sudo systemctl enable lighttpd`
`sudo systemctl status lighttpd`

`sudo ufw allow http` - http the default port is 80.
`sudo ufw status`

### 8.2. MariaDB
 
 `apt install mariadb-server`
 `sudo systemctl start mariadb`
 `sudo systemctl enable mariadb`
 `sudo systemctl status mariadb`

 `mysql_secure_installation` enable to set a root password, disable root logins from outside localhost, remove anonymous user accounts, remove the test database and then reload the privilege tables. It will ask for these settings.
 - Switch to unix_socket authentication [Y/n]: Y
 - Enter current password for root (enter for none): Enter
 - Set root password? [Y/n]: Y
 - New password: 
 - Re-enter new password: 
 - Remove anonymous users? [Y/n]: Y
 - Disallow root login remotely? [Y/n]: Y
 - Remove test database and access to it? [Y/n]:  Y
 - Reload privilege tables now? [Y/n]:  Y

</br>

 `sudo systemctl restart mariadb`
To connect to mariadb 
`mariadb -u root -p `

Connect to MariaDB
 - CREATE DATABASE wordpress;
 - CREATE USER 'admin'@'localhost' IDENTIFIED BY 'wpadmin';
 - GRANT ALL ON wordpress.* TO 'admin'@'localhost' IDENTIFIED BY 'wpadmin' WITH GRANT OPTION;
 - FLUSH PRIVILEGES
 - SHOW databases;
 - EXIT;

</br>
To check for username and host on MariaDB
`SELECT user from mysql.user;`
`SHOW GRANTS FOR <username>@localhost;`
`SELECT @@hostname;`
`SHOW variables WHERE Variable_name LIKE '%host%';`

### 8.2. PHP
 `sudo apt update `
 `sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https `
 `sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'  `
 `sudo apt install wget`
 - wget depends of gnupg to run - it basicaly check the address you believe its safe to download. 
   - https://superuser.com/a/655250
   - `sudo install gnupg gnupg1 gnupg2`
 `wget -O - https://packages.sury.org/php/apt.gpg | sudo apt-key add -  `
 `sudo apt-key list` - to check the gpg keys in the system

 - restart after this
`sudo apt install php8.1 ` - this was the updated version available


`apt purge apache2`
`apt purge apache2-bin`
`apt purge apache2-data`
`apt purge apache2-utils`
Deleting all traces of apache2 
- restart again 

`php -m` - will list the modules already installed

`sudo apt install php-curl php-imagick php-mbstring php-xml php-zip` from the list I found these modules are recommended to wordpress run withou problem

Tutorial on how to set ligghttpd with php before installing wordpress 
https://geekrewind.com/setup-lighttpd-web-server-with-php-supports-on-ubuntu-servers/

`sudo apt install php8.1-cli php8.1-mbstring php8.1-xml php8.1-common php8.1-curl php8.1-mcrypt php8.1-mysql` - following the tutorial to make the lighttpd and php connection work - 

`sudo apt install php8.1-fpm` -in case it was not installed
`sudo apt install php8.1-cgi` - it handles high loads of requests and organize them to not overload the servers - required for lighttpd


`sudo lighttpd-enable-mod fastcgi` 
`sudo lighttpd-enable-mod fastcgi-php`
`sudo service lighttpd force-reload`

Files with configuration.    
`sudo vim /etc/php/8.1/cgi/php.ini` - to configure how php interacts with http loads
`sudo vim /etc/lighttpd/lighttpd.conf` - configure overall conf of lighttpd
`sudo vim /etc/lighttpd/conf-available/15-fastcgi-php.conf` -

`sudo vim /etc/php/8.1/fpm/pool.d/www.conf `
They should follow as the print 
### 8.3. Install wordpress
`sudo apt install tar`
`wget http://wordpress.org/latest.tar.gz `
` tar -xzvf latest.tar.gz `
` sudo mv wordpress/* /var/www/html/  `
` rm -rf latest.tar.gz wordpress ` 

`sudo chown -R www-data:www-data /var/www/html/` - gives permission to this group www-data to this path
`chmod -R 755 /var/www/html/` - change rights permission on this folder

Fast and easy way to finish wordpress install - connect in a browser to this page where it'll lead to a fast setup page 
`<ip address >/readme.html `

</br>

Otherwise: 
`mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php`
`sudo vim /var/www/html/wp-config.php ` - configure to which database the wordpress should use

Restart lighttpd server
`sudo systemctl start lighttpd`

### 8.4. PHP

## 7. others
 - Hostname
   - to change 
      -  `sudo hostnamectl set-hostname  <hostname>`
      -  edit the alias connection in `sudo vim /etc/hosts`
   - to show current host `hostnamectl` 
 - vim installation
   `sudo apt install vim`