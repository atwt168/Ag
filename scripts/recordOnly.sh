#!/bin/bash

# Kill any existing camera process
kill -9 $(lsof -t /dev/video0)

#Create tmp folder if doesnt exist
mkdir -p /home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/tmp


let RECORDINGDIR="/home/pi/Desktop/test"
let DURATION = 60

while true
do
  # Check if tmp has more than n files
  DATETIME=`date +"%Y_%m_%d__%H_%M_%S"`

  
  ffmpeg -f v4l2 -s 640x480 -r 30 -input_format mjpeg -i /dev/video0 -vcodec libx265 -crf 18 -t 10 -c:v copy /home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/vid_$DATETIME.mp4 &
#  cmd &
  BACK_PID=$!
  wait $BACK_PID
  mv /home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/vid_$DATETIME.mp4 /home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/tmp


  done 
  
done

