#!/bin/bash

source components/common.sh

Print "Installing NodeJS\t"
yum install nodejs make gcc-c++ -y &>>$LOG
Status_Check $?

Print "Adding Roboshop User\t"
id roboshop &>>$LOG
if [ $? -eq 0 ]; then
echo "User already exists hence skipping"
else
useradd roboshop &>>$LOG
fi
Status_Check $?

Print "Downloading Catalogue Content"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
Status_Check $?

Print "Extracting Catalogue\t"
cd /home/roboshop
rm -rf catalogue && unzip -o /tmp/catalogue.zip &>>$LOG && mv catalogue-main catalogue
Status_Check $?

Print "Download NodeJS Dependencies"
cd /home/roboshop/catalogue
npm install --unsafe-perm &>>$LOG
Status_Check $?

chown roboshop:roboshop -R /home/roboshop

Print "Update SystemD Service\t"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.servic
Status_Check $?

Print "Setup SystemD Service\t"
 mv /home/roboshop/catalogue/systemd.service  /etc/systemd/system/catalogue.service && systemctl daemon-reload && systemctl restart catalogue && systemctl enable catalogue &>>$LOG
 Status_Check $?
 

