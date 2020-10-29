#!/bin/bash

#let file_num=$(cd tmp && ls -l | grep -v ^d | wc -l)-1
#echo $file_num

#ffmpeg -f concat -i textfile -c copy -fflags +genpts merged.mp4
let TOTALTIME=60
let SEGTIME=10
#let RECORDINGDIR="/home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/"
#let TMP = "tmp"
let TMPDIR="/home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/tmp"
let run=1

rm /home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/filesTo*

while [ "$run" -eq 1 ]
do
  # Check if tmp has more than n files
  DATETIME=`date +"%Y-%m-%d__%H-%M-%S"`

  let file_num=$(cd /home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/tmp/ && ls -l | grep -v ^d | wc -l)-1

  if [ $file_num -gt 5 ]
  then
    run=0
     #Generate textfile with filenames in tmp then delete all files in tmp
    cd /home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/tmp && printf "file 'tmp/%s'\n" * > /home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/filesToMerge && printf "'%s'\n" * > /home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/filesToDelete && cd ..
     	
    ffmpeg -f concat -safe 0 -i filesToMerge -c copy -fflags +genpts concat_$DATETIME.mp4 && \
   # let pid=$!
   # wait $pid
    rm /home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings/tmp/* &&\
    rm filesToMerge && rm filesToDelete
    echo "DONE"

    run=1

  fi

done

