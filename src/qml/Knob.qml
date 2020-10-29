import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Extras 1.4
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12

Rectangle {
    id: knob
    transformOrigin: Item.Right

    property int lineWidth: width / 53

    property int fontSize: width / 7

    property color knobBackgroundColor: "#55666d" //Grey
    //property color knobColor: "#4093b5"                   //Dark Blue
    property color knobColor: "#ccf3fa" //Light Blue

    //value parameters
    property double from: 0
    property double value: 0
    property double to: 150

    //progress circle angle
    property double fromAngle: 2.967
    property double toAngle: 4.807388
    //progress from right to left
    property bool reverse: false

    //When speedometer value change, update
    function update(value) {
        knob.value = value
        canvas.requestPaint()
    }

    //Blackground of knob
    Canvas {
        id: background
        width: parent.width
        height: parent.height
        antialiasing: true

        property int radius: background.width / 2

        onPaint: {
            var ctx = background.getContext('2d')
            ctx.strokeStyle = knob.knobBackgroundColor
            ctx.lineWidth = knob.lineWidth
            //ctx.lineCap = "round"
            ctx.beginPath()
            ctx.clearRect(0, 0, background.width, background.height)
            ctx.arc(radius, radius, radius - knob.lineWidth, knob.fromAngle,
                    knob.toAngle, false)
            ctx.stroke()
        }
    }

    //Fills the background depending on current speed
    Canvas {
        id: canvas
        width: parent.width
        height: parent.height
        antialiasing: true

        property double step: knob.value / (knob.to - knob.from) * (knob.toAngle - knob.fromAngle)
        property int radius: width / 2

        onPaint: {
            var ctx = canvas.getContext('2d')
            ctx.strokeStyle = knob.knobColor
            ctx.lineWidth = knob.lineWidth
            //ctx.lineCap = "round"
            ctx.beginPath()
            ctx.clearRect(0, 0, canvas.width, canvas.height)
            if (knob.reverse) {
                ctx.arc(radius, radius, radius - knob.lineWidth, knob.toAngle,
                        knob.toAngle - step, true)
            } else {
                ctx.arc(radius, radius, radius - knob.lineWidth,
                        knob.fromAngle, knob.fromAngle + step, false)
            }
            ctx.stroke()
        }
        layer.enabled: true
        layer.effect: Glow {
            samples: 15
            spread: 0.5
            radius: 15
            //color: "#92d6eb"
            color: "#004066" //Dark blue
            transparentBorder: true
        }
    }
}
