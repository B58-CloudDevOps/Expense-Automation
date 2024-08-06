#!/bin/bash 

COMPONENT="frontend"
ID=$(id -u)
LOG="/tmp/frontend.log"

COLOR() {
    echo -e "\e[35m $* \e[0m"
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
dnf install nginx -y  &>> $LOG
stat $?

COLOR Copying Proxy file
cp proxy.conf /etc/nginx/default.d/expense.conf &>> $LOG
stat $?

COLOR Enabling Nginx
systemctl enable nginx &>> $LOG
stat $?

COLOR Performing a Cleanup
stat $?

COLOR Downloading $COMPONENT
curl -o /tmp/frontend.zip https://expense-web-app.s3.amazonaws.com/$COMPONENT.zip &>> $LOG
stat $?

cd /usr/share/nginx/html 
COLOR Extracting $COMPONENT 
unzip -o /tmp/$COMPONENT.zip &>> $LOG
stat $?

COLOR Starting $COMPONENT
systemctl restart nginx  &>> $LOG
stat $?

echo -e "\n\t** $COMPONENT Installation Is Completed **"