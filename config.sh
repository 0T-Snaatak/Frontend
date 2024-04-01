#!/bin/bash

new_url=${ALB_DNS}

sed -i "s|http://34.72.54.44:8080|$new_url|g" /home/harshit/Frontend/src/ListSalary.js

sed -i "s|http://16.171.175.47:8080|$new_url|g" /home/harshit/Frontend/src/AttendanceForm.js /home/harshit/Frontend/src/AttendanceList.js

sed -i "s|http://35.193.0.217:8080|$new_url|g" /home/harshit/Frontend/src/EmployeeData.js

sed -i "s|http://34.72.54.44/:8080|$new_url|g" /home/harshit/Frontend/src/EmployeeForm.js /home/harshit/Frontend/src/EmployeeList.js