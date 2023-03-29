import QtQuick 2.3
import QtGraphicalEffects   1.0
import QtQuick.Window 2.3
import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Palette       1.0
import QtQuick.Layouts 1.3



Item {
    property real airspeed
    property real size
    property real factor: 649/6480

    property int aux: Math.round(airspeed)
    property int barrasdim: Math.round(aux/10+3)
    property int index_aux:0


    id:     papychulo
    height: size
    width:  height/4



    Item{
        id: barraspeed
        anchors.fill:parent
        visible:false


        Column{
            Repeater{
                model:barrasdim

                Image{
                    height:papychulo.height/3
                    width:papychulo.width
                    source:"/qmlimages/BARRA_2.svg"
                    mipmap:true
                    transform: Translate{
                        y:-(-airspeed*factor*height+(barrasdim-1.5)*height)
                    }
                }
            }
        }

    }

    Rectangle{
        id:mascara
        anchors.fill:barraspeed
        color:"black"
        visible:true
        radius:width/4
    }

    OpacityMask {
        cached:true
        anchors.fill:barraspeed
        source:  barraspeed
        maskSource: mascara
    }

}
