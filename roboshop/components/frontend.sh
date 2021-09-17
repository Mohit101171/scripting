#!/bin/bash


source components/common.sh

Print "INstall Nginx"
yum install nginx -y &>>$LOG
Status_Check $?

Print "Download Frontend Archive"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
Status_Check $?

Print "Extract Frontend Archive"
rm -rf /usr/share/nginx/html && cd /usr/share/nginx && unzip -o /tmp/frontend.zip && mv frontend-main/* &>>$LOG && mv static/* . 
Status_Check $?

Print "Update Nginx"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
Status_Check $?

Print "Restart Nginx"
systemctl restart nginx &>>$LOG && systemctl enable nginx $>>$LOG
Status_Check $?