#!/bin/bash 

ID=$(id -u)

if [ "$ID" -ne 0 ]; then 
    echo -e "\e[31m Script is expected to be executed as a root user or with sudo scriptName.sh \e[0m"
    echo -e "\t  sudo bash $0"
    exit 1
fi 

echo -e "\e[35m Installing Nginx \e[0m"
dnf install nginx -y    &>> /tmp/frontend.log
if [ $? -eq  0 ] ; then 
    echo -e "\e[ 31m - Success \e[0m" 
else 
    echo -e "\e[ 32m - Failure \e[0m" 
fi 

echo -e "\e[35m  Copying Proxy file \e[0m"
cp proxy.conf /etc/nginx/default.d/expense.conf &>> /tmp/frontend.log
if [ $? -eq  0 ] ; then 
    echo -e "\e[ 31m - Success \e[0m" 
else 
    echo -e "\e[ 32m - Failure \e[0m" 
fi 

echo -e "\e[35m  Enabling Nginx \e[0m"
systemctl enable nginx &>> /tmp/frontend.log
if [ $? -eq  0 ] ; then 
    echo -e "\e[32m - Success \e[0m" 
else 
    echo -e "\e[31m - Failure \e[0m" 
fi 

echo -e "\e[35m  Performing a Cleanup \e[0m"
rm -rf /usr/share/nginx/html/*    &>> /tmp/frontend.log
if [ $? -eq  0 ] ; then 
    echo -e "\e[32m - Success \e[0m" 
else 
    echo -e "\e[31m - Failure \e[0m" 
fi 

echo -e "\e[35m  Downloading Frontend \e[0m"
curl -o /tmp/frontend.zip https://expense-web-app.s3.amazonaws.com/frontend.zip &>> /tmp/frontend.log
if [ $? -eq  0 ] ; then 
    echo -e "\e[32m - Success \e[0m" 
else 
    echo -e "\e[31m - Failure \e[0m" 
fi 

cd /usr/share/nginx/html 
echo -e "\e[35m  Extracting frontend \e[0m"
unzip -o /tmp/frontend.zip &>> /tmp/frontend.log
if [ $? -eq  0 ] ; then 
    echo -e "\e[32m - Success \e[0m" 
else 
    echo -e "\e[31m - Failure \e[0m" 
fi 

echo -e "\e[35m Starting frontend \e[0m"
systemctl restart nginx  &>> /tmp/frontend.log
if [ $? -eq  0 ] ; then 
    echo -e "\e[32m - Success \e[0m" 
else 
    echo -e "\e[31m - Failure \e[0m" 
fi 

echo "** Frontend Installation Is Completed **"