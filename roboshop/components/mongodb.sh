#!/bin/bash

Status_Check() {
  if [$1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
  fi
} 

Print() {
  echo -n -e "$1 \t- "
}
 
Print "Setting up MongoDB Repo"
echo '[mongodb-orog-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
Status_Check $?

Print "Installing MongoDB"
 yum install -y mongodb-org &>>$LOG
 

Print "Configuring MongoDB"
 sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
Status_Check $1

Print "Starting MongoDB"
 systemctl enable mongod
 systemctl restart mongod
Status_Check $1

Print "Downloading MongoDB Schema"
 curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"

 cd /tmp
 Print "Extracting Schema"
 unzip mongodb.zip &>>$LOG
 Status_Check $1
 
 
 cd mongodb-main
 Print "Loading Schema\t\t"
 mongo < catalogue.js &>>$LOG
 mongo < users.js  &>>$LOG
 
 exit 0