import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0


Rectangle {
    id: mapGpsBar
    anchors.right: parent.right
    anchors.left:parent.left
    anchors.top:parent.top
    height: 130
    width: parent.width
    color: "#80000000"
    property string lightBlue: "#42c8f4"
    property string textInstructions:""
    property string arrowAsset:""

//    ColorAnimation on color {

//        to: "#80000000"
//        duration: 2000
//    }

    //    Image {
    //        anchors.fill: parent

    //        source: "qrc:simple-bottom-background.png"
    //    }
    function changebtoothImage() {
        btoothimage.source = "qrc:bluetoothConnected.png"
    }

    function randomNumber(low, upp) {
        return Math.floor((Math.random() * (upp - low + 1)) + low)
    }



    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.leftMargin: 20
//        anchors.topMargin: -5
        spacing: 1
        ColumnLayout {
            id: rvTurnInstructions
            anchors.left: parent.left
            anchors.top:parent.top
            spacing: 5
            height: parent.height
            width: 30
            Image {
                id: arrowTurn
                source: arrowAsset
//                height:10
//                width: 10


            }

//            Text {
//                visible: false
//                color: "white"
//                text: qsTr("500 m")
//                font.pointSize: 20
//                Layout.alignment: Qt.AlignCenter

//            }
        }

        ColumnLayout {
            id: rvSpeedInfo
            //            Layout.minimumWidth: 100
            //            Layout.preferredWidth: 150
            Layout.preferredHeight: parent.height

//            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter
            Layout.leftMargin: -110
            spacing: 2

            RowLayout {
                spacing:0
                Layout.preferredWidth: 300
                Layout.topMargin: 0
                Rectangle {
                    id: speedLimit
                    //            Layout.fillWidth: true
                    Layout.minimumWidth: 10
                    Layout.preferredWidth: 85
                    Layout.preferredHeight: 85

                    color: "transparent"
                    border.color: (rvSpeedText.val > 110) ? "red" : lightBlue
                    border.width: 5
                    radius: width * 0.5
                    Text {
                        id: speedLimit_text
                        color: (rvSpeedText.val > 110) ? "red" : parent.border.color
                        text: "110"
                        fontSizeMode: Text.Fit
                        font.pointSize: 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Text {
                    color: (rvSpeedText.val > speedLimit_text.text) ? "red" : "white"
                    property int val: 5
                    id: rvSpeedText
                    text: val
                    width: parent.width
//                    anchors.margins: 50
//                    fontSizeMode: Text.Fit
                    font.pointSize: 60
                    //                    NumberAnimation on val { to:130; duration: 5000;easing.type: Easing.InCubic }
                    SequentialAnimation {
                        running: true
                        loops: Animation.Infinite
                        NumberAnimation {
                            target: rvSpeedText
                            property: "val"
                            to: randomNumber(111, 150)
                            duration: randomNumber(2000, 5000)
                            easing.type: Easing.InCubic
                        }

                        NumberAnimation {
                            target: rvSpeedText
                            property: "val"
                            to: randomNumber(60, 90)
                            duration: randomNumber(2000, 5000)
                            easing.type: Easing.InCubic
                        }


                        NumberAnimation {
                            target: rvSpeedText
                            property: "val"
                            to: randomNumber(90, 160)
                            duration: randomNumber(2000, 5000)
                            easing.type: Easing.InCubic
                        }
                    }


                }

            }

            RowLayout {
//                Layout.maximumWidth: 50
                Layout.preferredWidth: parent.width
                Layout.bottomMargin: 15

                Text {
                    Layout.maximumWidth: 80
                    id: rvTextInstructions
                    font.pointSize: 20
                    color: "white"
                    text: textInstructions
                    fontSizeMode: Text.Fit
                }


            }
        }
    }


    Rectangle {
        id: bottomBar
        anchors.bottom: parent.bottom
        width: parent.width
        height: 5
        color: speedLimit.border.color
        radius: 5
        layer.enabled: true
        layer.effect: Glow {
            samples: 30
            color: speedLimit.border.color
            transparentBorder: true
        }
    }
}
