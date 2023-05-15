import QtQuick 2.3
import QtGraphicalEffects   1.0
import QtQuick.Window 2.3
import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Palette       1.0
import QtQuick.Layouts 1.3

Item{
    property real airspeed
    property real size
    property real factor: 649/6480
    property real v_max
    property int aux: Math.round(airspeed)
    property int barrasdim: Math.round(aux/10+3)
    property int index_aux:0


    id:     papychulo
    height: size
    width:  height/4


    Item{
        id: overspeed
        anchors.fill:parent
        visible:false


        Column{
            Repeater{
                model:barrasdim

                Image{
                    id:images
                    height:papychulo.height/12
                    width:papychulo.width/4
                    source:"/qmlimages/resources/Barra-overspeed.svg"
                    mipmap:true
                    transform: Translate{
                        y:-(-airspeed*factor*height+(barrasdim-1.5)*height+v_max*height)
                        x:papychulo.width*3/4
                    }
                }


            }
        }

    }

    Rectangle{
        id:mascara2
        anchors.fill:overspeed
        color:"#00000000"
        visible:true
        radius:width/4
    }

    OpacityMask {
        cached:true
        anchors.fill:overspeed
        source:  overspeed
        maskSource: mascara2
    }

}
