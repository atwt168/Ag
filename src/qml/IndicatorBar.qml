import QtQuick 2.9
import QtQuick.Window 2.2

Item {
    id:root
    //Properties that only ned change
    property string strokeStyleColor
    property string fillStyleColor
    property string imageSource
    property var textToUse
    property int textToUseWidth : 525
    property bool instructionTextVisible1
    property string fontFamily

    FontLoader {
        id: roboto
        source: "qrc:/fonts/Roboto-Medium.ttf"
    }

    //Small trapeium closer to the left
    Canvas {
        id: trapezium
        width: 640
        height: 480

        onPaint: {
            var ctx = getContext("2d")
            ctx.lineWidth = 0.1
            ctx.strokeStyle = "white"
            ctx.fillStyle = "white"
            ctx.beginPath()
            ctx.moveTo(555, 425)
            ctx.lineTo(565, 425)
            ctx.lineTo(600, 480)
            ctx.lineTo(590, 480)
            ctx.closePath
            ctx.fill()
            ctx.stroke()
        }
    }

    //Small trapezium closer to the right
    Canvas {
        id: trapezium2
        width: 640
        height: 480

        onPaint: {
            var ctx = getContext("2d")
            ctx.lineWidth = 0.1
            ctx.strokeStyle = "#white"
            ctx.fillStyle = "white"
            ctx.beginPath()
            ctx.moveTo(575, 425)
            ctx.lineTo(585, 425)
            ctx.lineTo(620, 480)
            ctx.lineTo(610, 480)
            ctx.closePath
            ctx.fill()
            ctx.stroke()
        }
    }

    //Large trapezium
    Canvas {
        id: triangle
        width: 640
        height: 480

        onPaint: {
            var ctx = getContext("2d")
            ctx.lineWidth = 0.1
            ctx.strokeStyle = strokeStyleColor
            ctx.fillStyle = fillStyleColor
            ctx.beginPath()
            ctx.moveTo(0, 425)
            ctx.lineTo(540, 425)
            ctx.lineTo(575, 480)
            ctx.lineTo(0, 480)
            ctx.closePath()
            ctx.fill()
            ctx.stroke()
        }

        //Phone/Music icon on instructions bar
        Item {
            width: 55
            height: 55
            anchors.left: parent.left
            anchors.bottom: parent.bottom

            Image {
                id: instructionBarIcon
                source: imageSource
                width: 25
                height: 25
                anchors.centerIn: parent
            }
        }

        //Phone/Music instructions bar
        Item {
            id: instructionBar
            width: 450
            height: 55
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 75
            clip: true

            //Instructions bar phone/music text
            Text {
                id: textCall
                text: textToUse
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
                visible: true

                font {
                    family: roboto.name
                    pixelSize: 30
                }

                //Instructions bar text sliding animation
                NumberAnimation on x {
                    id: textcallAnimation
                    from: 570
                    //to: -525
                    to: - textMetrics.tightBoundingRect.width
                    loops: Animation.Infinite
                    duration: 10000

                }
            }

            //Get instructions bar text length
            TextMetrics{
                id:textMetrics
                font: textCall.font
                text: textCall.text
            }
        }
    }
}
