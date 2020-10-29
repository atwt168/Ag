import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Extras 1.4
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12
import QtMultimedia 5.8
import Process 1.0

Item {
    id: root
    visible: true
    width: 640
    height: 480

    focus: true
      Keys.onPressed: {
          if (event.key == Qt.Key_Backspace) {
              console.log("move backspace");
              cameraFront.videoRecorder.record();
              event.accepted = true;
          }
      }

    //DIRECTION ARROWS
    property bool directionActive: false
    property string directionSource: "qrc:/Direction_Arrow/Left_turn.png"
    property string newDirectionSource: "qrc:/Direction_Arrow/Left_turn.png"
    //BATTERY
    property string battSource
    //RECORDING/PHONE/MUSIC ON/OFF STATE
    property bool recordingActive: false
    property bool frontCameraMounted: false
    property bool phoneActive: false
    property bool musicActive: false
    //Ble controller
    property bool bleControllerActive: false
    //PHONE
    property bool phoneVisible: phoneActive
    //RECORDING
    // property bool recordingVisible: recordingActive
    //MUSIC
    property bool musicVisible: musicActive && !phoneActive

    //COLOR BAR
    property string speedLimitColorIndicator: ""
    //INSTRUCTION
    property bool instructionCallAnimationSlideIn
    property bool instructionCallAnimationSlideOut: false
    property bool instructionMusicAnimationFadeIn
    property bool instructionMusicAnimationFadeOut: false
    //property var arrowPaths: ["qrc:/Direction_Arrow/Exit_left.png", "qrc:/Direction_Arrow/Exit_right.png", "qrc:/Direction_Arrow/Filter_left.png", "qrc:/Direction_Arrow/Filter_right.png", "qrc:/Direction_Arrow/Fork_left.png", "qrc:/Direction_Arrow/Fork_right.png", "qrc:/Direction_Arrow/Left_turn.png", "qrc:/Direction_Arrow/Right_turn.png", "qrc:/Direction_Arrow/Roundabout(1).png", "qrc:/Direction_Arrow/Roundabout(2).png", "qrc:/Direction_Arrow/Roundabout(3).png", "qrc:/Direction_Arrow/Roundabout(4).png", "qrc:/Direction_Arrow/Roundabout_all_exit(1).png", "qrc:/Direction_Arrow/Roundabout_all_exit(2).png", "qrc:/Direction_Arrow/Roundabout_exit_left(1).png", "qrc:/Direction_Arrow/Roundabout_exit_left(2).png", "qrc:/Direction_Arrow/Roundabout_exit_right(1).png", "qrc:/Direction_Arrow/Roundabout_exit_right(2).png", "qrc:/Direction_Arrow/Roundabout_exit_straight(1).png", "qrc:/Direction_Arrow/Roundabout_exit_straight(2).png", "qrc:/Direction_Arrow/T-junction_exit_left.png", "qrc:/Direction_Arrow/T-junction_exit_right.png", "qrc:/Direction_Arrow/U-turn_left.png", "qrc:/Direction_Arrow/U-turn_right.png"]
    property var arrowPathsIndex: 0
    property string musicText: ""
    property string callText: ""
    //    property var musicTextPaths
    //    property var musicTextPathsIndex
    property var instructionMusicBarOpacity: infoBar.instructionMusicBarOpacity
    property bool infoBarVisible: true
    //SPEEDOMETER
    property int speedLimit: 110
    property string speedLimitText: "-"
    property string distUnits: "km/h"
    //INFOBAR
    property string infoBarText: ""
    property string infoBarDistText: ""
    property int currentSpeed: 0

    signal messageRearView(var instructionMusicBarOpacity)
    // sudo apt-get install libav-tools
    onInstructionMusicBarOpacityChanged: {
        messageRearView(instructionMusicBarOpacity)
    }

    Component.onCompleted: {
        cameraRear.start()
        // console.log("avail cams "+QtMultimedia.availableCameras[0].deviceId)
    }


//    signal qmlReceive(string textIn)
//    onQmlReceive: {
//        console.log(textIn)
//    }

    Component.onDestruction: {
        cameraRear.stop()
        
    }

    onRecordingActiveChanged: {
        console.log("onRecordingActiveChanged")
        //        cameraFront.deleteLater()
        if (recordingActive) {
//            var dateString = Qt.formatDateTime(new Date(), "dd-MM-yy_hh:mm:ss")
            //            var recordCmd = "ffmpeg -an -f v4l2 -s 320x240 -r 30 -i /dev/video0 -vcodec mpeg4 -vtag DIVX ./frontCamRecordings/vid_" + dateString + ".avi"
            //                ***
            //            var recordCmd = "ffmpeg -f v4l2 -s 1280x720 -r 30 -input_format mjpeg -i /dev/video0 -vcodec libx265 -crf 24 -c:v copy ./frontCamRecordings/"+dateString+".mp4";
            //                ***
            //            process.start("sudo sh /home/pi/qmapboxglapp-tmpsantos-cheapruler/runFrontRecording.sh", [" "]);
            //            process.start("echo haha > haha.txt", [" "]);
            //            process.start(recordCmd,[" "]);

            //            cameraFront.videoRecorder.record();
            console.log("front recording on")
            //cameraRear.stop()
        } else {
            console.log("front recording off")
             //cameraRear.start()
            //            process.stop();
        }
    }



    //Load in Roboto Medium font
    FontLoader {
        id: localFont
        source: "qrc:/fonts/Roboto-Medium.ttf"
    }



    Text {
        id: text
    }

    Process {
        id: process
        onReadyRead: text.text = readAll();
    }


    //Load in background image || Rear cam
    Camera {
        id: cameraRear
        deviceId: QtMultimedia.availableCameras[0].deviceId

//                videoRecorder.actualLocation: "/home/pi/qmapboxglapp-tmpsantos-cheapruler/rearCamRecordings"
//                videoRecorder.outputLocation: "/home/pi/qmapboxglapp-tmpsantos-cheapruler/rearCamRecordings"
//                videoRecorder.videoEncodingMode: videoRecorder.ConstantQualityEncoding
//                videoRecorder.mediaContainer: "mkv"
//                imageCapture {
//                    onImageCaptured: {
//                        // Show the preview in an Image
//                        console.log("CAPTURED")
//                    }
//                    onImageSaved: {
//                        console.log("SAVED")
//                    }
//                }
    }
//    Camera {
//        id: cameraFront
//        deviceId: QtMultimedia.availableCameras[0].deviceId
////        videoRecorder.actualLocation: "/home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings"
//        videoRecorder.outputLocation: "/home/pi/qmapboxglapp-tmpsantos-cheapruler/frontCamRecordings"
//        videoRecorder.videoEncodingMode: videoRecorder.ConstantQualityEncoding
//        videoRecorder.mediaContainer: "mp4"
//        imageCapture {
//            onImageCaptured: {
//                // Show the preview in an Image
//                console.log("CAPTURED")
//            }
//            onImageSaved: {
//                console.log("SAVED")
//            }
//        }
//    }

    VideoOutput {
        source: cameraRear
        focus: visible
        anchors.fill: parent
        // orientation: Camera.BackFace
        fillMode:  VideoOutput.PreserveAspectCrop

        InfoBar {
            id: infoBar
            anchors.fill: parent
            visible: infoBarVisible
            musicText: root.musicText
            callText: root.callText
            newDirectionSource: root.newDirectionSource
            directionSource: root.directionSource
            directionActive: root.directionActive
            speedLimitText: root.speedLimitText
            speedLimit: root.speedLimit
            battSource: root.battSource
            recordingVisible: root.recordingActive
            frontCameraMounted: root.frontCameraMounted
            phoneVisible: root.phoneVisible
            musicVisible: root.musicVisible
            bleControllerActive: root.bleControllerActive
            instructionMusicAnimationFadeIn: root.instructionMusicAnimationFadeIn
            instructionMusicAnimationFadeOut: root.instructionMusicAnimationFadeOut
            instructionCallAnimationSlideIn: root.instructionCallAnimationSlideIn
            instructionCallAnimationSlideOut: root.instructionCallAnimationSlideOut
            speedLimitColorIndicator: root.speedLimitColorIndicator
            infoBarText: root.infoBarText
            infoBarDistText: root.infoBarDistText
            currentSpeed: root.currentSpeed
            distUnits: root.distUnits
        }


    }


}
