import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Extras 1.4
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12
import QtMultimedia 5.6

Item {
    id: root
    visible: true
    width: 640
    height: 480

    //DIRECTION ARROWS
    property bool directionActive: false
    property string directionSource: "qrc:/Direction_Arrow/Left_turn.png"
    property string newDirectionSource: "qrc:/Direction_Arrow/Left_turn.png"
    //BATTERY
    property string battSource
    //RECORDING/PHONE/MUSIC ON/OFF STATE
    property bool recordingActive: false
    property bool phoneActive: false
    property bool musicActive: false
    //PHONE
    property bool phoneVisible: phoneActive
    //RECORDING
    property bool recordingVisible: recordingActive
    //MUSIC
    property bool musicVisible: musicActive && !phoneActive
    //COLOR BAR
    property string speedLimitColorIndicator: "#00c7ff" //Blue
    //INSTRUCTION
    property bool instructionCallAnimationSlideIn
    property bool instructionCallAnimationSlideOut: false
    property bool instructionMusicAnimationFadeIn
    property bool instructionMusicAnimationFadeOut: false
    //property var arrowPaths: ["qrc:/Direction_Arrow/Exit_left.png", "qrc:/Direction_Arrow/Exit_right.png", "qrc:/Direction_Arrow/Filter_left.png", "qrc:/Direction_Arrow/Filter_right.png", "qrc:/Direction_Arrow/Fork_left.png", "qrc:/Direction_Arrow/Fork_right.png", "qrc:/Direction_Arrow/Left_turn.png", "qrc:/Direction_Arrow/Right_turn.png", "qrc:/Direction_Arrow/Roundabout(1).png", "qrc:/Direction_Arrow/Roundabout(2).png", "qrc:/Direction_Arrow/Roundabout(3).png", "qrc:/Direction_Arrow/Roundabout(4).png", "qrc:/Direction_Arrow/Roundabout_all_exit(1).png", "qrc:/Direction_Arrow/Roundabout_all_exit(2).png", "qrc:/Direction_Arrow/Roundabout_exit_left(1).png", "qrc:/Direction_Arrow/Roundabout_exit_left(2).png", "qrc:/Direction_Arrow/Roundabout_exit_right(1).png", "qrc:/Direction_Arrow/Roundabout_exit_right(2).png", "qrc:/Direction_Arrow/Roundabout_exit_straight(1).png", "qrc:/Direction_Arrow/Roundabout_exit_straight(2).png", "qrc:/Direction_Arrow/T-junction_exit_left.png", "qrc:/Direction_Arrow/T-junction_exit_right.png", "qrc:/Direction_Arrow/U-turn_left.png", "qrc:/Direction_Arrow/U-turn_right.png"]
    property var arrowPathsIndex: 0
    property var musicText
    property var callText
    property var infoBarText
    property var musicTextPaths
    property var musicTextPathsIndex
    property real instructionMusicBarOpacity: infoBar.instructionMusicBarOpacity
    property bool infoBarVisible: true
    //SPEEDOMETER
    property int speedLimit: 110
    property string speedLimitText: "110"

    signal messageMaps(var instructionMusicBarOpacity)
    onInstructionMusicBarOpacityChanged: {
        messageMaps(instructionMusicBarOpacity)
    }

    property bool play:false
    onPlayChanged: {
        if(play)mapMain.play();
        else mapMain.pause();
    }

    //Load in Roboto Medium font
    FontLoader {
        id: fontRoboto
        source: "qrc:/fonts/Roboto-Medium.ttf"
    }

    //Load in background image
    Rectangle {
        id: background
        anchors.fill: parent
        color: "black"


        Video {
            width: parent.width
            height: parent.height
            id: mapMain
            visible: true
            loops: MediaPlayer.Infinite


            source: "file:///home/pi/sg2.mp4"

            Component.onCompleted: {
                mapMain.pause()


            }
        }

        //Call top bar and instructions bar
//        InfoBar {
//            id: infoBar
//            anchors.fill: parent
//            visible: infoBarVisible
//            musicText: root.musicText
//            callText: root.callText
//            newDirectionSource: root.newDirectionSource
//            directionSource: root.directionSource
//            directionActive: root.directionActive
//            speedLimitText: root.speedLimitText
//            speedLimit: root.speedLimit
//            battSource: root.battSource
//            recordingVisible: root.recordingVisible
//            phoneVisible: root.phoneVisible
//            musicVisible: root.musicVisible
//            instructionMusicAnimationFadeIn: root.instructionMusicAnimationFadeIn
//            instructionMusicAnimationFadeOut: root.instructionMusicAnimationFadeOut
//            instructionCallAnimationSlideIn: root.instructionCallAnimationSlideIn
//            instructionCallAnimationSlideOut: root.instructionCallAnimationSlideOut
//            speedLimitColorIndicator: root.speedLimitColorIndicator
//            musicTextPaths: root.musicTextPaths
//            musicTextPathsIndex: root.musicTextPathsIndex
//        }
    }



//    MapWindow {
//        id:mapwindow
//        carSpeed: 250
//        navigating: false

//        anchors.top: parent.top
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom

//        z: 0

////        traffic: bottomBar.traffic
//        night: true



//    }


//    Call top bar and instructions bar
//    InfoBar {
//        id: infoBar
//        anchors.fill: parent
//        visible: infoBarVisible
//        musicText: root.musicText
//        callText: root.callText
//        newDirectionSource: root.newDirectionSource
//        directionSource: root.directionSource
//        directionActive: root.directionActive
//        speedLimitText: root.speedLimitText
//        speedLimit: root.speedLimit
//        battSource: root.battSource
//        recordingVisible: root.recordingVisible
//        phoneVisible: root.phoneVisible
//        musicVisible: root.musicVisible
//        instructionMusicAnimationFadeIn: root.instructionMusicAnimationFadeIn
//        instructionMusicAnimationFadeOut: root.instructionMusicAnimationFadeOut
//        instructionCallAnimationSlideIn: root.instructionCallAnimationSlideIn
//        instructionCallAnimationSlideOut: root.instructionCallAnimationSlideOut
//        speedLimitColorIndicator: root.speedLimitColorIndicator
//        musicTextPaths: root.musicTextPaths
//        musicTextPathsIndex: root.musicTextPathsIndex
//        infoBarText: root.infoBarText
//    }


}
