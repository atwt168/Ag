import QtQuick 2.12
import QtQuick.Window 2.2

Item {
    id: root
    //Color of instructions bar
    property string strokeStyleColor
    property string fillStyleColor
    //Music/Phone icon
    property string imageSource
    //Music/Phone Text
    property string textToUse
    property real textWidth: -textMetrics.tightBoundingRect.width
    //Shadow for instructions bar text
    property bool instructionMusicBarDropShadowVisible
    property bool instructionCallBarDropShadowVisible

    //Load in roboto font
    FontLoader {
        id: fontRoboto
        source: "qrc:/fonts/Roboto-Medium.ttf"
    }

    //Small trapeium to the right of largeTrapezium
    Canvas {
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

    //Small trapezium closer to the right of the screen
    Canvas {
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
                //id: instructionBarIcon
                source: imageSource
                width: 25
                height: 25
                anchors.centerIn: parent
            }
        }

        //Phone/Music instructions bar
        Item {
            id: blueGreenBarText
            width: 450
            height: 55
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 75
            clip: true



            Item {
                id: textCall
                property alias text: textAnimation.text
                property int spacing: 30
                width: 640
                height: parent.height
                clip: true


                Text {
                    id: textAnimation
                    text: textToUse
                    color: "white"
                    x: root.width
                    anchors.verticalCenter: parent.verticalCenter
                    NumberAnimation on x {
                        running: true
                        from: 630
//                        to: -root.width
                        to:-textMetrics.tightBoundingRect.width-root.width
                        duration: 7500
                        loops: Animation.Infinite
                    }

                    Text {
                        x: root.width
                        text: textCall.text

                        visible: false
                    }

                    font {
                        family: fontRoboto.name
                        pixelSize: 30
                    }
                }
            }

            //Get instructions bar text length
            TextMetrics {
                id: textMetrics
                font: textAnimation.font
                text: textAnimation.text
            }
        }

        //Shadow to show phone text fading out
        Rectangle {
            //id: instructionCallBarDropShadowLeft
            width: 30
            height: 55
            anchors.left: blueGreenBarText.left
            anchors.bottom: parent.bottom
            rotation: 180
            visible: instructionCallBarDropShadowVisible
            //Green color with transparency
            //Gradient with largest transparency on the right
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 0.0
                    color: "#2000f264"
                }
                GradientStop {
                    position: 0.33
                    color: "#3300f264"
                }
                GradientStop {
                    position: 0.66
                    color: "#6600f264"
                }
                GradientStop {
                    position: 1.0
                    color: "#9900f264"
                }
            }
        }

        //Shadow to show phone text fading in
        Rectangle {
            //id: instructionCallBarDropShadowRight
            width: 30
            height: 55
            anchors.right: blueGreenBarText.right
            anchors.bottom: parent.bottom
            visible: instructionCallBarDropShadowVisible
            //Green color with transparency
            //Gradient with largest transparency on the left
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 0.0
                    color: "#2000f264"
                }
                GradientStop {
                    position: 0.33
                    color: "#3300f264"
                }
                GradientStop {
                    position: 0.66
                    color: "#6600f264"
                }
                GradientStop {
                    position: 1.0
                    color: "#9900f264"
                }
            }
        }

        //Shadow to show music text fading out
        Rectangle {
            //id: instructionMusicBarDropShadowLeft
            width: 30
            height: 55
            anchors.left: blueGreenBarText.left
            anchors.bottom: parent.bottom
            rotation: 180
            visible: instructionMusicBarDropShadowVisible
            //Blue color with transparency
            //Gradient with largest transparency on the right
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 0.0
                    color: "#2000c6ff"
                }
                GradientStop {
                    position: 0.33
                    color: "#3300c6ff"
                }
                GradientStop {
                    position: 0.66
                    color: "#6600c6ff"
                }
                GradientStop {
                    position: 1.0
                    color: "#9900c6ff"
                }
            }
        }

        //Shadow to show music text fading in
        Rectangle {
            //id: instructionMusicBarDropShadowRight
            width: 30
            height: 55
            anchors.right: blueGreenBarText.right
            anchors.bottom: parent.bottom
            visible: instructionMusicBarDropShadowVisible
            //Bluen color with transparency
            //Gradient with largest transparency on the left
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 0.0
                    color: "#2000c6ff"
                }
                GradientStop {
                    position: 0.33
                    color: "#3300c6ff"
                }
                GradientStop {
                    position: 0.66
                    color: "#6600c6ff"
                }
                GradientStop {
                    position: 1.0
                    color: "#9900c6ff"
                }
            }
        }
    }
}
