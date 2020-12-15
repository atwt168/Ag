import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

Rectangle {

    anchors.fill: parent
    height: parent.height
    width: parent.width
    color: "black"
    property string lightBlue: "#42c8f4"
    property string red: "#F94646"
    function randomNumber(low, upp) {
        return Math.floor((Math.random() * (upp - low + 1)) + low)
    }
    Rectangle {
        id: topStatusBar
        anchors.top: parent.top
        color: "black"
        width: parent.width
        height: 40
        property var currentDate: new Date()
        Timer {
            interval: 60000
            running: true
            repeat: true
            onTriggered: {
                topStatusBar.currentDate = new Date()
            }
        }
        Text {
            anchors.centerIn: parent
            text: Qt.formatDateTime(topStatusBar.currentDate, "HH:mm")
            color: "white"
            font.pointSize: 20
        }
    }
    Rectangle {
        id: bottomHighlight
        anchors.bottom: topStatusBar.bottom
        width: parent.width
        height: 0.5
        color: "white"
        radius: 5
    }

    ColumnLayout {
        id: directionsContainer
        anchors.top: topStatusBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height - topStatusBar.height
        width: 280
        spacing: 2
//        Rectangle {
//            anchors.fill: parent
//            height: parent.height
//            width: parent.width
//            border.color: "yellow"
//            color: "transparent"
//        }
        Image {
            id: directionsContainer_arrow
            Layout.preferredHeight: 250
            Layout.preferredWidth: parent.width
            source: "qrc:rightTurnGlow.png"
        }

        Text {
            id: directionsContainer_distance
            Layout.preferredHeight: 59
            Layout.preferredWidth: parent.width
            color: "white"
            font.pointSize: 30
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            text: "500 m"
        }
        Text {
            id: directionsContainer_instructions
            Layout.preferredHeight: 168
            Layout.preferredWidth: parent.width
            font.pointSize: 20
            color: "white"
            text: "Keep Right onto Pan Island Expressway"
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            wrapMode: Text.WordWrap
        }
    }

    Item {
        id: speedometerContainer
        anchors.top: topStatusBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: directionsContainer.right
        height: parent.height - topStatusBar.height
        width: parent.width - directionsContainer.width

        anchors.topMargin: 90
        anchors.leftMargin: 30

        LoadCircle {

            id: speedometerBar
            x: 0
            y: 0
            knobColor: speedLimit_gps.border.color
            width: 600
            height: width
            from: 71
            to: 580
            reverse: false
        }

        ColumnLayout {
            anchors.fill: parent
            Layout.preferredHeight: parent.height
            Layout.preferredWidth: parent.width
            spacing: 0.5
            Rectangle {
                id: speedLimit_gps
                Layout.preferredWidth: 85
                Layout.preferredHeight: Layout.preferredWidth
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 50
                Layout.topMargin: 40
                property int val : speedometerBar.getLabelVal()

                //            Layout.fillWidth: true
                //            anchors.bottom: parent.bottom
                //            anchors.right:parent.right
                color: "transparent"
                border.color: (val > speedLimit_text.text) ? red : lightBlue
                border.width: 3
                radius: width * 20

                //            anchors.topMargin: 200
                Text {
                    id: speedLimit_text
                    color: parent.border.color
                    text: "110"
                    fontSizeMode: Text.Fit
                    font.pointSize: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Text {
                id: gpsSpeedText
                color: "white"
                text: speedometerBar.getLabelVal()
                font.pointSize: 100
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 50
            }

            Text{
                text:"km/h"
                color: speedLimit_gps.border.color
                font.pointSize: 30
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 50
                Layout.bottomMargin: 30

            }
        }
    }
}
