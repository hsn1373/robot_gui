import QtQuick 2.0
import QtQuick.Controls 2.12
import DefaultSettings 1.0
import QtQuick.Controls.Material 2.12
import "./Style"

Item {

    DefaultSettings
    {
        id:default_settings
    }

    Grid
    {
        width: parent.width
        height: parent.height

        Label
        {
            width: parent.width
            height: parent.height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "<b> Setting Page </b>"
            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
            font.family: UIStyle.fontName
            //font.pixelSize: parent.height - 2
        }
    }

}
