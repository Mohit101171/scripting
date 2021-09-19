#!/bin/bash

source components/common.sh

COMPONENT=user
## NODEJS is a function from common.sh
NODEJS

Print "Restart Nginx\t\t"
systemctl restart nginx    &&  systemctl enable nginx
Status_Check $? 