#!/bin/bash
sudo modprobe bcm2835-v4l2 && systemctl --user start obex && v4l2-ctl --set-ctrl horizontal_flip=1 &&\
echo "2" >/sys/class/gpio/export && sleep 3 && sudo echo "out" >/sys/class/gpio/gpio2/direction &&\
sleep 7 && cd Desktop/qmapboxglapp-tmpsantos-cheapruler
# && ./qmapboxglapp

echo "Init commands executed"
