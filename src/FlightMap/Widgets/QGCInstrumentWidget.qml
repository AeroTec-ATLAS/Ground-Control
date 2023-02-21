

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
import QtQuick.Window               2.0

import QtQuick.Controls 1.2


ColumnLayout {
    id:         root
    spacing:    ScreenTools.defaultFontPixelHeight /4

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
        height:             _outerRadius * 11*Screen.devicePixelRatio
        width:              height

        radius:             _outerRadius/4
        color:              qgcPal.window


        //Propriedades para arrrastar
        property bool   allowDragging:  true
        signal          resetRequested()
        property real   maximumWidth: _outerRadius*22*Screen.devicePixelRatio
        property real   minimumWidth: _outerRadius*4*Screen.devicePixelRatio

       
        ////Funções para arrastar -MB
        MouseArea {
            property double factor: 25
            enabled:            visualInstrument.allowDragging
            cursorShape:        Qt.OpenHandCursor
            anchors.fill:       parent
            drag.target:        parent
            drag.axis:          Drag.XAndYAxis

            //Scuffed limites não aplicados de momento pois as funçoes de limites de ecrã não são boas
            //drag.minimumX:      -Screen.width
            //drag.minimumY:      0
            //drag.maximumX:      0
            //drag.maximumY:      +Screen.height

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

            //zoom com rato
            onWheel:{

            var zoomFactor = _outerRadius/4;

            if(wheel.angleDelta.y > 0){
                if (visualInstrument.height<visualInstrument.maximumWidth){
                    visualInstrument.height+=zoomFactor
                    visualInstrument.width=visualInstrument.height
                }
              }
            else if (wheel.angleDelta.y<0)
                if(visualInstrument.height>visualInstrument.minimumWidth){
                    visualInstrument.height += -zoomFactor
                    visualInstrument.width =visualInstrument.height
                }
            }
        }

        QGCAttitudeWidget {
            id:                     attitude

            anchors.horizontalCenter:   parent.horizontalCenter
            anchors.topMargin:          _spacing
            anchors.top:                parent.top
            anchors.left:               parent.left

            size:                   visualInstrument.width
            vehicle:                globals.activeVehicle
            anchors.verticalCenter: parent.verticalCenter
        }
        


        NewwGrid{
            id: new_grid
            vehicle: globals.activeVehicle
            anchors.top: visualInstrument.bottom
            anchors.topMargin: _spacing
            anchors.centerIn: visualInstrument.Center
        }

        Speed_rectangle{
            id: i_Am_speed
            vehicle:        globals.activeVehicle
            anchors.top:    parent.top
            anchors.right:   new_grid.left
            anchors.rightMargin: visualInstrument.width/4
        }



        Alttitude_and_speed_rectangles{
            id: rectangle2
            vehicle: globals.activeVehicle
            
            anchors.top:  visualInstrument.top
            anchors.left:visualInstrument.right        
        }


    }

    TerrainProgress {
        Layout.fillWidth: true
    }

}
