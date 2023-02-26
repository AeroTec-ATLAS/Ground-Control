import QtQuick 2.3
import QtGraphicalEffects   1.0

import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Palette       1.0


Item {
    property real altitude
    property real size
    property real factor: 649/6480


    id: papychulo
    height:size
    width: height/4

    Item{
        id: barraanalogica
        anchors.fill:parent
        visible:false
        Column{

            Repeater{
                model:15
                Image{
                    id:imagem
                    width:papychulo.width
                    height:papychulo.height/3
                    source:"/qmlimages/BARRA_2.svg"
                    mipmap:true
                    transform:Translate{y: -altitude*height*factor+1.5*height}
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

