#!/bin/bash

source components/common.sh

Print "Installing NodeJS"
yum install nodejs make gcc-c++ -y &>>$LOG
Status_Check $?

Print "Adding Roboshop User"
useradd robohsop &>>$LOG
Status_Check $?

Print "Downloading Catalogue Content"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
Status_Check $?


cd /home/roboshop/catalogue
npm install --unsafe-perm &>>$LOG

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue

