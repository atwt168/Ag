import QtGraphicalEffects 1.0
import QtLocation 5.9
import QtPositioning 5.0
import QtQuick 2.0

import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtMultimedia 5.8
import com.mapbox.cheap_ruler 1.0
import "qrc:/qml"
import Process 1.0


ApplicationWindow {

    id: window2

    // Km/h


    title: "ARgon"
    width: 640
    height: 480
    visible: true
    visibility: ApplicationWindow.FullScreen

    function openCam(){
        process.start("v4l2-ctl --overlay=1",[" "]);
    }

    function invertView(){
        rearview.visible = !rearview.visible
        map.visible = !map.visible

    }

//    Item{

//        Text {
//            id: text
//        }

//        Process {
//            id: process
//            onReadyRead: text.text = readAll();
//        }

//        Component.onCompleted: {
//            console.log('kek');
//            process.start("v4l2-ctl --overlay=1",[" "]);
//        }

//        Component.onDestruction: {
//            process.start("v4l2-ctl --overlay=0",[" "]);
//        }


//    }



//    RearView{
//        id: rearview
//        visible: true
//        objectName: "rearview"
//        Component.onDestruction: {
//            console.log("On Destruction");
//        }
//    }



    Item {
        id: map
        objectName: "map"
        visible: true
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        rotation: 0

        StatusBar {
            id: statusBar

            anchors.left: parent.left
            anchors.right: parent.right

            z: 1
        }

        MapWindow {
            carSpeed: 10
            navigating: true

            anchors.top: statusBar.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            z: 0

            traffic: bottomBar.traffic
            night: bottomBar.night
        }

        BottomBar {
            id: bottomBar

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            z: 1
            visible: false
        }
    }






}
