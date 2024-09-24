#!/bin/bash
yum install nginx -y
echo "<h1>Welcome to Terraform: $(hostname -I) </h1>" > /usr/share/nginx/html/index.html
systemctl start nginx