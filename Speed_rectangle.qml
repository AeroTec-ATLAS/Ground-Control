import QtQuick              2.3
import QtGraphicalEffects   1.0

import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Palette       1.0


Item {

    property bool showPitch:    true
    property var  vehicle:      null
    property real size
    property bool showHeading:  false


    property real _speed:    vehicle ? vehicle.airSpeed.rawValue : 0


    id: speed_rectangle




       Rectangle{
        id:                 speed_rectanglee
        height:             visualInstrument.height
        width:              height/4
        color:              "black"
        radius:             width/4
        Text {
            text: Math.round(_speed) + " m/s"
            font.family: "Helvetica"
            font.pointSize: parent.width/7
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }
    
    //Eu sou veloz -Faísca McQueen

}
