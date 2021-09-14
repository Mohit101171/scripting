#!/bin/bash

source components/common.sh

Print "Installing Yum Utils & Downloading Redis Repos"
yum install epel-release yum-utils  http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$LOG
Status_Check $?

Print "Setup Redis Repos\t"
yum-config-manager --enable remi &>>$LOG
Status_Check $?

Print "Install Redis\t\t"
yum install redis -y &>>$LOG
Status_Check $?

Print "Configure Redis Listen Adress\t"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
Status_Check $?

Print "Start Redis Service\t\t"
systemctl enable redis && systemctl start redis &>>$LOG
Status_Check $?