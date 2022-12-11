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
    

    property bool showPitch:    true
    property var  vehicle:      null
    property real size
    property bool showHeading:  false

    property real _rollAngle:   vehicle ? vehicle.roll.rawValue : 0
    property real _pitchAngle:  vehicle ? vehicle.pitch.rawValue : 0
    property real _airspeed:    vehicle ? vehicle.airSpeed.rawValue : 0



    property real   _innerRadius:           (width - (_topBottomMargin * 3)) / 4
    property real   _outerRadius:           _innerRadius + _topBottomMargin
    property real   _spacing:               ScreenTools.defaultFontPixelHeight * 0.33
    property real   _topBottomMargin:       (width * 0.05) / 2

    QGCPalette { id: qgcPal }

    Rectangle {
        id:                 visualInstrument
        height:             _outerRadius *4*Screen.devicePixelRatio
        width:              height


        radius:             height/4
        color:              qgcPal.window

        //Propriedades para arrrastar
        property bool   allowDragging:  true
        signal          resetRequested()
        property real   maximumWidth: _outerRadius*6*Screen.devicePixelRatio
        property real   minimumWidth: _outerRadius*2*Screen.devicePixelRatio


        //Funções que atuam sobre o quadrado maior onde está inserido o horizonte artificial
        MouseArea {
            property double factor: 25
            enabled:            visualInstrument.allowDragging
            cursorShape:        Qt.OpenHandCursor
            anchors.fill:       parent
            drag.target:        parent
            drag.axis:          Drag.XAndYAxis

            //Scuffed limites
            drag.minimumX:      (-Screen.width+visualInstrument.width)*Screen.devicePixelRatio
            drag.minimumY:      0
            drag.maximumX:      0
            drag.maximumY:      (Screen.height-(visualInstrument.height)*1.5)*Screen.devicePixelRatio
            drag.filterChildren: true

            onPressed: {
                visualInstrument.anchors.left  = undefined
                visualInstrument.anchors.right = undefined
            }

            //reiniciar posição para canto superior direito com o tamanho original
            onDoubleClicked: {
                visualInstrument.resetRequested();
                visualInstrument.x=0;
                visualInstrument.y=0;
                visualInstrument.height=_outerRadius *4*Screen.devicePixelRatio
                visualInstrument.width=visualInstrument.height
            }

            //Zoom com o rato
            onWheel:
            {
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
            size:                       visualInstrument.height
            vehicle:                    globals.activeVehicle
            anchors.verticalCenter:     parent.verticalCenter
        }

    Rectangle {
        id:                 visualInstrument
        height:             _outerRadius *4

        anchors.left:        parent.left
        anchors.bottom:     parent.BottomLeft

        Layout.fillWidth:   true
        radius:             _outerRadius
        color:              qgcPal.window

    Rectangle {
        id:                 visualInstrument
        height:             _outerRadius *4*Screen.devicePixelRatio
        width:              height

        /*anchors.left:        parent.left
        anchors.bottom:     parent.BottomLeft

        Layout.fillWidth:   true
        */

        radius:             height/4
        color:              qgcPal.window

        //Propriedades para arrrastar
        property bool   allowDragging:  true
        signal          resetRequested()
        property real   maximumWidth: _outerRadius*6*Screen.devicePixelRatio
        property real   minimumWidth: _outerRadius*2*Screen.devicePixelRatio


        //Funções que atuam sobre o quadrado maior onde está inserido o horizonte artificial
        MouseArea {
            property double factor: 25
            enabled:            visualInstrument.allowDragging
            cursorShape:        Qt.OpenHandCursor
            anchors.fill:       parent
            drag.target:        parent
            drag.axis:          Drag.XAndYAxis

            //Scuffed limites
            drag.minimumX:      (-Screen.width+visualInstrument.width)*Screen.devicePixelRatio
            drag.minimumY:      0
            drag.maximumX:      0
            drag.maximumY:      (Screen.height-(visualInstrument.height)*1.5)*Screen.devicePixelRatio
            drag.filterChildren: true

            onPressed: {
                visualInstrument.anchors.left  = undefined
                visualInstrument.anchors.right = undefined
            }

            //reiniciar posição para canto superior direito com o tamanho original
            onDoubleClicked: {
                visualInstrument.resetRequested();
                visualInstrument.x=0;
                visualInstrument.y=0;
                visualInstrument.height=_outerRadius *4*Screen.devicePixelRatio
                visualInstrument.width=visualInstrument.height
            }

            //Zoom com o rato
            onWheel:
            {
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
            size:                       visualInstrument.height
            vehicle:                    globals.activeVehicle
            anchors.verticalCenter:     parent.verticalCenter
        }

        QGCCompassWidget {
            id:                     compass
            anchors.leftMargin:     _spacing
            anchors.left :          attitude.right
            size:                   _innerRadius * 4
            vehicle:                globals.activeVehicle
            anchors.verticalCenter: parent.verticalCenter
            visible:                false
        }


    }

    Rectangle{
        id:                 altitude_rectangle
        height:             visualInstrument.height
        width:              height/8


        radius:             _outerRadius
        color:              "black"

        /*
        Text {
            text:  "ola" + _rollAngle
            font.family: "Helvetica"
            font.pointSize: 24
            color: "black"
        }
        */

        anchors.top: parent.top
        anchors.right: QGCAttitudeWidget.left

    }

    /*
    Text {
        text:  "adeus" +_pitchAngle
        font.family: "Helvetica"
        font.pointSize: 24
        color: "black"
    }
    */
    Rectangle{
        id:                 speed_rectangle
        height:             visualInstrument.height
        width:              height/8







        radius:             _outerRadius
        color:              "black"



        anchors.top: parent.top
        anchors.left: QGCAttitudeWidget.right

    }


    TerrainProgress {
        Layout.fillWidth: true
    }

    Text {
        text:  "adeusss" +_pitchAngle
        font.family: "Helvetica"
        font.pointSize: 50
        color: "black"

    }
}
