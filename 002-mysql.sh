#!/bin/bash 

COMPONENT="mysql"
ROOTPASS=$1
ID=$(id -u)
LOG="/tmp/mysql.log"

COLOR() {
    echo -e "\e[35m $* \e[0m"
} 

stat() {
    if [ $1 -eq  0 ] ; then 
        echo -e "\e[32m - Success \e[0m" 
    else 
        echo -e "\e[31m - Failure \e[0m" 
        exit 2
    fi 
}

if [ "$ID" -ne 0 ]; then 
    echo -e "\e[31m Script is expected to be executed as a root user or with sudo scriptName.sh \e[0m"
    echo -e "\t sudo bash $0"
    exit 1
fi 

COLOR Installing $COMPONENT
dnf install mysql-server -y  &>> $LOG
stat $?

COLOR Enabling $COMPONENT
systemctl enable mysqld       &>> $LOG
stat $?

COLOR Starting $COMPONENT 
systemctl start  mysqld        &>> $LOG      
stat $?


COLOR Configuring $COMPONENT Root Password
mysql_secure_installation --set-root-pass $ROOTPASS
stat $?

# echo "show databases;" | mysql -uroot -pExpenseApp@1 
# if [ $? -ne 0 ] ; then 
#     COLOR Configuring $COMPONENT Root Password
#     mysql_secure_installation --set-root-pass ExpenseApp@1
#     stat $?
# fi 

echo -e "\n\t ** Mysql Installation Completed **"
