#!/usr/bin/env bash

# ---------------------------------------
#          Create project folder
# ---------------------------------------

PROJECTFOLDER="newproject"

# ---------------------------------------
#          Virtual Machine Setup
# ---------------------------------------

# Adding multiverse sources.
cat > /etc/apt/sources.list.d/multiverse.list << EOF
deb http://archive.ubuntu.com/ubuntu trusty multiverse
deb http://archive.ubuntu.com/ubuntu trusty-updates multiverse
deb http://security.ubuntu.com/ubuntu trusty-security multiverse
EOF


# Updating packages
apt-get update

# ---------------------------------------
#          Apache Setup
# ---------------------------------------

# Installing Packages
apt-get install -y apache2 libapache2-mod-fastcgi apache2-mpm-worker
apt-get  -y install php5

# Add ServerName to httpd.conf
echo "ServerName localhost" > /etc/apache2/httpd.conf
# Setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/var/www/html/${PROJECTFOLDER}"
  ServerName localhost
  <Directory "/var/www/html/${PROJECTFOLDER}">
    AllowOverride All
  </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default.conf

# Loading needed modules to make apache work
a2enmod actions fastcgi rewrite
service apache2 reload

sudo mkdir "/var/www/html/${PROJECTFOLDER}"

HELLO=$(cat <<EOF
<!DOCTYPE html>
<html>
<head>
  <title>Hello World!</title>
</head>
<body>
  <h1>Hello World!</h1>
</body>
</html>
EOF
)
echo "${HELLO}" > /var/www/html/newproject/hello_world.html

HELLO_PHP=$(cat <<EOF
<?php
echo "\nHello World!";
echo "\nHost name: " .shell_exec(hostname);
?>
EOF
)

echo "${HELLO_PHP}" > /var/www/html/newproject/hello.php


