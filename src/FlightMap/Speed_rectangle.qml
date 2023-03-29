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
    property real vel_max:18
    height:size
    width:height/4
    id: speed_rectangle


    BARRA_VELOCIDADE{
        size:parent.height
        airspeed:_speed
        v_max:vel_max
    }


    Rectangle{
        id:                 speed_rectanglee
        height:             parent.height
        width:              height/4
        color:              "transparent"
        radius:             width/4
        Text {
            text: Math.round(_speed) + " m/s"
            font.family: "Helvetica"
            font.pointSize: parent.width/7
            color: _speed>=vel_max-5? (_speed>=vel_max?"black":"black"):"white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset:-parent.width/7
        }

    }

    //Eu sou veloz -Faísca McQueen

}
