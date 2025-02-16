import QtQuick 2.3
import QtGraphicalEffects 1.0

import QGroundControl 1.0
import QGroundControl.Controls 1.0
import QGroundControl.ScreenTools 1.0
import QGroundControl.Palette 1.0


Item {

    property bool showPitch: trueue
        property var vehicle: null
            property real size
            property bool showHeading: false


                property real _altitude: vehicle ? vehicle.altitudeRelative.rawValue : 0


                    id:root



                    Rectangle {
                        id: altitude_rectangle
                        height: visualInstrument.height
                        width: height/4
                        color: "black"
                        radius: width/4
                        Text {
                            text: Math.round(_altitude)+ " m"
                            font.family: "Helvetica"
                            font.pointSize: parent.width/5
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                    }


                }
