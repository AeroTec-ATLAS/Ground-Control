/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick          2.3
import QtQuick.Layouts  1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects   1.0

import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.FactSystem    1.0
import QGroundControl.FlightMap     1.0
import QGroundControl.FlightDisplay 1.0
import QGroundControl.Palette       1.0

import QtQuick.Controls 1.2

ColumnLayout {
    id:         root
    spacing:    ScreenTools.defaultFontPixelHeight /4
    anchors.right:        parent.left

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
    property real _yawRate:    vehicle ? vehicle.yawRate.rawValue : 0






    property real   _innerRadius:           (width - (_topBottomMargin * 3)) / 4
    property real   _outerRadius:           _innerRadius + _topBottomMargin
    property real   _spacing:               ScreenTools.defaultFontPixelHeight * 0.33
    property real   _topBottomMargin:       (width * 0.05) / 2

    QGCPalette { id: qgcPal }



    Rectangle {
        id:                 visualInstrument
        height:             _innerRadius * 11
        width:              _innerRadius * 5

        anchors.left:        parent.left
        anchors.bottom:     parent.BottomLeft


        // Layout.fillWidth:   true
        radius:             _outerRadius
        color:              qgcPal.window


        //Propriedades para arrrastar
        property bool   allowDragging:  true
        property alias  tForm:          tform
        signal          resetRequested()


        ////This should make it translate -MB
        transform: Scale {
            id: tform
        }

        MouseArea {
            property double factor: 25
            enabled:            visualInstrument.allowDragging
            cursorShape:        Qt.OpenHandCursor
            anchors.fill:       parent
            drag.target:        parent
            drag.axis:          Drag.XAndYAxis

            //Scuffed limites
            drag.minimumX:      MainRootWindow.minimumWidth
            drag.minimumY:      0
            drag.maximumX:      0
            drag.maximumY:      mainWindow.height
            drag.filterChildren: true

            onPressed: {
                visualInstrument.anchors.left  = undefined
                visualInstrument.anchors.right = undefined
            }

            //reiniciar posição para canto superior direito
            onDoubleClicked: {
                visualInstrument.resetRequested();
                visualInstrument.x=0;
                visualInstrument.y=0;
            }


        }

        QGCAttitudeWidget {
            id:                     attitude

            anchors.horizontalCenter:   parent.horizontalCenter
            anchors.topMargin:          _spacing
            anchors.top:                parent.top
            Layout.leftMargin:          300
            size:                   _innerRadius * 11
            vehicle:                globals.activeVehicle
            anchors.verticalCenter: parent.verticalCenter
        }
        /*
        QGCCompassWidget {
            id:                     compass
            anchors.leftMargin:     _spacing
            anchors.left :          attitude.right
            size:                   _innerRadius * 4
            vehicle:                globals.activeVehicle
            anchors.verticalCenter: parent.verticalCenter
            visible:                false
        }
        */

        /*
        NewGridR{
            id: new_grid
            anchors.left: visualInstrument.left
            anchors.top: visualInstrument.bottom
        }
        */

    }

    Rectangle{
        id:                 altitude_rectangle
        height:             visualInstrument.height
        width:              height/4
        radius:             _outerRadius
        color:              "black"
        Layout.leftMargin:  -240
        Layout.topMargin:   -450

        Text {
            text: _airspeed
            font.family: "Helvetica"
            font.pointSize: 24
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }


    Rectangle{
        id:                 speed_rectangle
        height:             altitude_rectangle.height
        width:              height/4
        Layout.leftMargin:  300
        Layout.topMargin:   -500
        radius:             _outerRadius
        color:              "black"
        visible:            true
        Text {
            text: _altitude
            font.family: "Helvetica"
            font.pointSize: 24
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

    Grid{
        id:grid
        columns: 3
        rows: 3
        Rectangle{color:"black";width:180;height:80;Text{text: _airspeed;color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:180;height:80;Text{text: _altitude;color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:180;height:80;Text{text: _pitchAngle;color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:180;height:80;Text{text: _rollAngle;color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:180;height:80;Text{text: _throttlePct;color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:180;height:80;Text{text: _flightDistance;color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:180;height:80;Text{text: _altitudeAMSL;color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:180;height:80;Text{text: _groundSpeed;color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
        Rectangle{color:"black";width:180;height:80;Text{text: _yawRate;color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}

        spacing: 5
        Layout.leftMargin: -200

flg t
    }


    TerrainProgress {
        Layout.fillWidth: true
    }

}
