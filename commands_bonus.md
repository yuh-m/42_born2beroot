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