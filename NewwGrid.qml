import QtQuick              2.3
import QtGraphicalEffects   1.0

import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Palette       1.0
import QtMultimedia                 5.15


Item {
    property bool showPitch:    true
    property var  vehicle:      null
    property real size
    property bool showHeading:  false

    property real _rollAngle:   vehicle ? vehicle.roll.rawValue : 0
    property real _pitchAngle:  vehicle ? vehicle.pitch.rawValue : 0
    property real _airspeed:    vehicle ? vehicle.airSpeed.rawValue : 0
    property real _altitude:    vehicle ? vehicle.altitudeRelative.rawValue : 0
    property real _throttlePct:    vehicle ? vehicle.throttlePct.rawValue : 0
    property real _flightDistance:    vehicle ? vehicle.flightDistance.rawValue : 0
    property real _altitudeAMSL:    vehicle ? vehicle.altitudeAMSL.rawValue : 0
    property real _groundSpeed:    vehicle ? vehicle.groundSpeed.rawValue : 0
    property real _heading:    vehicle ? vehicle.heading.rawValue : 0
    id: rootgrid


    property real comprimento: visualInstrument.width/3R
    property real altura: comprimento/3

    SoundEffect {
         id: playSound
         source: "qrc/res/audio/barulho.wav"
     }

    function getColor(par,value1,value2){
        var color = color
        if(par >= value1 && par <= value2 ){
            color = "orange"
        }
        else if(par >= value2){

            color = "red"
    }

        else{
            color = "black"
        }
        return color
    }




    Grid{

        id:grid
        columns: 3
        rows: 6

        Rectangle{color:getColor(_airspeed,10,15);width:comprimento;height:altura;Text{text: "airspeed";color:"yellow";font.pointSize: altura/5;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: "altitude";color:"green";font.pointSize: altura/5;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: "pitchAngle";color:"blue";font.pointSize:altura/5;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:getColor(_airspeed,10,15);width:comprimento;height:altura;Text{text: Math.round(_airspeed * 10) / 10 + " m/s";color:"yellow";font.pointSize: altura/3;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: Math.round(_altitude * 10) / 10 + " m";color:"green";font.pointSize: altura/3;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: Math.round(_pitchAngle * 10) / 10 + "º";color:"blue";font.pointSize: altura/3;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}

        Rectangle{color:"black";width:comprimento;height:altura;Text{text: "rollAngle";color:"orange";font.pointSize: altura/5;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: "throttlePct";color:"purple";font.pointSize:altura/5;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: "flightDistance";color:"violet";font.pointSize: altura/5;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: Math.round(_rollAngle * 10)/ 10 + "º";color:"orange";font.pointSize: altura/3;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: Math.round(_throttlePct * 10) / 10 + "%";color:"purple";font.pointSize: altura/3;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: Math.round(_flightDistance * 10) / 10 + " m";color:"violet";font.pointSize: altura/3;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}

        Rectangle{color:"black";width:comprimento;height:altura;Text{text: "altitudeAMSL";color:"steelblue";font.pointSize: altura/5;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: "groundSpeed";color:"darkmagenta";font.pointSize: altura/5;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: "heading";color:"cyan";font.pointSize: altura/5;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: Math.round(_altitudeAMSL * 10) / 10 + " m";color:"steelblue";font.pointSize: altura/3;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: Math.round(_groundSpeed * 10) / 10 + " m/s";color:"darkmagenta";font.pointSize: altura/3;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:comprimento;height:altura;Text{text: Math.round(_heading) + "º";color:"cyan";font.pointSize: altura/3;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}



        spacing: 0

    }
}
