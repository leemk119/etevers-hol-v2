#!/bin/sh

#Install a LAMP stack
dnf install -y httpd wget php-fpm php-mysqli php-json php php-devel
dnf install -y mariadb105-server
dnf install -y httpd php-mbstring

#Start the web server
chkconfig httpd on
systemctl start httpd

#Install the web pages for our lab
if [ ! -f /var/www/html/Cloud-up-app-php7.zip ]; then
   cd /var/www/html
   wget -O 'Cloud-up-app-php7.zip' 'https://etevers-hol.s3.ap-northeast-2.amazonaws.com/Cloud-up-app-php7.zip'
   unzip Cloud-up-app-php7.zip
fi

#Install the AWS SDK for PHP
if [ ! -f /var/www/html/aws.zip ]; then
   cd /var/www/html
   mkdir vendor
   cd vendor
   wget https://etevers-hol.s3.ap-northeast-2.amazonaws.com/aws.zip
   unzip aws.zip
fi

# Update existing packages
dnf update -y