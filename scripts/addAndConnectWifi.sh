#!/bin/bash

#ssid="$(printf '%q\n' "$1")"
ssid=$1
y=$(wpa_cli add_network | sed -n '2p')
echo $y
echo $ssid
wpa_cli set_network $y ssid \"$ssid\"
wpa_cli set_network $y psk \"$2\"
#wpa_cli save_config

gpio mode 44 output
gpio write 44 1
sleep 2
gpio write 44 0
sleep 4

wpa_cli select_network $y
wpa_cli enable_network $y
wpa_cli save_config
sudo sed -i '/disabled=1/d' /etc/wpa_supplicant/wpa_supplicant.conf
