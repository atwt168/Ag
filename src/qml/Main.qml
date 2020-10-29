//import QtGraphicalEffects 1.0
import QtLocation 5.9
//import QtPositioning 5.09

import QtQuick.Window 2.10
import QtQuick 2.7
import QtQuick.Extras 1.4
import QtQuick.Controls 2.5
import QtMultimedia 5.6

import com.mapbox.cheap_ruler 1.0
import "qrc:/qml"
import Process 1.0



ApplicationWindow {
    id: mainWindow
    visible: true
    width: 640
    height: 480

    //DIRECTION ARROWS
    property bool directionactive: false
    property string directionsource: ""
    property string newdirectionSource: ""
    //BATTERY
    property string battsource: "qrc:/Battery/battery.25(2).png"
    //RECORDING/PHONE/MUSIC ON/OFF STATE
    property bool recordingactive: false
    property bool phoneactive: false
    property bool musicactive: false
    property bool bleControllerActive: false
    //COLOR BAR
    property string speedLimitColorIndicator: "#00c7ff" //Blue
    //INSTRUCTION
    property bool instructioncallAnimationSlideIn: phoneactive
    property bool instructioncallAnimationSlideOut: !phoneactive
    property bool instructionmusicAnimationFadeIn: musicactive
    property bool instructionmusicAnimationFadeOut: false
    property var instructionmusicBarOpacity
    property bool infobarVisible: true
    property string musicText:"";
    property string callText:"";
    property var infoBarText:"";
    property var distanceleft:"";
    //SCREEN CHANGE
//    property bool checkState:true
    property bool checkStateRearView:true
    property bool checkStateGPS: false
    //SPEEDOMETER
    property int speedLimit: 80
    property string speedlimitText: "-"
    property bool controlsVisibility: false
    property string infoBarDistText:"";
    property int speed:0
    property string distUnits:"km/h"
    //FRONT-CAMERA
    property bool frontCameraMounted



//    signal messageMusicText(var musicText)
//    onMusicTextChanged: {
//        messageMusicText(mainWindow.musicText)
//    }

    //Receive emmited signals from RearView.qml
//    Connections {
//        target: rearView
//        onMessageRearView: {
//            instructionmusicBarOpacity = instructionMusicBarOpacity
//            console.log(instructionMusicBarOpacity)
//    }
//    }

    //Receive emmited signals from Maps.qml
//    Connections {
//        target: maps
//        onMessageMaps: {
//            instructionmusicBarOpacity = instructionMusicBarOpacity
//            //console.log(instructionMusicBarOpacity)
//    }
//    }

    function invertView() {
//        rearview.visible = !rearview.visible
//        mapMain.visible = !mapMain.visible
    }

    function showMap() {

        checkStateRearView = false
        checkStateGPS = !checkStateGPS
        if (checkStateGPS == true) {
            loader.sourceComponent = simplifiedGPS
//            maps.visible = false

        }


    }



    function showRear() {

        checkStateGPS = false
        checkStateRearView = !checkStateRearView
        if (checkStateRearView) {
            infobarVisible = true
            loader.sourceComponent = rearView

        } else {
            infobarVisible = false
            loader.sourceComponent = rearView
        }
//        console.log('show rear')
    }

    function showMusic(artist, title, active) {
//        console.log("main - showmusic")
//        rearview.startMusic(artist, title, active)
        musicactive = active
        instructionmusicAnimationFadeOut = !active
        if(mainWindow.musicText != artist +" - "+title){
            mainWindow.musicText = artist +" - "+title             
            mainWindow.toggleMusic()
        }


    }

    function showBleController(status) {
        bleControllerActive = status
    }



    function showCall(number, person, active) {
        //if(!active) return;
        phoneactive = active;
        console.log("phoneActive ",active)
        if (phoneactive === true) {
            mainWindow.callText = person+" - "+ number
            phone_toggle.color = "green"
            phone_off_text.visible = false
            phone_on_text.visible = true
            mainWindow.speedLimitColorIndicator = "#00f264" //Green
        } else {
            phone_toggle.color = "red"
            phone_off_text.visible = true
            phone_on_text.visible = false
            mainWindow.speedLimitColorIndicator = "#00c7ff" //Blue
        }

        if (musicactive === true && phoneactive === false) {
            instructionmusicAnimationFadeIn = false
            instructionmusicAnimationFadeIn = true
            delay10000.restart()
        }

        if (phoneactive === true && musicactive === true
                && instructionmusicBarOpacity <= 1
                && instructionmusicBarOpacity >= 0.1) {
            delay10000.stop()
            instructionmusicAnimationFadeOut = false
            instructionmusicAnimationFadeOut = true
        }

        if (phoneactive === true && musicactive === true
                && instructionmusicBarOpacity === 0) {

        }


    }

    function startRecord(isRecording){
        recordingactive = isRecording;

    }

    function connected() {
        //mapMain.btoothConnected();
    }

    function disconnected() {}

    function startNavigation(startlat, startlng, endlat, endlng) {
//        showMap()
//        mapMain.startNavigation(startlat, startlng, endlat, endlng)
    }

    function stopNavigation() {
//        showRear()
//        mapMain.stopNavigation()
    }

    function setZoom(zoom) {
//        mapMain.setZoom(zoom)
    }

    function toggleGPIO(val) {
        process.start("echo " + val + " >/sys/class/gpio/gpio2/value", [" "])
    }

    //New image becomes old image
    //On clicked, new image stored in newDirectionSource
    function directionClicked(newDS) {
        directionactive = true
        directionsource = newdirectionSource
        newdirectionSource = newDS
        directionactive = false
    }

    //Toggle recrording button
    function toggleRecording() {
        if (recordingactive) {
            recording_toggle.color = "green"
            recording_off_text.visible = false
            recording_on_text.visible = true
        } else {
            recording_toggle.color = "red"
            recording_off_text.visible = true
            recording_on_text.visible = false
        }
    }

    //Toggle music button
    //A variable is passed into function toggleMusis() when nextMusic button is pressed
    //it will fall into the first if statement
    function toggleMusic(nextMusic) {
        if (nextMusic=="nextMusic") {
                musicactive = true
                music_toggle.color = "green"
                music_off.visible = false
                music_on.visible = true
                instructionmusicAnimationFadeIn = false
                instructionmusicAnimationFadeIn = true
                delay10000.restart()
            //fixes phone button to music forward button to phone button
            if(mainWindow.phoneactive){
                instructionmusicAnimationFadeOut = false
                instructionmusicAnimationFadeOut = true
                instructionmusicAnimationFadeIn = false
                console.log(instructionmusicAnimationFadeIn)
            }

            return
        }

        if (musicactive) {
            music_toggle.color = "green"
            music_off.visible = false
            music_on.visible = true
        } else {
            music_toggle.color = "red"
            music_off.visible = true
            music_on.visible = false
        }

        if (musicactive === false && phoneactive === false) {
            delay10000.stop()
            instructionmusicAnimationFadeIn = false
            instructionmusicAnimationFadeOut = false
            instructionmusicAnimationFadeOut = true
        }

        if (musicactive === false && phoneactive === true) {
            delay10000.stop()
            instructionmusicAnimationFadeOut = false
            instructionmusicAnimationFadeOut = true
        }

        if (musicactive === true && phoneactive === false) {
            instructionmusicAnimationFadeIn = false
            instructionmusicAnimationFadeIn = true
            console.log("here")
            delay10000.start()
        }

        if (musicactive === true && phoneactive === true) {

        }
    }

    //Toggle phone button
    function togglePhone() {
        if (phoneactive === true) {
            phone_toggle.color = "green"
            phone_off_text.visible = false
            phone_on_text.visible = true
            speedLimitColorIndicator = "#00f264" //Green
        } else {
            phone_toggle.color = "red"
            phone_off_text.visible = true
            phone_on_text.visible = false
            speedLimitColorIndicator = "#00c7ff" //Blue
        }

        if (phoneactive === false && musicactive === false) {

        }

        if (phoneactive === false && musicactive === true) {
            instructionmusicAnimationFadeIn = false
            instructionmusicAnimationFadeIn = true
            delay10000.restart()
            console.log("Music animation fade in: " + instructionmusicAnimationFadeIn)
        }

        if (phoneactive === true && musicactive === false) {

        }

        if (phoneactive === true && musicactive === true) {
            delay10000.stop()
            instructionmusicAnimationFadeIn = false
            instructionmusicAnimationFadeOut = false
            instructionmusicAnimationFadeOut = true
        }
    }



    //The battery level goes up every quater of the slider
    function updateBattery(val) {

        if (val>=3840) {
            battsource = "qrc:/Battery/Full_battery(2).png"
        } else if (val >= 3666 && val < 3840) {
            battsource = "qrc:/Battery/battery.75(2).png"
        } else if (val >= 3630 && val < 3666) {
            battsource = "qrc:/Battery/battery.5(2).png"
        } else {
            battsource = "qrc:/Battery/battery.25(2).png"
        }
    }

    function setInfoBarInstruction(instr){
        mainWindow.infoBarText = instr;

    }

    function setInfoBarDistance(dist){
        mainWindow.infoBarDistText = dist
    }

    function setSpeed(speed){
        speed = parseInt(speed)
        mainWindow.speed = speed
    }

    function contains(word,substring){
        if (word.indexOf(substring)===-1){
            return false
        }else{            
            return true
        }
    }

    function setArrow(arrowDirection){
        //property var arrowPaths: ["qrc:/Direction_Arrow/Exit_left.png", "qrc:/Direction_Arrow/Exit_right.png", "qrc:/Direction_Arrow/Filter_left.png", "qrc:/Direction_Arrow/Filter_right.png", "qrc:/Direction_Arrow/Fork_left.png", "qrc:/Direction_Arrow/Fork_right.png", "qrc:/Direction_Arrow/Left_turn.png", "qrc:/Direction_Arrow/Right_turn.png", "qrc:/Direction_Arrow/Roundabout(1).png", "qrc:/Direction_Arrow/Roundabout(2).png", "qrc:/Direction_Arrow/Roundabout(3).png", "qrc:/Direction_Arrow/Roundabout(4).png", "qrc:/Direction_Arrow/Roundabout_all_exit(1).png", "qrc:/Direction_Arrow/Roundabout_all_exit(2).png", "qrc:/Direction_Arrow/Roundabout_exit_left(1).png", "qrc:/Direction_Arrow/Roundabout_exit_left(2).png", "qrc:/Direction_Arrow/Roundabout_exit_right(1).png", "qrc:/Direction_Arrow/Roundabout_exit_right(2).png", "qrc:/Direction_Arrow/Roundabout_exit_straight(1).png", "qrc:/Direction_Arrow/Roundabout_exit_straight(2).png", "qrc:/Direction_Arrow/T-junction_exit_left.png", "qrc:/Direction_Arrow/T-junction_exit_right.png", "qrc:/Direction_Arrow/U-turn_left.png", "qrc:/Direction_Arrow/U-turn_right.png"]
        // directionsource = newdirectionSource
        if (contains(arrowDirection,"slight") && contains(arrowDirection,"left")){
            newdirectionSource = "qrc:/Direction_Arrow/Filter_left.png"
        }
        else if (contains(arrowDirection,"slight") && contains(arrowDirection,"right")){
            newdirectionSource = "qrc:/Direction_Arrow/Filter_right.png"
        }

        else if (contains(arrowDirection,"fork") && contains(arrowDirection,"right")){
            newdirectionSource = "qrc:/Direction_Arrow/Fork_right.png"
        }

        else if (contains(arrowDirection,"fork") && contains(arrowDirection,"right")){
            newdirectionSource = "qrc:/Direction_Arrow/Fork_left.png"
        }

        else if (contains(arrowDirection,"right")){
            newdirectionSource = "qrc:/Direction_Arrow/Right_turn.png"
        }

        else if (contains(arrowDirection,"left")){
            newdirectionSource = "qrc:/Direction_Arrow/Left_turn.png"
        }

        else if (contains(arrowDirection,"u-turn") || contains(arrowDirection,"uturn")){
            newdirectionSource = "qrc:/Direction_Arrow/U-turn_right.png"
        }

        else{
            newdirectionSource = ""
        }

    }

    function setExit(exitNum){
        mainWindow.speedlimitText = exitNum
    }

    function displayFrontCamIcon(mounted){
        mainWindow.frontCameraMounted = mounted
    }

    function setUnits(units){
        mainWindow.distUnits = units
    }

    function setSpeedLimit(spd){
        mainWindow.speedLimit = spd
    }

 


    //Change screens using loader object
    Item {
        id: screenChange
        width: parent.width;
        height: parent.height;
        anchors.fill: parent

//        Component.onCompleted: {
//            mainWindow.showMap();
//        }

        //Initialise RearView, SimplifiedGPS, Maps as Component
        Component {
            id: splashScreenLoader
            SplashScreen{}
             
        }


        Component{
            id:rearView
            RearView {
                anchors.fill: parent
                visible: true
                musicActive: mainWindow.musicactive
                instructionMusicAnimationFadeIn: mainWindow.instructionmusicAnimationFadeIn
                instructionMusicAnimationFadeOut: mainWindow.instructionmusicAnimationFadeOut
                phoneActive: mainWindow.phoneactive
                bleControllerActive: mainWindow.bleControllerActive
                instructionCallAnimationSlideIn: mainWindow.instructioncallAnimationSlideIn
                instructionCallAnimationSlideOut: mainWindow.instructioncallAnimationSlideOut
                recordingActive: mainWindow.recordingactive
                frontCameraMounted: mainWindow.frontCameraMounted
                battSource: mainWindow.battsource
                directionActive: mainWindow.directionactive
                directionSource: mainWindow.directionsource
                newDirectionSource: mainWindow.newdirectionSource
                infoBarVisible: mainWindow.infobarVisible
                speedLimit: mainWindow.speedLimit
                speedLimitText: mainWindow.speedlimitText
//                musicTextPaths: mainWindow.musicTextPaths
//                musicTextPathsIndex: mainWindow.musicTextPathsIndex
                speedLimitColorIndicator: mainWindow.speedLimitColorIndicator
                musicText: mainWindow.musicText
                callText: mainWindow.callText
                infoBarText: mainWindow.infoBarText
                infoBarDistText: mainWindow.infoBarDistText
                currentSpeed: mainWindow.speed
                distUnits: mainWindow.distUnits
            }
        }

        Component {
            id: simplifiedGPS

            SimplifiedGPS {
                anchors.fill: parent
                visible: true
                musicActive: mainWindow.musicactive
                phoneActive: mainWindow.phoneactive
                recordingActive: mainWindow.recordingactive
                frontCameraMounted: mainWindow.frontCameraMounted
                bleControllerActive: mainWindow.bleControllerActive
                battSource: mainWindow.battsource
                directionActive: mainWindow.directionactive
                directionSource: mainWindow.directionsource
                newDirectionSource: mainWindow.newdirectionSource
                speedLimit: mainWindow.speedLimit
                speedLimitText: mainWindow.speedlimitText
                infoBarText: mainWindow.infoBarText
                infoBarDistText: mainWindow.infoBarDistText
                instructionMusicAnimationFadeIn: mainWindow.instructionmusicAnimationFadeIn
                instructionMusicAnimationFadeOut: mainWindow.instructionmusicAnimationFadeOut
                musicText: mainWindow.musicText
                callText: mainWindow.callText
                currentSpeed: mainWindow.speed
                distUnits: mainWindow.distUnits
            }
        }

//        Component {
//            id: maps

//            Maps {
//                id: maps
//                anchors.fill: parent
//                visible: false
//                musicActive: mainWindow.musicactive
//                instructionMusicAnimationFadeIn: mainWindow.instructionmusicAnimationFadeIn
//                instructionMusicAnimationFadeOut: mainWindow.instructionmusicAnimationFadeOut
//                phoneActive: mainWindow.phoneactive
//                instructionCallAnimationSlideIn: mainWindow.instructioncallAnimationSlideIn
//                instructionCallAnimationSlideOut: mainWindow.instructioncallAnimationSlideOut
//                recordingActive: mainWindow.recordingactive
//                battSource: mainWindow.battsource
//                directionActive: mainWindow.directionactive
//                directionSource: mainWindow.directionsource
//                newDirectionSource: mainWindow.newdirectionSource
//                infoBarVisible: mainWindow.infobarVisible
//                speedLimit: mainWindow.speedlimit
//                speedLimitText: mainWindow.speedlimitText
//                musicTextPaths: mainWindow.musicTextPaths
//                musicTextPathsIndex: mainWindow.musicTextPathsIndex
//                musicText: mainWindow.musicText
//                callText: mainWindow.callText
//                infoBarText: mainWindow.infoBarText
//            }
//        }

        //Load as sourceComponent
        Loader {
            id: loader; sourceComponent: splashScreenLoader; anchors.fill: parent; focus: true;
             
            Component.onCompleted:{
                 endSplash.start()
            }
        }

        //Splash Screen transition to RearView
        Timer {
            id: endSplash
            interval: 10000
            running: false
            repeat: false
            onTriggered: {
                loader.sourceComponent = rearView                 
            }
        }



        MouseArea {
            anchors.fill: parent
            focus: true
                onClicked: {
                    screenChange.focus = true
                    console.log("Screen focused")
                }
            }

        Keys.onPressed: {
            if (event.key === Qt.Key_1) {
                checkStateGPS = false
                checkStateRearView = !checkStateRearView
                if (checkStateRearView) {
                    infobarVisible = true
                    loader.sourceComponent = rearView
//                    maps.visible = false
                    console.log("Music animation fade in: " + instructionmusicAnimationFadeIn)
                } else {
                    infobarVisible = false
                    loader.sourceComponent = rearView
//                    maps.visible = false
                }
                console.log('Key 1 was pressed')
            }
            if (event.key === Qt.Key_2) {
                checkStateRearView = false
                checkStateGPS = !checkStateGPS
                if (checkStateGPS == true) {
                    loader.sourceComponent = simplifiedGPS
//                    maps.visible = false

                }
//                else {
//                    //loader.sourceComponent = maps
//                    loader.sourceComponent = undefined
////                    maps.visible = true
//                    infobarVisible = true
//                }
                console.log('Key 2 was pressed')
            }

            if (event.key === Qt.Key_3) {
                musicText = "Hungarian Phapsodies S.244"
            }
        }
    }


    //Load in roboto font
    FontLoader {
        id: fontRoboto
        source: "qrc:/fonts/Roboto-Medium.ttf"
    }





    //Music, phone, recording and direction arrow control
    Item {
        id: root
        width: 640
        height: 300
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 55
        visible: controlsVisibility
        //Group of buttons where only 1 button in the group can be checked
        ButtonGroup {
            id: radioGroup
        }



        //Delay of 10 seconds
        //Fades out music instructions bar on triggered
        Timer {
            id: delay10000
            interval: 10000
            running: false
            repeat: false
            onTriggered: {
                instructionmusicAnimationFadeOut = false
                instructionmusicAnimationFadeOut = true
            }
        }



        //Button for toggling recording
        Rectangle {
            id: recording_toggle
            width: 50
            height: width
            radius: width / 2
            color: "red"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            border.width: 3
            border.color: "black"

            //Text on recording button
            Text {
                id: recording_on_text
                anchors.centerIn: parent
                text: "Recording on"
                font.pointSize: 6
                visible: false
            }

            Text {
                id: recording_off_text
                anchors.centerIn: parent
                text: "Recording off"
                font.pointSize: 6
                visible: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    recordingactive = !recordingactive
                    mainWindow.toggleRecording()
                }
            }
        }

        //Button for toggling music
        Rectangle {
            id: music_toggle
            width: 50
            height: width
            radius: width / 2
            color: "red"
            anchors.right: music_forward.left
            anchors.bottom: parent.bottom
            border.width: 3
            border.color: "black"

            Image {
                id: music_on
                width: 20
                height: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                visible: false
                source: "qrc:/Icons/pause-button.png"
            }

            Image {
                id: music_off
                width: 20
                height: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 3
                visible: true
                source: "qrc:/Icons/play-button.png"
            }

            MouseArea {
                //id: mouseAreaMusic
                anchors.fill: parent
                onClicked: {
                    musicactive = !musicactive
                    instructionmusicAnimationFadeOut = !musicactive
                    mainWindow.toggleMusic()
                }
            }
        }

        //Button for next music
        Rectangle {
            id: music_forward
            width: 50
            height: width
            radius: width / 2
            color: "red"
            anchors.right: phone_toggle.left
            anchors.bottom: parent.bottom
            border.width: 3
            border.color: "black"

            Image {
                width: 20
                height: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                visible: true
                source: "qrc:/Icons/forward.png"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    mainWindow.toggleMusic("nextMusic")
                    musicTextPathsIndex += 1
                    //maps.musicTextPathsIndex += 1
                    //console.log(musicTextPaths[musicTextPathsIndex % 3])
                }
            }
        }

        //Button for toggling phone
        Rectangle {
            id: phone_toggle
            width: 50
            height: width
            radius: width / 2
            color: "red"
            anchors.right: recording_toggle.left
            anchors.bottom: parent.bottom
            border.width: 3
            border.color: "black"

            //Text on phone button
            Text {
                id: phone_on_text
                anchors.centerIn: parent
                text: "Phone on"
                visible: false
            }
            Text {
                id: phone_off_text
                anchors.centerIn: parent
                text: "Phone off"
                visible: true
            }

            MouseArea {
                //id: mouseAreaPhone
                anchors.fill: parent
                onClicked: {
                    phoneactive = !phoneactive
                    instructioncallAnimationSlideOut = !phoneactive
                    mainWindow.togglePhone()
                }
            }
        }

        //Change of battery level with a slider
//        Slider {
//            id: slider
//            anchors.right: music_toggle.left
//            anchors.bottom: parent.bottom
//            width: 150
//            height: 50
//            from: 1
//            to: 100
//            live: true
//            onValueChanged: {
//                mainWindow.batteryLevel()
//            }
//        }

//        //The battery level goes up every quater of the slider
//        function updateBattery(val) {

//            if (val<=3840) {
//                battsource = "qrc:/Battery/battery.25(2).png"
//            } else if (val >= 3666 && val < 3840) {
//                battsource = "qrc:/Battery/battery.5(2).png"
//            } else if (val >= 3630 && val < 3666) {
//                battsource = "qrc:/Battery/battery.75(2).png"
//            } else {
//                battsource = "qrc:/Battery/Full_battery(2).png"
//            }
//        }
    }


}
