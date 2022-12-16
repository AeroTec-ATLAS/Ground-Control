/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/


/**
 * @file
 *   @brief QGC Attitude Instrument
 *   @author Gus Grubba <gus@auterion.com>
 */

import QtQuick              2.3
import QtGraphicalEffects   1.0

import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Palette       1.0

Item {
    id: root

    property bool showPitch:    true
    property var  vehicle:      null
    property real size
    property bool showHeading:  false

    property real _rollAngle:   vehicle ? vehicle.roll.rawValue  : 0
    property real _pitchAngle:  vehicle ? vehicle.pitch.rawValue : 0
    // property real airspeed:  vehicle ? vehicle.airspeed.rawValue : 0

    width:  size
    height: size



    Item {
        id:             instrument
        anchors.fill:   parent
        //visible:        false

        //----------------------------------------------------
        //-- Artificial Horizon
        QGCArtificialHorizon {
            rollAngle:          _rollAngle
            pitchAngle:         _pitchAngle
            anchors.fill:       parent




        }
        //----------------------------------------------------
        //-- Pointer
        Image {
            id:                 pointer
            source:             "/qmlimages/attitudePointer.svg"
            mipmap:             true
            fillMode:           Image.PreserveAspectFit
            anchors.fill:       parent
            sourceSize.height:  parent.height
        }
        //----------------------------------------------------
        //-- Instrument Dial
        Image {
            id:                 instrumentDial
            source:             "/qmlimages/attitudeDial.svg"
            mipmap:             true
            fillMode:           Image.PreserveAspectFit
            anchors.fill:       parent
            sourceSize.height:  parent.height
            transform: Rotation {
                origin.x:       root.width  / 2
                origin.y:       root.height / 2
                angle:          -_rollAngle
            }
        }

        //----------------------------------------------------
        //-- Pitch
        QGCPitchIndicator {
            id:                 pitchWidget
            visible:            root.showPitch
            size:               root.size * 0.5
            anchors.verticalCenter: parent.verticalCenter
            pitchAngle:         _pitchAngle
            rollAngle:          _rollAngle
            color:              Qt.rgba(0,0,0,0)
        }
        //----------------------------------------------------
        //-- Cross Hair
        Image {
            id:                 crossHair
            anchors.centerIn:   parent
            source:             "/qmlimages/crossHair.svg"
            mipmap:             true
            width:              size * 0.75
            sourceSize.width:   width
            fillMode:           Image.PreserveAspectFit
        }
    }

    Rectangle {
        id:             mask
        anchors.fill:   instrument
        radius:         width / 2
        color:          "black"
        visible:        false
    }

    OpacityMask {
        anchors.fill: instrument
        source: instrument
        maskSource: mask
    }

    Rectangle {
        id:             borderRect
        anchors.fill:   parent
        radius:         width / 2
        color:          Qt.rgba(0,0,0,0)
        border.color:   qgcPal.text
        border.width:   1
        visible:        false
    }

    QGCLabel {
        anchors.bottomMargin:       Math.round(ScreenTools.defaultFontPixelHeight * .75)
        anchors.bottom:             parent.bottom
        anchors.horizontalCenter:   parent.horizontalCenter
        text:                       _headingString3
        color:                      "white"
        visible:                    showHeading

        property string _headingString: vehicle ? vehicle.heading.rawValue.toFixed(0) : "OFF"
        property string _headingString2: _headingString.length === 1 ? "0" + _headingString : _headingString
        property string _headingString3: _headingString2.length === 2 ? "0" + _headingString2 : _headingString2
    }

    function getColor(){
        var color = color
        if(_rollAngle >= 10){
            color = "yellow"
        }
        else{
            color = "black"
        }
        return color
    }


    /*
    Item {

        property real _rollAngle:   vehicle ? vehicle.roll.rawValue : 0
        property real _pitchAngle:  vehicle ? vehicle.pitch.rawValue : 0
        property real _airspeed:    vehicle ? vehicle.airSpeed.rawValue : 0
        property real _altitude:    vehicle ? vehicle.altitudeRelative.rawValue : 0
        property real _throttlePct:    vehicle ? vehicle.throttlePct.rawValue : 0
        property real _flightDistance:    vehicle ? vehicle.flightDistance.rawValue : 0
        property real _altitudeAMSL:    vehicle ? vehicle.altitudeAMSL.rawValue : 0
        property real _groundSpeed:    vehicle ? vehicle.groundSpeed.rawValue : 0
        property real _yawRate:    vehicle ? vehicle.yawRate.rawValue : 0
        id: rootgrid

        Grid{

            id:grid
            columns: 3
            rows: 3
            Rectangle{color:"black";width:180;height:80;Text{text: Math.round(_airspeed);color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
            Rectangle{color:"black";width:180;height:80;Text{text: Math.round(_altitude);color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
            Rectangle{color:"black";width:180;height:80;Text{text: Math.round(_pitchAngle);color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
            Rectangle{color:"black";width:180;height:80;Text{text: Math.round(_rollAngle);color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
            Rectangle{color:"black";width:180;height:80;Text{text: Math.round(_rollAngle);color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
            Rectangle{color:"black";width:180;height:80;Text{text: Math.round(_flightDistance);color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
            Rectangle{color:"black";width:180;height:80;Text{text: Math.round(_altitudeAMSL);color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
            Rectangle{color:"black";width:180;height:80;Text{text: Math.round(_groundSpeed);color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}
            Rectangle{color:"black";width:180;height:80;Text{text: Math.round(_yawRate);color:"white";font.pointSize: 24;anchors.horizontalCenter: parent.horizontalCenter;anchors.verticalCenter: parent.verticalCenter}}

            spacing: 5



        }
    }
    */

}

