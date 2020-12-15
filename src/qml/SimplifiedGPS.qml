import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Extras 1.4
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: root
    visible: true
    width: 640
    height: 480
    focus: true
    color: "#010510" //Black

    //DIRECTION ARROWS
    property bool directionActive: false
    property string directionSource: ""
    property string newDirectionSource: ""
    //BATTERY
    property string battSource: "qrc:/Battery/battery.25(2).png"
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
    property bool recordingVisible: recordingActive
    //MUSIC
    property bool musicVisible: musicActive && !phoneActive
    //COLOR BAR
    property string speedLimitColorIndicator: "#00c7ff" //Blue
    //INSTRUCTION
    property bool instructionCallAnimationSlideIn
    property bool instructionCallAnimationSlideOut 
    property bool instructionMusicAnimationFadeIn
    property bool instructionMusicAnimationFadeOut 
    property string infoBarText:""
    property string infoBarDistText:""

    property int meterStartPulse :400
    property int feetStartPulse : 1300
    property var arrowPaths: ["qrc:/Direction_Arrow/Exit_left.png", "qrc:/Direction_Arrow/Exit_right.png", "qrc:/Direction_Arrow/Filter_left.png", "qrc:/Direction_Arrow/Filter_right.png", "qrc:/Direction_Arrow/Fork_left.png", "qrc:/Direction_Arrow/Fork_right.png", "qrc:/Direction_Arrow/Left_turn.png", "qrc:/Direction_Arrow/Right_turn.png", "qrc:/Direction_Arrow/Roundabout(1).png", "qrc:/Direction_Arrow/Roundabout(2).png", "qrc:/Direction_Arrow/Roundabout(3).png", "qrc:/Direction_Arrow/Roundabout(4).png", "qrc:/Direction_Arrow/Roundabout_all_exit(1).png", "qrc:/Direction_Arrow/Roundabout_all_exit(2).png", "qrc:/Direction_Arrow/Roundabout_exit_left(1).png", "qrc:/Direction_Arrow/Roundabout_exit_left(2).png", "qrc:/Direction_Arrow/Roundabout_exit_right(1).png", "qrc:/Direction_Arrow/Roundabout_exit_right(2).png", "qrc:/Direction_Arrow/Roundabout_exit_straight(1).png", "qrc:/Direction_Arrow/Roundabout_exit_straight(2).png", "qrc:/Direction_Arrow/T-junction_exit_left.png", "qrc:/Direction_Arrow/T-junction_exit_right.png", "qrc:/Direction_Arrow/U-turn_left.png", "qrc:/Direction_Arrow/U-turn_right.png"]
    property var arrowPathsIndex: 0
    property var musicTextPaths: ["HONNE, Tom Misch - Me & You", "What the world needs now is love", "Hungarian Phapsodies S.244"]
    property var musicTextPathsIndex: 0
    property var musicText
    property var callText
    property var callAnimationFadeIn: false
    property var callAnimationFadeOut: false
    property var currentSpeedAnimationFadeIn: false
    property var currentSpeedAnimationFadeOut: false
    //SPEEDOMETER
    property int speedLimit: 110
    property string speedLimitText: "-"
    property int textSize: 100

    property int currentSpeed:0
    property int prevSpeed:0
    property string distUnits:"km/h"

    //When phone button clicked
    //Start fade in/out animations
    onCurrentSpeedChanged: {
        speedometerAnim.start()
        prevSpeed = currentSpeed
    }
    onPhoneActiveChanged: {
        if(phoneActive == 1) {
            currentSpeedAnimationFadeOut = true
            delay500.restart()
        } else {
            callAnimationFadeOut = true
            delay500.restart()
        }
    }

    //Delay of half a second, waiting for current object to fade out
    Timer {
        id: delay500
        interval: 500
        running: true
        repeat: false
        onTriggered: {
            if (phoneActive == 1) {
                callAnimationFadeIn = 1
            } else {
                currentSpeedAnimationFadeIn = 1
            }
        }
    }

 

    function characterCount(str) {
        var line = ""
        var result = []
        var directionCues = ["left","right","straight","uturn","u-turn"]
        var wordList = str.split(" ")
        for (var i = 0; i < wordList.length; i++) {
            var dCue = directionCues.indexOf(wordList[i])
            if (dCue!=-1){
                wordList[i] = directionCues[dCue].toUpperCase();
            }


            var templine = line + wordList[i]
            if (line.length > 0) {
                templine = line + " " + wordList[i]
            }
            if (templine.length > 9) {
                result.push(line)
                console.log(templine)
                line = wordList[i]
            } else {
                line = templine
            }
        }
        result.push(line)
        console.log(result)
        directionText.text = result.join("<br>")
    }

    //Generates a random number
    function getRandomIntInclusive(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min
    }

    //Load in Roboto Medium font
    FontLoader {
        id: fontRoboto
        source: "qrc:/fonts/Roboto-Medium.ttf"
    }

    //Load in Roboto Regular font
    FontLoader {
        id: fontRobotoRegular
        source: "qrc:/fonts/Roboto-Regular.ttf"
    }

    //Clock on the top middle of screen
    Rectangle {
        id: clock
        width: 640
        height: 50
        anchors.left: parent.left
        anchors.top: parent.top
        color: "#010510"                                //Black

        Text {
            id: time
            font.family: fontRobotoRegular.name
            font.pixelSize: 36
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
        }

        //Timer to refresh the current time
        Timer {
            interval: 500
            running: true
            repeat: true

            //Time format in hours and minutes
            onTriggered: {
                var date = new Date()
                time.text = date.toLocaleTimeString(Qt.locale("en_US"),
                                                     "hh:mm")
            }
        }
    }

    //Phone icon
    Image {
        id: phoneIcon
        source: "qrc:/Icons/Phone(2).png"
        width: 137.5
        height: 42.5
        anchors.right: recordingIcon.left
        anchors.top: parent.top
        anchors.rightMargin: -132
        anchors.topMargin: 8
        visible: phoneVisible
    }

    //Music icon
    Image {
        id: musicIcon
        source: "qrc:/Icons/Music(2).png"
        width: 137.5
        height: 42.5
        anchors.right: recordingIcon.left
        anchors.top: parent.top
        anchors.rightMargin: -134
        anchors.topMargin: 8
        visible: musicVisible
    }

    //Controller icon
    Image {
        source: root.bleControllerActive? "" : "qrc:/Icons/nocontroller3.png"
        width: 137.5
        height: 42.5
        anchors.left: musicIcon.left
        anchors.bottom: infoBarText.top
        anchors.top: parent.top 
        anchors.topMargin: 8
        visible: true
    }

    //Recording icon
    Image {
        id: recordingIcon
        source: "qrc:/Icons/hudcamera_red.png"
        width: 137.5
        height: 42.5
        anchors.right: batteryIcon.left
        anchors.top: parent.top
        anchors.rightMargin: -18
        anchors.topMargin: 8
        visible: recordingVisible
    }

    //FrontCamera Mounted
    Image {
        id: frontCameraMountedIcon
        source: root.frontCameraMounted? "" : "qrc:/Icons/nocamera.png"
        width: 137.5
        height: 42.5
        anchors.right: batteryIcon.left
        anchors.top: parent.top
        anchors.rightMargin: -18
        anchors.topMargin: 8
        visible: !recordingVisible
    }

    //Battery on the top right
    Image {
        id: batteryIcon
        source: battSource
        width: 137.5
        height: 42.5
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: -8
    }

    //Image to be replaced by new image (fades out)
    Image {
        id: newDirection
        source: newDirectionSource
        smooth: true
        opacity: 1
        width: 255
        height: 201.25
        anchors.left: parent.left
        anchors.top: clock.bottom
        transform: Scale {
            id: scaleTransform
            property real scale: 1
            xScale: scale
            yScale: scale
        }

        SequentialAnimation {
            running:parseInt(infoBarDistText.match(/\d+/g)) < meterStartPulse
            id: bounceAnimation
            loops: Animation.Infinite
            PropertyAnimation {
                target: scaleTransform
                properties: "scale"
                from: 1.0
                to: 1.05
                duration: 1000
            }
            PropertyAnimation {
                target: scaleTransform
                properties: "scale"
                from: 1.05
                to: 1.0
                duration: 1000
            }
        }

        //On clicked change to mouse-over state
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            anchors.margins: -10
            onClicked: parent.state = "mouse-over"
        }
        
        // infoBarDistText.match(/\d/g).join(''), 10



        //Scale and opacity property changes
        states: [
            State {
                name: "mouse-over"
                when: directionActive
                PropertyChanges {
                    target: oldDirection
                    scale: 1
                    opacity: 1
                }
                PropertyChanges {
                    target: newDirection
                    scale: 0.6
                    opacity: 0
                }
            },
            State {
                name: "initial-state"
                when: !directionActive
            }
        ]

        //Animations for fading in and out
        transitions: Transition {
            to: "initial-state"
            from: "mouse-over"
            NumberAnimation {
                //id: arrowChangeAnim
                properties: "scale, opacity"
                easing.type: Easing.InOutQuad
                duration: 1000
            }
        }
    }

    //Image to replace old image (fade in)
    Image {
        id: oldDirection
        source: directionSource
        smooth: true
        opacity: 0
        anchors.fill: newDirection
        width: 130
        height: 85
        anchors.left: parent.left
        anchors.top: parent.top
    }

    //Distance to destination
    Rectangle {
        id: distanceLeft
        width: 255
        height: 60
        anchors.left: parent.left
        anchors.top: oldDirection.bottom
        anchors.bottom: directionTextBox.top
        color: "#010510"                        //Black
        Text {
            text: infoBarDistText
            font.family: fontRoboto.name
            font.pointSize: textSize*1.25
            font.bold: true
            anchors.centerIn: parent
            color: "white"
        }
    }

    onInfoBarTextChanged: {
        //directionTextBox.characterCount(infoBarText)
        directionActive = true
        directionActive = false
        characterCount(infoBarText)
    }

    //Limit to maximum 9 character a line
    Rectangle {
        id: directionTextBox
        width: 255
        height: 168.75
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        color: "#010510"                    //Black



        //Direction text on the bottom left
        Text {
            id: directionText
            text: root.characterCount(infoBarText)
            font.family: fontRobotoRegular.name
            fontSizeMode: Text.Fit;
            minimumPixelSize: textSize*0.75;
            font.pointSize: textSize
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            color: "white"
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
        }
    }

    //Container on the bottom right of the screen
    Rectangle {
        width: 385
        height: 430
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "#010510"                        //Black

        //Speed gauge
        Knob {
            id: knob
            width: 638
            height: 638
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: -290.25
            anchors.bottomMargin: -266.25
            color: "#010510"                    //Black
            from: 0
            to: 180
            reverse: false
        }

        //Unit for current speed and progress bar
        Item {
            id: unit
            width: 275
            height: 65
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            visible: !phoneActive
            opacity: 1

            Text {
                //id: kmPerH
                text: distUnits
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 25
                color: "#00caf2"                        //Light blue
                font {
                    family: fontRobotoRegular.name
                    pixelSize: 35
                }
            }

            //Distance left to destination bar
            ProgressBar {
                id: progressBar
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 12
                anchors.topMargin: 8
                value: 0
                width: 140
                height: 8
                clip: true
                property real lastValue: 0
                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 6
                    color: "#005472"                    //Dark blue
                }
                contentItem: Item {
                    implicitWidth: 200
                    implicitHeight: 4
                    Rectangle {
                        //id: bar
                        width: progressBar.visualPosition * parent.width
                        height: parent.height
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        color: "#00c8fb"                //Light blue
                    }
                }
                PropertyAnimation {
                    id: progressBarAnimation
                    target: progressBar
                    property: "value"
                    from: progressBar.lastValue
                    to: progressBar.value
                    duration: 3000
                    running: false
                    easing.type: Easing.OutCubic
                }
            }
            Rectangle {
                width: 3
                height: 10
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 12
                anchors.bottomMargin: 31
                color: "#095070"                        //Dark blue
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        progressBar.value = 0
                        progressBarAnimation.running = true
                        progressBar.lastValue = 0
                    }
                }
            }

            Rectangle {
                width: 3
                height: 10
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 25.7
                anchors.bottomMargin: 31
                color: "#095070"                        //Dark blue
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        progressBar.value = 0.1
                        progressBarAnimation.running = true
                        progressBar.lastValue = 0.1
                    }
                }
            }

            Rectangle {
                width: 3
                height: 10
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 39.4
                anchors.bottomMargin: 31
                color: "#095070"                        //Dark blue
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        progressBar.value = 0.2
                        progressBarAnimation.running = true
                        progressBar.lastValue = 0.2
                    }
                }
            }

            Rectangle {
                width: 3
                height: 10
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 53.1
                anchors.bottomMargin: 31
                color: "#095070"                        //Dark blue
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        progressBar.value = 0.3
                        progressBarAnimation.running = true
                        progressBar.lastValue = 0.3
                    }
                }
            }

            Rectangle {
                width: 3
                height: 10
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 66.8
                anchors.bottomMargin: 31
                color: "#095070"                        //Dark blue
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        progressBar.value = 0.4
                        progressBarAnimation.running = true
                        progressBar.lastValue = 0.4
                    }
                }
            }

            Rectangle {
                width: 3
                height: 10
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 80.5
                anchors.bottomMargin: 31
                color: "#095070"                        //Dark blue
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        progressBar.value = 0.5
                        progressBarAnimation.running = true
                        progressBar.lastValue = 0.5
                    }
                }
            }

            Rectangle {
                width: 3
                height: 10
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 94.2
                anchors.bottomMargin: 31
                color: "#095070"                        //Dark blue
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        progressBar.value = 0.6
                        progressBarAnimation.running = true
                        progressBar.lastValue = 0.6
                    }
                }
            }

            Rectangle {
                width: 3
                height: 10
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 107.9
                anchors.bottomMargin: 31
                color: "#095070"                        //Dark blue
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        progressBar.value = 0.7
                        progressBarAnimation.running = true
                        progressBar.lastValue = 0.7
                    }
                }
            }

            Rectangle {
                width: 3
                height: 10
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 121.6
                anchors.bottomMargin: 31
                color: "#095070"                        //Dark blue
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        progressBar.value = 0.8
                        progressBarAnimation.running = true
                        progressBar.lastValue = 0.8
                    }
                }
            }

            Rectangle {
                width: 3
                height: 10
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 135.3
                anchors.bottomMargin: 31
                color: "#095070"                        //Dark blue
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        progressBar.value = 0.9
                        progressBarAnimation.running = true
                        progressBar.lastValue = 0.9
                    }
                }
            }

            Rectangle {
                width: 3
                height: 10
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 149
                anchors.bottomMargin: 31
                color: "#095070"                        //Dark blue
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        progressBar.value = 1
                        progressBarAnimation.running = true
                        progressBar.lastValue = 1
                    }
                }
            }

            //Fade in progress bar and speed unit
            NumberAnimation on opacity {
                from: unit.opacity
                to: 1
                duration: 500
                running: currentSpeedAnimationFadeIn
                alwaysRunToEnd: true
            }

            //Fade out progress bar and speed unit
            NumberAnimation on opacity {
                from: unit.opacity
                to: 0
                duration: 500
                running: currentSpeedAnimationFadeOut
                alwaysRunToEnd: true
            }
        }

        //Current speed
        Item {
            id: currentSpeedo
            width: 275
            height: 140
            anchors.right: parent.right
            anchors.bottom: unit.top
            opacity: 1

            //Speed simulation
            Text {
                id: speedometer
                text: speedChange
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 25
                color: "white"

                property int speedChange: prevSpeed
                SequentialAnimation {
//                    loops: Animation.Infinite
                    id:speedometerAnim
                    running: false
                    NumberAnimation {
                        target: speedometer
                        property: "speedChange"
                        to: currentSpeed
                        duration: 300
                    }
                }

                onSpeedChangeChanged: {
                    knob.update(speedometer.speedChange)
                }
                font {
                    family: fontRoboto.name
                    pixelSize: 150
                }

            }

            //Fade in current speed text
            NumberAnimation on opacity {
                from: currentSpeedo.opacity
                to: 1
                duration: 500
                running: currentSpeedAnimationFadeIn
                alwaysRunToEnd: true
            }

            //Fade out current speed text
            NumberAnimation on opacity {
                from: currentSpeedo.opacity
                to: 0
                duration: 500
                running: currentSpeedAnimationFadeOut
                alwaysRunToEnd: true
            }
        }

        //Speed limit located on the right of direction arrow
        Rectangle {
            id: speedLimit
            width: 140
            height: 105
            anchors.right: parent.right
            anchors.bottom: currentSpeedo.top
            color: "#010510"                        //Black
            opacity: speedLimitText=="-"? 0 : 1

            //Circle Exit*
            Rectangle {
                id: speedLimit_circle
                width: 85
                height: width
                radius: width / 2
                color: "transparent"
                anchors.centerIn: parent
                border.color: speedometer.speedChange >= speedLimit ? "red" : "#00c7ff"         //Light blue
                border.width: 2
                Text {
                    id: speedLimit_text
                    text: speedLimitText
                    anchors.centerIn: parent
                    color: speedometer.speedChange >= speedLimit ? "red" : "#00c7ff"            //Light blue
                    font.pixelSize: 30
                }
            }

            //Fade in speed limit
            NumberAnimation on opacity {
                from: speedLimit.opacity
                to: 1
                duration: 500
                running: currentSpeedAnimationFadeIn
                alwaysRunToEnd: true
            }

            //Fade out speed limit
            NumberAnimation on opacity {
                from: speedLimit.opacity
                to: 0
                duration: 500
                running: currentSpeedAnimationFadeOut
                alwaysRunToEnd: true
            }
        }

//        Rectangle{
//            id: containers
//            color:"#60ff0000"
//            anchors.fill: parent
//            opacity: 0

        //Phone icon enclosed in a circle
        Rectangle {
            id: phone
            width: 140
            height: 105
            anchors.right: parent.right
            anchors.bottom: currentSpeedo.top
            color: "#010510"                        //Black
            opacity: 0

            //Circle
            Rectangle {
                id: phoneCircle
                width: 85
                height: width
                radius: width / 2
                color: "transparent"
                anchors.centerIn: parent
                border.color: "#00f264"         //Light blue
                border.width: 2

                //Phone icon
                Image {
                    id: largPhoneIcon
                    width: 270
                    height: 85
                    source: "qrc:/Icons/Phone(2).png"
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: -103
                    anchors.topMargin: 5
                }
            }

            //Fade in phone icon
            NumberAnimation on opacity {
                from: phoneText.opacity
                to: 1
                duration: 500
                running: callAnimationFadeIn
                alwaysRunToEnd: true
            }

            //Fade out phone icon
            NumberAnimation on opacity {
                from: phoneText.opacity
                to: 0
                duration: 500
                running: callAnimationFadeOut
                alwaysRunToEnd: true
            }
        }

        //Displays caller ID on the bottom right
        Item {
            id: phoneText
            width: 240
            height: 150
            anchors.right: parent.right
            anchors.bottom: unit.top
            anchors.rightMargin: 30
            anchors.bottomMargin: -10
            //visible: phoneActive
            opacity: 0

            //Caller ID text
            Text{
                text: callText
                anchors.fill: parent
                anchors.top: parent.top
                horizontalAlignment: Text.AlignRight
                color: "#00f264"
                font.pixelSize: 38
                visible: true
                wrapMode: Text.WordWrap
            }

            //Fade in phone text
            NumberAnimation on opacity {
                id: anim
                from: phoneText.opacity
                to: 1
                duration: 500
                running: callAnimationFadeIn
                alwaysRunToEnd: true
            }

            //Fade out phone text
            NumberAnimation on opacity {
                from: phoneText.opacity
                to: 0
                duration: 500
                running: callAnimationFadeOut
                alwaysRunToEnd: true
            }
        }

//        NumberAnimation on opacity {
//            from: containers.opacity
//            to: 1
//            duration: 1000
//            running: phoneActive
//            alwaysRunToEnd: true
//        }

//        NumberAnimation on opacity {
//            from: containers.opacity
//            to: 0
//            duration: 1000
//            running: !phoneActive
//            alwaysRunToEnd: true
//        }
//    }
    }

    //Music bar on the bottom of the UI (fade in/out)
    BlueGreen_Bar {
        id: musicBar
        width: 620
        height: 55
        opacity: 0
        strokeStyleColor: "#00c6ff"
        fillStyleColor: "#00c6ff"
        //textToUse: musicTextPaths[musicTextPathsIndex % musicTextPaths.length]
        textToUse: musicText
        imageSource: "qrc:/Icons/music_logo_white.png"
        instructionMusicBarDropShadowVisible: false

//        onOpacityChanged: {
//            instructionMusicBarOpacity = musicBar.opacity
//            if (callBar.opacity == 1) {
//                instructionMusicBarDropShadowVisible = true
//            }
//            else {
//                instructionMusicBarDropShadowVisible = false
//            }
//            //console.log(instructionMusicBarOpacity)
//        }

        //Music bar fading in animation
        NumberAnimation on opacity {
            //id: anim
            from: musicBar.opacity
            to: 1
            duration: 1000
            running: root.instructionMusicAnimationFadeIn
            alwaysRunToEnd: true
        }

        //Music bar fading out animation
        NumberAnimation on opacity {
            from: musicBar.opacity
            to: 0
            duration: 1000
            running: root.instructionMusicAnimationFadeOut
            alwaysRunToEnd: true
        }
    }
}
