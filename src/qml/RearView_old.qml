import QtQuick 2.0

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick 2.0
import QtMultimedia 5.8
import Process 1.0
import QtGraphicalEffects 1.0
//- RUN THIS FIRST
//systemctl --user start obex
//



Item {
    width: parent.width
    height: parent.height
    property bool rvGpsbarVisibility: false
    property bool recording: false
    property var locale: Qt.locale()
    property date currentTime: new Date()
    property string dateTimeString: "Tue 2013-09-17 10:56:06"

    function stopRear(){
        cameraRear.stop();
    }

    function startRear(){
        cameraRear.start();
    }

    function startMusic(artist,title,active){
        rvgpsbar.startMusic(artist,title,active);
    }

//    Camera {
//        id: cameraFront
//        deviceId: QtMultimedia.availableCameras[1].deviceId
//        videoRecorder.mediaContainer: "mp4"
////        imageCapture {
////            onImageCaptured: {
////                // Show the preview in an Image
////                photoPreview.source = preview
////            }
////        }
//    }

    RearViewGPSBar {
        id: rvgpsbar
        anchors.left: parent.left
        anchors.right: parent.right
        visible: rvGpsbarVisibility
        z: 1

    }

    Camera {
        id: cameraRear
        deviceId: QtMultimedia.availableCameras[1].deviceId


    }

    VideoOutput {
        source: cameraRear
        focus : visible
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent;
//            onClicked: cameraFront.imageCapture.captureToLocation("/home/pi/Desktop/qmapboxglapp-tmpsantos-cheapruler");
            onClicked:{
//                console.log(cameraRear.videoRecorder.recorderState)
//                if(cameraRear.videoRecorder.recorderState==0){
//                    cameraRear.videoRecorder.record();
//                }else{
//                    cameraRear.videoRecorder.stop();
//                }
                if(!recording){
                    //var dateString = Date.fromLocaleTimeString(locale, currentTime.toLocaleTimeString(locale, Locale.NarrowFormat), "ddd yyyy-MM-dd hh:mm:ss");
                    //var dateString = Date.fromLocaleString(locale, dateTimeString, "ddd yyyy-MM-dd hh:mm:ss")
                    var dateString = Qt.formatDateTime(new Date(),"dd-MM-yy_hh:mm:ss");

                    recording = true;
                    var recordCmd = "ffmpeg -an -f v4l2 -s 320x240 -r 30 -i /dev/video0 -vcodec mpeg4 -vtag DIVX ./frontCamRecordings/vid_"+dateString+".avi"

                    process.start(recordCmd,[" "]);
                }
                else{
                    recording = false
                    console.log("Stop recording");
                    process.stop();
                    //process.start("sudo killall ffmpeg",[" "]);
                }


            }
        }

    }


    }
//}


