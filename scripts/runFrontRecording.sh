DATETIME=`date +"%Y-%m-%d_%T"`
ffmpeg -f v4l2 -s 1280x720 -r 30 -input_format mjpeg -i /dev/video0 -vcodec libx265 -crf 24 -c:v copy /home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/${DATETIME}.mp4
