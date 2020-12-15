import QtQuick 2.0
import QtQml 2.2


Rectangle {
    id: knob
    transformOrigin: Item.Center
    color: "transparent"
    property int lineWidth: width / 30

    property int fontSize: width / 7

    property color knobBackgroundColor: "#885b5b5b"
    property color knobColor: Qt.rgba(1, 0, 0, 1)

    //value parameters
    property double from:0
    property double value: 1
    property double to: 100

    //progress circle angle
    property double fromAngle: Math.PI - 1
    property double toAngle: Math.PI *2 + 1

    //progress from right to left
    property bool reverse: false

    function update(value) {
        knob.value = value
        canvas.requestPaint()
        label.text = value.toFixed(2);
        label.anchors.horizontalCenter = knob.horizontalCenter
        label.anchors.verticalCenter = knob.verticalCenter
        label.transformOrigin = Item.Center
        label.anchors.centerIn = knob.anchors.centerIn
    }
    function randomNumber(low, upp) {


        var rand = Math.floor((Math.random() * (upp - low + 1)) + low)
        knob.value = label.val
        canvas.requestPaint()
//        console.log(label.val-71)
//        update(rand)

        return rand
    }

    function getLabelVal(){
        if (label.val-71<0){
            return 0;
        }else if(label.val-71>200){
            return 200;
        }else{
            return label.val-71;
        }


    }



    Text {
        id: label
        property int val: 5
        width: 40
        height: 12
        font.bold: true
        z: 1
        font.pointSize: knob.fontSize
        text: val
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        SequentialAnimation {
            running: true
            loops: Animation.Infinite
            NumberAnimation {
                target: label
                property: "val"
                to: randomNumber(100, 350)
                duration: randomNumber(1000,2000)
                easing.type: Easing.InCubic
            }
            NumberAnimation {
                target: label
                property: "val"
                to: randomNumber(100, 200)
                duration: randomNumber(1000,5000)
                easing.type: Easing.InCubic
            }
            NumberAnimation {
                target: label
                property: "val"
                to: randomNumber(100, 350)
                duration: randomNumber(1000,5000)
                easing.type: Easing.InCubic
            }
            NumberAnimation {
                target: label
                property: "val"
                to: randomNumber(100, 250)
                duration: randomNumber(1000,5000)
                easing.type: Easing.InCubic
            }
        }
    }



    Canvas {
        id: background
        width: parent.width
        height: parent.height
        antialiasing: true

        property int radius: background.width/2

        onPaint: {
            var ctx = background.getContext('2d');
            ctx.strokeStyle = knob.knobBackgroundColor;
            ctx.lineWidth = knob.lineWidth;
            ctx.lineCap = "round"
            ctx.beginPath();
            ctx.clearRect(0, 0, background.width, background.height);
            ctx.arc(radius, radius, radius - knob.lineWidth, knob.fromAngle, knob.toAngle, false);
            ctx.shadowColor = knobColor;
            ctx.shadowBlur = 10;
            ctx.stroke();
        }
    }

    Canvas {
        id:canvas
        width: parent.width
        height: parent.height
        antialiasing: true

        property double step: knob.value / (knob.to - knob.from) * (knob.toAngle - knob.fromAngle)
        property int radius: width/2

        onPaint: {
            var ctx = canvas.getContext('2d');
            ctx.strokeStyle = knob.knobColor;
            ctx.lineWidth = knob.lineWidth;
            ctx.lineCap = "round"
            ctx.beginPath();

            ctx.clearRect(0, 0, canvas.width, canvas.height);
            if (knob.reverse) {
                ctx.arc(radius, radius, radius - knob.lineWidth, knob.toAngle, knob.toAngle - step, true);
            } else {
                ctx.arc(radius, radius, radius - knob.lineWidth, knob.fromAngle, knob.fromAngle + step, false);
            }

//            console.log(knob.toAngle-step)


//            ctx.shadowColor = "white";
//            ctx.shadowBlur = 4;
            ctx.stroke();
        }
    }
}
