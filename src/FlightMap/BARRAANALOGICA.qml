import QtQuick 2.3
import QtGraphicalEffects           1.0
import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Palette       1.0
import QtQuick.Layouts 1.3
Item {
    property real altitude
    property real size
    property real factor: 649/6480
    property int aux: Math.round(altitude)
    property int barrasdim: Math.round((aux)/10+3)

    id: papychulo
    height:size
    width: height/4

    Item{
        id: barraanalogica
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
                        y:-(-altitude*factor*height+(barrasdim-1.5)*height)
                    }
                }
            }
        }
    }

    Rectangle{
        id:mascara
        anchors.fill:barraanalogica
        color:"black"
        visible:true
        radius:width/4
    }

    OpacityMask {
        cached:true
        anchors.fill:barraanalogica
        source:  barraanalogica
        maskSource: mascara
    }
}
