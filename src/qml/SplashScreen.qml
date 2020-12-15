import QtQuick 2.0
import QtQuick.Controls 2.0
 

Rectangle {
    id: splashScreen 
    
	width: 640
	height: 480

	// Rectangle {
	// 	id: splashRect
	// 	anchors.fill: parent
	//     color: "red"
	// 	border.width: 1
	// 	border.color: "black"
		
	// 	Text {
	// 		id: initializationErrorMessage
	// 		text: "This is the splash screen"
	// 		anchors.horizontalCenter: parent.horizontalCenter
	// 		anchors.top: parent.top
    //         anchors.topMargin: 50
	// 		font.bold: true
	// 		font.pixelSize: 20
	// 		color: "black"
	// 	}

	// 	BusyIndicator {
	// 		id: busyAnimation
	// 		anchors.horizontalCenter: parent.horizontalCenter
	// 		anchors.bottom: parent.bottom
	// 		anchors.bottomMargin: parent.height / 5
	// 		width: parent.width / 2
	// 		height: width
	// 		running: true
	// 	}
	// }
 
	Image{
		source :"qrc:argonsplash2.jpg"
		BusyIndicator {
			id: busyAnimation
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.bottom: parent.bottom
			anchors.bottomMargin: parent.height / 3
			width: parent.width / 4
			height: width
			running: true
		}
	}

    Component.onCompleted: visible = true
}