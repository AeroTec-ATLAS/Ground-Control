
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
import QtQuick.Window               2.2

import QtQuick.Controls 1.2


Column{
    property bool showPitch:    true
    property var  vehicle:      null
    property real size
    property bool showHeading:  false


    property real   _outerRadius:           Screen.width/30
    property real   _spacing:               ScreenTools.defaultFontPixelHeight * 0.33

    spacing:_spacing

    Row{
        id:     root
        spacing:_spacing
        transform:Translate{
            x:-_outerRadius*8-4*_spacing
        }

        Speed_Rectangle{
            id: i_Am_speed
            vehicle: globals.activeVehicle
            size: _outerRadius*8


            DeadMouseArea{
                anchors.fill:parent
            }
        }

        Rectangle {
            id:visualInstrument
            height: _outerRadius*8
            width:height
            color:'transparent'

            DeadMouseArea{
                anchors.fill:parent
            }

            QGCAttitudeWidget {
                id:                     attitude
                anchors.horizontalCenter:   parent.horizontalCenter
                anchors.topMargin:          _spacing
                anchors.top:                parent.top
                anchors.left:               parent.left
                size:                   visualInstrument.height
                vehicle:                globals.activeVehicle
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Alttitude_and_speed_rectangles{
            id: rectangle2
            vehicle: globals.activeVehicle
            size: _outerRadius*8
            DeadMouseArea{
                anchors.fill:parent
            }
        }


    }

    NewwGrid{
        id: new_grid
        vehicle: globals.activeVehicle
        size:_outerRadius*8
        transform: Translate{
            x:-_outerRadius*6-3*_spacing
            y:_outerRadius*8+_spacing
        }

        DeadMouseArea{
            anchors.fill:parent
        }
    }

    TerrainProgress {
        Layout.fillWidth: true
    }
}
