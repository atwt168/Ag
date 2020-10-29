import QtQuick 2.0
import QtQuick.Window 2.0
import QtLocation 5.6
import QtPositioning 5.6

Window {
    width: 512
    height: 512
    visible: true

    Plugin {
        id: mapPlugin
        name: "osm" // "mapboxgl", "esri", ...
        // specify plugin parameters if necessary
        // PluginParameter {
        //     name: 
        //     value:
        // }


//        https://stackoverflow.com/questions/53112393/qml-openstreetmap-custom-tiles?rq=1
        PluginParameter
          {
              name: "osm.mapping.custom.host"
              value: "http://a.tile.openstreetmap.fr/hot/"
          }

//        PluginParameter {
//            name: "mapboxgl.mapping.additional_style_urls"
//        }
    }



    Map {
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(1.3413, 103.9638)
        zoomLevel: 19
        tilt: 55
        activeMapType: MapType.CustomMap

    }
}
