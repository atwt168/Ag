import QtLocation 5.9
import QtPositioning 5.0
import QtQuick 2.0
//import QlChannelSerial 1.0
import com.mapbox.cheap_ruler 1.0
//import MySerialPort 1.0
import Process 1.0
Item {
    id: mapWindow

    // Km/h
    property var carSpeed: 85
    property var navigating: true
    property var traffic: false
    property var night: true

    function startNavigation(startlat,startlng,endlat,endlng){
        setMarkerCoordinates(startlat,startlng,endlat,endlng);
        mapWindow.navigating = true;
        map.updateRoute();

    }

    function stopNavigation(){
        mapWindow.navigating = false;
    }

    function setMarkerCoordinates(startlat,startlng,endlat,endlng){
        startMarker.coordinate = QtPositioning.coordinate(startlat, startlng);
        endMarker.coordinate = QtPositioning.coordinate(endlat, endlng);
    }

    function setZoom(zoom){
        map.zoomLevel = zoom;
    }

    function getArrow(instr,chgArrow){
        if (instr.indexOf("left") !==-1) {
           //console.log("LEFT")
           if(chgArrow) //mapgpsbar.arrowAsset="qrc:leftTurnGlow.png"
           return "Turn Left"
        }else if(instr.indexOf("right") !==-1){
            if(chgArrow) //mapgpsbar.arrowAsset="qrc:rightTurnGlow.png"
            return "Turn Right"
            //console.log("RIGHT")

        }
        else{
            return "Head Straight"
        }
    }

    function delay(duration) { // In milliseconds
        var timeStart = new Date().getTime();

        while (new Date().getTime() - timeStart < duration) {
            // Do nothing
        }

        // Duration has passed
    }

//    Component.onDestruction: {
//        console.log("closing serial");
//        serialPort.closeSerialPort();
//    }

    Component.onCompleted:{
//        startNavigation(36.1215,-115.1663,36.065649,-115.111595)
        startNavigation(1.3413,103.9638,1.2941,103.8578)
    }

//    MouseArea{
//        anchors.fill:parent
//        onClicked: startNavigation(1.3413,103.9638,1.2941,103.8578)
//    }


    states: [
        State {
            name: ""
            PropertyChanges { target: map; tilt: 0; bearing: 0; zoomLevel: map.zoomLevel }
        },
        State {
            name: "navigating"
            PropertyChanges { target: map; tilt: 60; zoomLevel: 20 }
        },

        State {
            name:"visibility" ;when: mapWindow.visible
            PropertyChanges{ target:currentDistanceAnimation; running:true}
            PropertyChanges { target: map; tilt: 60; zoomLevel: 20 }
        }


    ]

    transitions: [
        Transition {
            to: "*"
            RotationAnimation { target: map; property: "bearing"; duration: 100; direction: RotationAnimation.Shortest }
            //RotationAnimation { target: carMarker; property: "rotation"; duration: 100; direction: RotationAnimation.Shortest }
            NumberAnimation { target: map; property: "zoomLevel"; duration: 100 }
            NumberAnimation { target: map; property: "tilt"; duration: 100 }
        }
    ]

    state: navigating ? "navigating" : ""

//    Image {
//        anchors.left: parent.left
//        anchors.right: parent.right
//        z: 2

//        source: "qrc:map-overlay-edge-gradient.png"
//    }

//    Image {
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom
//        anchors.margins: 5
//        anchors.bottomMargin: 270

//        z: 3

//        source: "qrc:qt.png"
//    }

//    Image {
//        anchors.left: parent.left
//        anchors.bottom: parent.bottom
//        anchors.margins: 5
//        anchors.bottomMargin: 270

//        z: 3

//        source: "qrc:mapbox.png"
//    }

//    MapGPSBar{
//        id:mapgpsbar
//        anchors.left: parent.left
//        anchors.right: parent.right
//        textInstructions : turnInstructions.text
//        z: 1
//        visible: false
//    }

//    InfoBar {
//        id: infoBar
//        anchors.fill: parent
//        z: 1
//        visible: true
//        textInstructions : turnInstructions.text

//    }

//    CustomLabel {
//        id: turnInstructions
//        visible: false
//        anchors.top: parent.top
//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.margins: 20
//        z: 3
//        font.pixelSize: 38
//    }

    Map {
        id: map
        anchors.fill: parent

        plugin: Plugin {
            name: "mapboxgl"

            PluginParameter {
                name: "mapboxgl.mapping.items.insert_before"
                value: "road-label-small"
            }

            PluginParameter {
                name: "mapboxgl.access_token"
//                value: "pk.eyJ1IjoidG1wc2FudG9zIiwiYSI6ImNqMWVzZWthbDAwMGIyd3M3ZDR0aXl3cnkifQ.FNxMeWCZgmujeiHjl44G9Q"
                value:"pk.eyJ1IjoibWhidC03MDMiLCJhIjoiY2pmdWphMHkxMDlsdzJxcDVkM3B4ZmdqcSJ9.25R0bvPFWtLmz9n2NSJx9w"
            }

            PluginParameter {
                name: "mapboxgl.mapping.additional_style_urls"
                value: "mapbox://styles/mapbox/navigation-guidance-day-v2,mapbox://styles/mapbox/navigation-guidance-night-v2,mapbox://styles/mapbox/navigation-preview-day-v2,mapbox://styles/mapbox/navigation-preview-night-v2"
            }

            PluginParameter{
                name:"mapboxgl.mapping.cache.size"
                value:"200"
            }

//            PluginParameter{
//                name:"mapboxgl.mapping.cache.directory"
//                value:"/home/pi/.cache/qmapboxglapp/"
//            }


        }

        activeMapType: {
            var style;

            if (mapWindow.navigating) {
                style = night ? supportedMapTypes[1] : supportedMapTypes[0];
            } else {
                style = night ? supportedMapTypes[3] : supportedMapTypes[2];
            }

            return style;
        }


        center: mapWindow.navigating ? ruler.currentPosition : QtPositioning.coordinate(1.3413, 103.9638)
        zoomLevel: 19
        minimumZoomLevel: 0
        maximumZoomLevel: 19
        tilt: 0
        copyrightsVisible: false




        /*
        MapParameter {
            type: "layout"

            property var layer: "traffic-links-tunnel-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"7=

            property var layer: "traffic-street-service-tunnel-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-secondary-tertiary-tunnel-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-primary-tunnel-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-trunk-tunnel-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-tunnel-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-tunnel-dark-casing"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-trunk-tunnel-dark-casing"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-tunnel"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-street-service-tunnel"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-secondary-tertiary-tunnel"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-primary-tunnel"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-trunk-tunnel"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-street-service-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-secondary-tertiary-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-primary-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-trunk-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-dark-casing"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-trunk-dark-casing"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-street-service"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-secondary-tertiary"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-primary"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-trunk-bg-low"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-bg-low"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-trunk"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-bridge-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-street-service-bridge-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-secondary-tertiary-bridge-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-primary-bridge-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-trunk-bridge-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-bridge-bg"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-bridge-dark-casing"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-trunk-bridge-dark-casing"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-links-bridge"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-street-service-bridge"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-secondary-tertiary-bridge"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-primary-bridge"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

        MapParameter {
            type: "layout"

            property var layer: "traffic-motorway-trunk-bridge"
            property var visibility: mapWindow.traffic ? "visible" : "none"
        }

//        MapParameter {
//            type: "layer"

//            property var name: "3d-buildings"
//            property var source: "composite"
//            property var sourceLayer: "building"
//            property var layerType: "fill-extrusion"
//            property var minzoom: 15.0
//        }

//        MapParameter {
//            type: "filter"

//            property var layer: "3d-buildings"
//            property var filter: [ "==", "extrude", "true" ]
//        }

//        MapParameter {
//            type: "paint"

//            property var layer: "3d-buildings"
//            property var fillExtrusionColor: "#00617f"
//            property var fillExtrusionOpacity: .6
//            property var fillExtrusionHeight: { return { type: "identity", property: "height" } }
//            property var fillExtrusionBase: { return { type: "identity", property: "min_height" } }
//        }
*/

        MouseArea {
            anchors.fill: parent

            onWheel: {
                mapWindow.navigating = false
                wheel.accepted = false
            }
        }

        gesture.onPanStarted: {
            mapWindow.navigating = false
        }

        gesture.onPinchStarted: {
            mapWindow.navigating = false
        }

        RotationAnimation on bearing {
            id: bearingAnimation

            duration: 250
            alwaysRunToEnd: false
            direction: RotationAnimation.Shortest
            running: mapWindow.navigating
        }

        Location {
            id: previousLocation
            coordinate: QtPositioning.coordinate(0, 0);
        }

        onCenterChanged: {
            if (previousLocation.coordinate == center || !mapWindow.navigating )
                return;

            bearingAnimation.to = previousLocation.coordinate.azimuthTo(center);
            bearingAnimation.start();

            previousLocation.coordinate = center;
        }

        function updateRoute() {
            routeQuery.clearWaypoints();
            routeQuery.addWaypoint(startMarker.coordinate);
            routeQuery.addWaypoint(endMarker.coordinate);
        }

        MapQuickItem {
            id: startMarker

            sourceItem: Image {
                id: greenMarker
                source: "qrc:///marker-green.png"
            }



            anchorPoint.x: greenMarker.width / 2
            anchorPoint.y: greenMarker.height / 2

            MouseArea  {
                drag.target: parent
                anchors.fill: parent

                onReleased: {
                    map.updateRoute();
                }
            }
        }

        MapQuickItem {
            id: endMarker

            sourceItem: Image {
                id: redMarker
                source: "qrc:///marker-red.png"
            }

//            coordinate : QtPositioning.coordinate(1.440919, 103.796345)
            anchorPoint.x: redMarker.width / 2
            anchorPoint.y: redMarker.height / 2

            MouseArea  {
                drag.target: parent
                anchors.fill: parent

                onReleased: {
                    map.updateRoute();
                }
            }
        }

        MapItemView {
            model: routeModel

            delegate: MapRoute {
                route: routeData
                line.color: "#1e88e5"
                line.width: map.zoomLevel - 5
                opacity: (index == 0) ? 1.0 : 0.3

                onRouteChanged: {

                        ruler.path = routeData.path;
                        ruler.currentDistance = 0;

                        //currentDistanceAnimation.stop();
                        currentDistanceAnimation.to = ruler.distance;
                        currentDistanceAnimation.start();

                }
            }
        }

        MapQuickItem {
            zoomLevel: map.zoomLevel

            sourceItem: Image {
                id: carMarker
                source: "qrc:///car-marker.png"

            }

            //coordinate: src.position.coordinate
            coordinate: ruler.currentPosition
            anchorPoint.x: carMarker.width / 2
            anchorPoint.y: carMarker.height / 2


        }

        Timer {
            id: timer
            interval: 3500
            running: false
            repeat: false

            property var callback

            onTriggered: callback()
        }

        Process {
            id: proces
            onReadyRead: text.text = readAll();
        }

        CheapRuler {
            id: ruler
            PropertyAnimation on currentDistance {

                id: currentDistanceAnimation
                running: true
                duration: ruler.distance / mapWindow.carSpeed * 60 * 60 * 1000
                alwaysRunToEnd: false

            }



            onCurrentDistanceChanged: {
                currentDistanceAnimation.running = true;
//                if(!mapWindow.visible) {
//                    console.log("stopping anim now");
//                    currentDistanceAnimation.running = false;

//                }
                //console.log(ruler.currentPosition);

                var total = 0;
                var i = 0;
                var totseg=0;
                var prev_i =0;
                // XXX: Use car speed in meters to pre-warn the turn instruction
                while (total - mapWindow.carSpeed < ruler.currentDistance * 1000 && i < routeModel.get(0).segments.length)

                    total += routeModel.get(0).segments[i++].maneuver.distanceToNextInstruction;
//                    totseg += routeModel.get(0).segments[i-1].distance;
//                    var q = -ruler.currentDistance * 1000+ routeModel.get(0).segments[i].distance;
//                    console.log("trigg "+i+" "+total);
                if(mapWindow.navigating){
                    var arrowInstr = getArrow(routeModel.get(0).segments[i-1].maneuver.instructionText,false);
//                    if(turnInstructions.text !== routeModel.get(0).segments[i].maneuver.instructionText ){
//                        turnInstructions.text = arrowInstr
//                        var dist = routeModel.get(0).segments[i].maneuver.distanceToNextInstruction;
//                        getArrow(routeModel.get(0).segments[i+1].maneuver.instructionText);
//                        dist = Math.ceil(dist/100)*100
//                        //console.log(routeModel.get(0).segments[i].maneuver.instructionText + " in "+dist +" meters")
//                        //process.start("~/speech.sh "+routeModel.get(0).segments[i].maneuver.instructionText + " in "+dist,[" "]);
//                        timer.callback = function(){
//                            turnInstructions.text = routeModel.get(0).segments[i].maneuver.instructionText
//                            getArrow(routeModel.get(0).segments[i].maneuver.instructionText,true);
//                        }
//                        timer.start()

//                    }

                    //turnInstructions.text = routeModel.get(0).segments[i].maneuver.instructionText + " in "+routeModel.get(0).segments[i].maneuver.distanceToNextInstruction;


                }

            }
        }

//        MySerialPort{
//            id:serialPort
//        }

//        QlChannelSerial {
//            id:serial

//        }

//        Component.onCompleted: {

//                // open first available port
//                //console.log("serial:",serial.channels()[1]);
//                serial.open(serial.channels()[1]);

//                // if success - configure port parameters
//                if (serial.isOpen()){
//                    serial.paramSet('baud', '9600');
//                    serial.paramSet('bits', '8');
//                    serial.paramSet('parity', 'even');
//                    serial.paramSet('stops', '0');

//                    serial.paramSet('dtr', '0');
//                    serial.paramSet('rts', '1');

////                    // write bytes/ASCII string
////                    serial.writeBytes([1,2,3,4,5]);
////                    serial.writeString('123456789');

//                    // read received bytes
//                    var kek =""
//                    for(i=0;i<10;i++){
//                        kek+= serial.readBytestoString();
//                    }


//                    var data = serial.readBytes();
//                    console.log("data 9600:",kek)




//                }
//            }


    }

    RouteModel {
        id: routeModel

        autoUpdate: true
        query: routeQuery

        plugin: Plugin {
            name: "mapbox"

            // Development access token, do not use in production.
            PluginParameter {
                name: "mapbox.access_token"
//                value: "pk.eyJ1IjoicXRzZGsiLCJhIjoiY2l5azV5MHh5MDAwdTMybzBybjUzZnhxYSJ9.9rfbeqPjX2BusLRDXHCOBA"
                value:"pk.eyJ1IjoibWhidC03MDMiLCJhIjoiY2pmdWphMHkxMDlsdzJxcDVkM3B4ZmdqcSJ9.25R0bvPFWtLmz9n2NSJx9w"
            }
        }

        Component.onCompleted: {
            if (map) {

//                map.updateRoute();
            }
        }
    }

    RouteQuery {
        id: routeQuery
    }

    PositionSource {
         id: src
         name: "libqtposition_gpsd"
         updateInterval: 500
         active: true

         preferredPositioningMethods: PositionSource.AllPositioningMethods


         onPositionChanged: {

             var coord = src.position.coordinate;
             var time =  new Date().toLocaleString(Qt.locale("sg_SG")).split(' ')[4];
//             console.log(position.coordinate)
//             console.log("Coordinate:", coord.latitude, coord.longitude,src.position.speed,src.position.speedValid,"TIME:",time);

            //src.update();
             src.stop();
             src.start();


         }

//         function reset(){
//             src.position.coordinate =0;
//         }



     }







}
