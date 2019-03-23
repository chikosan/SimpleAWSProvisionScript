#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd mariadb-server
sudo usermod -a -G docker ec2-user
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl enable docker
sudo service docker start
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
echo $(hostname) ,$(curl ifconfig.me -s) > /var/www/html/index.html
