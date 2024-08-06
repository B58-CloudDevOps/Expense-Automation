#!/bin/bash 

ID=$(id -u)

if [ "$ID" -ne 0 ]; then 
    echo -e "\e[31m Script is expected to be executed as a root user or with sudo scriptName.sh \e[0m"
    echo -e "\t  sudo bash $0"
    exit 1
fi 

echo "Installing Nginx"
dnf install nginx -y  

echo "Copying Proxy file"
cp proxy.conf /etc/nginx/default.d/expense.conf 

echo "Enabling Nginx"
systemctl enable nginx

echo "Performing a Cleanup"
rm -rf /usr/share/nginx/html/*   

echo "Downloading Frontend"
curl -o /tmp/frontend.zip https://expense-web-app.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html 

echo "Extracting frontend"
unzip -o /tmp/frontend.zip

echo "Starting frontend"
systemctl restart nginx 

echo "** Frontend Installation Is Completed **"