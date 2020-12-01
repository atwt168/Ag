#!/bin/bash
ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null && echo "Wifi Connected" || (echo "ERROR: No internet connection" &&  exit 1)
echo "Downloading ..."
sudo rm -r /home/pi/Ag
cd /home/pi && git clone $1 || exit 1
#sudo rm -r /home/pi/Argon20/* 
#sudo cp -r /home/pi/Ag/* /home/pi/Argon20
cd /home/pi/Argon20 && sudo chmod +x ./*
#sudo rm -r /home/pi/Ag/*
