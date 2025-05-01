#!/bin/bash 

cd /home/ubuntu/backendCode

pm2 stop all

pm2 delete all

pm2 start app.js

pm2 save