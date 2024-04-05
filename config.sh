#!/bin/bash
sudo apt update
# new_url="dev-alb-228261188.us-east-1.elb.amazonaws.com"  # Change the DNS give actual DEV-ALB DNS
# Modify package.json with the ALB DNS placeholder
sed -i 's/"homepage": "https:\/\/opstree.github.io",/"homepage": "http:\/\/${new_url}",/' /home/ubuntu/Frontend/package.json
sed -i '/"proxy": "http:\/\/localhost:3000"/d' /home/ubuntu/Frontend/package.json

## Modify src directory
sed -i "s|http://34.72.54.44:8080|${new_url}|g" /home/ubuntu/Frontend/src/ListSalary.js

sed -i "s|http://16.171.175.47:8080|${new_url}|g" /home/ubuntu/Frontend/src/AttendanceForm.js /home/ubuntu/Frontend/src/AttendanceList.js

sed -i "s|http://35.193.0.217:8080|${new_url}|g" /home/ubuntu/Frontend/src/EmployeeData.js

sed -i "s|http://34.72.54.44/:8080|${new_url}|g" /home/ubuntu/Frontend/src/EmployeeForm.js /home/ubuntu/Frontend/src/EmployeeList.js

# Start your application
export NODE_OPTIONS="--max-old-space-size=512"

# cd /home/ubuntu/Frontend && npm install

sudo systemctl start frontend.service 

sudo systemctl enable frontend.service
