#!/bin/bash 

ID=$(id -u)

COLOR() {
    echo -e "\e[32m $* \e[0m"
} 

stat() {
    if [ $1 -eq  0 ] ; then 
        echo -e "\e[32m - Success \e[0m" 
    else 
        echo -e "\e[31m - Failure \e[0m" 
    fi 
}

if [ "$ID" -ne 0 ]; then 
    echo -e "\e[31m Script is expected to be executed as a root user or with sudo scriptName.sh \e[0m"
    echo -e "\t  sudo bash $0"
    exit 1
fi 

COLOR Installing Ngnix
dnf install nginx -y    &>> /tmp/frontend.log
stat $?

COLOR Copying Proxy file
cp proxy.conf /etc/nginx/default.d/expense.conf &>> /tmp/frontend.log
stat $?

COLOR Enabling Nginx
systemctl enable nginx &>> /tmp/frontend.log
stat $?

COLOR Performing a Cleanup
stat $?

COLOR Downloading Frontend
curl -o /tmp/frontend.zip https://expense-web-app.s3.amazonaws.com/frontend.zip &>> /tmp/frontend.log
stat $?

cd /usr/share/nginx/html 
COLOR Extracting frontend 
unzip -o /tmp/frontend.zip &>> /tmp/frontend.log
stat $?

COLOR Starting frontend
systemctl restart nginx  &>> /tmp/frontend.log
stat $?

echo -e "\n\t** Frontend Installation Is Completed **"