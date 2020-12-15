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


Item {
    id: map_
    objectName: "map"
    visible: false
    anchors.centerIn: parent
    width: parent.width
    height: parent.height
    rotation: 0
    Component.onCompleted: {console.log("````````````````````````````````````````````````````````completed")}
    property int speed;

    function btoothConnected(){
        statusBar.changebtoothImage();
    }

    function startNavigation(startlat,startlng,endlat,endlng){
//        mapwindow.carSpeed = 0.0001;
//        mapwindow.navigating = true;
        mapwindow.startNavigation(startlat,startlng,endlat,endlng);

    }

    function stopNavigation(){
        mapwindow.stopNavigation();
    }

    function setZoom(zoom){
        mapwindow.setZoom(zoom);
    }

    StatusBar {
        id: statusBar
        height:50
        anchors.left: parent.left
        anchors.right: parent.right
        visible: false
        z: 1
    }


    MapWindow {
        id:mapwindow
        carSpeed: 250
        navigating: false

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        z: 0

        traffic: bottomBar.traffic
        night: true
    }

    BottomBar {
        id: bottomBar
        visible: false
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        z: 1

    }
}
