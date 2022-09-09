#!/bin/bash

sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
echo "The hostname of the server is $(hostname -f)" > /var/www/html/index.html
echo "The health of the server is HEALTHY" > /var/www/html/health.html
