#!/bin/bash
sudo cp WpaSuppTemp $1
sed -i "s/newid/$1/g" $1
sed -i "s/password/$2/g" $1
sudo cp ./$1 /etc/wpa_supplicant/wpa_supplicant.conf
sudo reboot
