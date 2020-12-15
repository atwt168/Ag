import QtQuick 2.1
import QtQuick.Window 2.2
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

//create a text bar in controls to type in instructions
Item {
    id: roots
    //DIRECTION ARROWS
    property bool directionActive: false
    property string directionSource: "qrc:/arrows/Left_turn.png"
    property string newDirectionSource: "qrc:/arrows/Left_turn.png"
    //RECORDING/PHONE/MUSIC ON/OFF STATE
    property bool recordingActive: false
    property bool phoneActive: false
    property bool musicActive: false
    //BATTERY
    property string battSource: "qrc:/icons/battery.75(2).png"
    //PHONE
    property bool phoneVisible: phoneActive
    //RECORDING
    property bool recordingVisible: recordingActive
    //MUSIC
    property bool musicVisible: musicActive && !phoneActive
    //COLOR BAR
    property string colorBar: "qrc:/icons/Blue_line.png"
    //INSTRUCTION
    property bool instructionCallAnimation: phoneActive
    property bool instructionCallAnimation1: false
    property bool instructionMusicAnimation: musicActive
    property bool instructionMusicAnimation1: false
    property string textToUseControls: "Keep right on Pan Island Highway"
    property string textToUseControls1
    property bool showCtrl : false
    //property string textToUseControls;
    function launchMusicBar(artist,title,active){
        console.log("control - showmusic")
//        if(!active) musicActive = !musicActive
        musicActive = active
        roots.instructionMusicAnimation1 = !musicActive
        root.toggleMusic()
    }

    FontLoader {
        id: roboto
        source: "qrc:/fonts/Roboto-Medium.ttf"
    }

    Rectangle {
        width: 290
        height: 42.5
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 55
        color: "black"
        visible: showCtrl
        TextInput {
            id: textToShow
            text: textToUseControls
            cursorVisible: true
            color: "white"
            wrapMode: Text.WrapAnywhere
            anchors.centerIn: parent
            scale: Math.min(1, parent.width / contentWidth)
            font {
                family: roboto.name
                pixelSize: 30
            }
        }

        Keys.onReturnPressed: {
            textToUseControls = textToShow.text
            console.log(textToUseControls)
            console.log("Enter Pressed")
        }
    }

    //Music, phone, recording and direction arrow control
    Item {
        id: root
        width: 640
        height: 250
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 55
        visible: showCtrl
        //Group of buttons where only 1 button in the group can be checked
        ButtonGroup {
            id: radioGroup
        }

        //New image becomes old image
        //On clicked, new image stored in newDirectionSource
        function directionClicked(newDS) {
            directionActive = true
            directionSource = newDirectionSource
            newDirectionSource = newDS
            directionActive = false
            console.log("from controls", directionActive)
        }

        //Radio buttons with text by the side
        Rectangle {
            id: exitRight
            width: 75
            height: 50
            anchors.bottom: recording_toggle.top
            anchors.right: parent.right
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Exit right"
                    font.pointSize: 8
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: exitRightRadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup

                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: exitRightRadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }

                    onClicked: {
                        root.directionClicked("qrc:/arrows/Exit_right.png")
                    }
                }
            }
        }

        Rectangle {
            id: exitLeft
            width: 75
            height: 50
            anchors.bottom: exitRight.top
            anchors.right: parent.right
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Exit left"
                    font.pointSize: 8
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: exitLeftRadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: exitLeftRadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Exit_left.png")
                    }
                }
            }
        }

        Rectangle {
            id: filterRight
            width: 75
            height: 50
            anchors.bottom: exitLeft.top
            anchors.right: parent.right
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Filter right"
                    font.pointSize: 8
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: filterRightRadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: filterRightRadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Filter_right.png")
                    }
                }
            }
        }

        Rectangle {
            id: filterLeft
            width: 75
            height: 50
            anchors.bottom: filterRight.top
            anchors.right: parent.right
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Filter left"
                    font.pointSize: 8
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: filterLeftRadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: filterLeftRadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Filter_left.png")
                    }
                }
            }
        }

        Rectangle {
            id: forkRight
            width: 75
            height: 50
            anchors.bottom: filterLeft.top
            anchors.right: parent.right
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Fork right"
                    font.pointSize: 8
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: forkRightRadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: forkRightRadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Fork_right.png")
                    }
                }
            }
        }

        Rectangle {
            id: forkLeft
            width: 75
            height: 50
            anchors.bottom: recording_toggle.top
            anchors.right: exitRight.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Fork left"
                    font.pointSize: 8
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: forkLeftRadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: forkLeftRadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Fork_left.png")
                    }
                }
            }
        }

        Rectangle {
            id: leftTurn
            width: 75
            height: 50
            anchors.bottom: forkLeft.top
            anchors.right: exitRight.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Left turn"
                    font.pointSize: 8
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: leftTurnRadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: leftTurnRadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Left_turn.png")
                    }
                }
            }
        }

        Rectangle {
            id: rightTurn
            width: 75
            height: 50
            anchors.bottom: leftTurn.top
            anchors.right: exitRight.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Right turn"
                    font.pointSize: 8
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: rightTurnRadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: rightTurnRadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Right_turn.png")
                    }
                }
            }
        }

        Rectangle {
            id: roundAbout1
            width: 75
            height: 50
            anchors.bottom: rightTurn.top
            anchors.right: exitRight.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Roundabout 1"
                    font.pointSize: 8
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: roundAbout1RadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: roundAbout1RadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Roundabout(1).png")
                    }
                }
            }
        }

        Rectangle {
            id: roundAbout2
            width: 75
            height: 50
            anchors.bottom: roundAbout1.top
            anchors.right: exitRight.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Roundabout 2"
                    font.pointSize: 8
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: roundAbout2RadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: roundAbout2RadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Roundabout(2).png")
                    }
                }
            }
        }

        Rectangle {
            id: roundAbout3
            width: 75
            height: 50
            anchors.bottom: recording_toggle.top
            anchors.right: forkLeft.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Roundabout 3"
                    font.pointSize: 8
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: roundAbout3RadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: roundAbout3RadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Roundabout(3).png")
                    }
                }
            }
        }

        Rectangle {
            id: roundAbout4
            width: 75
            height: 50
            anchors.bottom: roundAbout3.top
            anchors.right: forkLeft.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Roundabout 4"
                    font.pointSize: 8
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: roundAbout4RadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: roundAbout4RadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Roundabout(4).png")
                    }
                }
            }
        }

        Rectangle {
            id: roundaboutAllExit1
            width: 75
            height: 50
            anchors.bottom: roundAbout4.top
            anchors.right: forkLeft.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Roundabout all exit 1"
                    font.pointSize: 5
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: roundaboutAllExit1RadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: roundaboutAllExit1RadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Roundabout_all_exit(1).png")
                    }
                }
            }
        }

        Rectangle {
            id: roundaboutAllExit2
            width: 75
            height: 50
            anchors.bottom: roundaboutAllExit1.top
            anchors.right: forkLeft.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Roundabout all exit 2"
                    font.pointSize: 5
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: roundaboutAllExit2RadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: roundaboutAllExit2RadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/Roundabout_all_exit(2).png")
                    }
                }
            }
        }

        Rectangle {
            id: roundaboutExitLeft1
            width: 75
            height: 50
            anchors.bottom: roundaboutAllExit2.top
            anchors.right: forkLeft.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Roundabout exit left 1"
                    font.pointSize: 5
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: roundaboutExitLeft1RadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: roundaboutExitLeft1RadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked(
                                    "qrc:/arrows/Roundabout_exit_left(1).png")
                    }
                }
            }
        }

        Rectangle {
            id: roundaboutExitLeft2
            width: 75
            height: 50
            anchors.bottom: recording_toggle.top
            anchors.right: roundAbout3.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Roundabout exit left 2"
                    font.pointSize: 4.5
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: roundaboutExitLeft2RadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: roundaboutExitLeft2RadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked(
                                    "qrc:/arrows/Roundabout_exit_left(2).png")
                    }
                }
            }
        }

        Rectangle {
            id: roundaboutExitRight1
            width: 75
            height: 50
            anchors.bottom: roundaboutExitLeft2.top
            anchors.right: roundAbout3.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Roundabout exit right 1"
                    font.pointSize: 4.5
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: roundaboutExitRight1RadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: roundaboutExitRight1RadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked(
                                    "qrc:/arrows/Roundabout_exit_right(1).png")
                    }
                }
            }
        }

        Rectangle {
            id: roundaboutExitRight2
            width: 75
            height: 50
            anchors.bottom: roundaboutExitRight1.top
            anchors.right: roundAbout3.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Roundabout exit right 2"
                    font.pointSize: 4.5
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: roundaboutExitRight2RadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: roundaboutExitRight2RadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked(
                                    "qrc:/arrows/Roundabout_exit_right(2).png")
                    }
                }
            }
        }

        Rectangle {
            id: roundaboutExitStraight1
            width: 75
            height: 50
            anchors.bottom: roundaboutExitRight2.top
            anchors.right: roundAbout3.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Roundabout exit straight 1"
                    font.pointSize: 4.5
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: roundaboutExitStraight1RadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: roundaboutExitStraight1RadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked(
                                    "qrc:/arrows/Roundabout_exit_straight(1).png")
                    }
                }
            }
        }

        Rectangle {
            id: roundaboutExitStraight2
            width: 75
            height: 50
            anchors.bottom: roundaboutExitStraight1.top
            anchors.right: roundAbout3.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "Roundabout exit straight 2"
                    font.pointSize: 4.5
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: roundaboutExitStraight2RadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: roundaboutExitStraight2RadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked(
                                    "qrc:/arrows/Roundabout_exit_straight(2).png")
                    }
                }
            }
        }

        Rectangle {
            id: tJunctionExitRight
            width: 75
            height: 50
            anchors.bottom: recording_toggle.top
            anchors.right: roundaboutExitLeft2.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "T-junction exit right"
                    font.pointSize: 5
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: tJunctionExitRightRadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: tJunctionExitRightRadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/T-junction_exit_right.png")
                    }
                }
            }
        }

        Rectangle {
            id: tJunctionExitLeft
            width: 75
            height: 50
            anchors.bottom: tJunctionExitRight.top
            anchors.right: roundaboutExitLeft2.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "T-junction exit left"
                    font.pointSize: 5
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: tJunctionExitLeftRadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: tJunctionExitLeftRadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/T-junction_exit_left.png")
                    }
                }
            }
        }

        Rectangle {
            id: uTurnRight
            width: 75
            height: 50
            anchors.bottom: tJunctionExitLeft.top
            anchors.right: roundaboutExitLeft2.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "U-turn right"
                    font.pointSize: 5
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: uTurnRightRadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: uTurnRightRadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/U-turn_right.png")
                    }
                }
            }
        }
        Rectangle {
            id: uTurnLeft
            width: 75
            height: 50
            anchors.bottom: uTurnRight.top
            anchors.right: roundaboutExitLeft2.left
            color: "white"

            Item {
                width: 50
                height: 50
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                Text {
                    anchors.centerIn: parent
                    text: "U-turn left"
                    font.pointSize: 5
                }
            }

            Item {
                width: 25
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                RadioButton {
                    id: uTurnLeftRadioButton
                    anchors.centerIn: parent
                    ButtonGroup.group: radioGroup
                    indicator: Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 9
                        border.width: 1
                        border.color: "black"

                        Rectangle {
                            anchors.fill: parent
                            visible: uTurnLeftRadioButton.checked
                            color: "black"
                            radius: 9
                            anchors.margins: 4
                        }
                    }
                    onClicked: {
                        root.directionClicked("qrc:/arrows/U-turn_left.png")
                    }
                }
            }
        }

        Rectangle {
            id: empty
            width: 75
            height: 50
            anchors.bottom: uTurnLeft.top
            anchors.right: roundaboutExitLeft2.left
            color: "white"
        }

        //Change of battery level
        Slider {
            id: slider
            anchors.right: music_toggle.left
            anchors.bottom: parent.bottom
            width: 150
            height: 50
            from: 1
            to: 100
            live: true
            value:75
            onValueChanged: {
                parent.batteryLevel()
            }
        }

        //The battery level goes up every quater of the slider
        function batteryLevel() {

            if (slider.value >= 0 && slider.value < 25) {
                battSource = "qrc:/icons/battery.25(2).png"
            }

            if (slider.value >= 25 && slider.value < 50) {
                battSource = "qrc:/icons/battery.5(2).png"
            }

            if (slider.value >= 50 && slider.value < 75) {
                battSource = "qrc:/icons/battery.75(2).png"
            }

            if (slider.value >= 75 && slider.value <= 100) {
                battSource = "qrc:/icons/Full_battery(2).png"
            }
        }

        //Toggle recrording button
        function toggleRecording() {
            if (recordingActive == true) {
                recording_toggle.color = "green"
                recording_off.visible = false
                recording_on.visible = true
            } else {
                recording_toggle.color = "red"
                recording_off.visible = true
                recording_on.visible = false
            }
        }

        //Toggle phone button
        function togglePhone() {
            if (phoneActive == true) {
                phone_toggle.color = "green"
                phone_off.visible = false
                phone_on.visible = true
                colorBar = "qrc:/Green_line.png"
            } else {
                phone_toggle.color = "red"
                phone_off.visible = true
                phone_on.visible = false
                colorBar = "qrc:/Blue_line.png"
            }

            if (musicActive == true && phoneActive == false) {
                instructionMusicAnimation = false
                instructionMusicAnimation = true
                delay6000.start()
            }

            if (phoneActive == true && musicActive == true
                    && instructionMusic.opacity <= 1
                    && instructionMusic.opacity >= 0.3) {
                delay6000.stop()
                instructionMusicAnimation1 = false
                instructionMusicAnimation1 = true
            }

            if (phoneActive == true && musicActive == true
                    && instructionMusic.opacity == 0) {

            }
        }

        //Toggle music button
        function toggleMusic() {
            if (musicActive == true) {
                music_toggle.color = "green"
                music_off.visible = false
                music_on.visible = true
            } else {
                music_toggle.color = "red"
                music_off.visible = true
                music_on.visible = false
            }

            if (phoneActive == false && musicActive == false
                    && instructionMusic.opacity == 1) {
                delay6000.stop()
                instructionMusicAnimation1 = false
                instructionMusicAnimation1 = true
            }

            if (phoneActive == false && musicActive == false
                    && instructionMusic.opacity == 0) {

            }

            if (musicActive == true && phoneActive == false) {
                instructionMusicAnimation = false
                instructionMusicAnimation = true
                delay6000.start()
            }

            if (musicActive == false && phoneActive == true) {

            }

            if (phoneActive == true && musicActive == true) {

            }
        }

        //Delay of 6 seconds
        Timer {
            id: delay6000
            interval: 12000
            running: false
            repeat: false
            onTriggered: {
                instructionMusicAnimation1 = false
                instructionMusicAnimation1 = true
                console.log("triggered")
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
                id: recording_on
                anchors.centerIn: parent
                text: "Recording on"
                font.pointSize: 6
                visible: false
            }

            Text {
                id: recording_off
                anchors.centerIn: parent
                text: "Recording off"
                font.pointSize: 6
                visible: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    recordingActive = !recordingActive
                    root.toggleRecording()
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
                id: phone_on
                anchors.centerIn: parent
                text: "Phone on"
                visible: false
            }
            Text {
                id: phone_off
                anchors.centerIn: parent
                text: "Phone off"
                visible: true
            }

            MouseArea {
                id: mouseAreaPhone
                anchors.fill: parent
                onClicked: {
                    phoneActive = !phoneActive
                    roots.instructionCallAnimation1 = !phoneActive
                    root.togglePhone()
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
            anchors.right: phone_toggle.left
            anchors.bottom: parent.bottom
            border.width: 3
            border.color: "black"

            //Text on music button
            Text {
                id: music_on
                anchors.centerIn: parent
                text: "Music on"
                visible: false
            }
            Text {
                id: music_off
                anchors.centerIn: parent
                text: "Music off"
                visible: true
            }

            MouseArea {
                id: mouseAreaMusic
                anchors.fill: parent
                onClicked: {

                    musicActive = !musicActive
                    roots.instructionMusicAnimation1 = !musicActive
                    root.toggleMusic()
                }
            }
        }
    }
}
