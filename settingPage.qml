import QtQuick 2.0
import QtQuick.Controls 2.2
import DefaultSettings 1.0
import QtQuick.Controls.Material 2.2
import SerialPort 1.0
import "./Style"

Item {

    readonly property string _select_device_str: "Select Device..."

    DefaultSettings
    {
        id:default_settings
    }

    SerialPort {
        id: serialPort
    }

    Grid
    {
        width: parent.width
        height: parent.height
        rows: 4

        Label
        {
            width: parent.width
            height: parent.height * 1/8
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "<b> Setting Page </b>"
            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
            font.family: UIStyle.fontName
            //font.pixelSize: parent.height - 2
        }

        ComboBox
        {
            id: deviceComboBox
            width: parent.width
            height: parent.height * 1/8
            Material.accent: Material.primary
            Material.theme: Material.Light
            font.pointSize:UIStyle.fontSize
            font.family:UIStyle.fontName
            background: Rectangle{
                width: parent.width
                height: parent.height
                color: UIStyle.comboBackground
                border.width: 0.5
                border.color: UIStyle.borderGrey
            }

            displayText: _select_device_str
            model: serialPort.serial_ports_list
            onActivated: {
                this.displayText = this.currentText
            }
        }

        Button
        {
            id: btnCloseOpenDoor
            width: parent.width * 1/5
            height: parent.height * 1/8
            text: "Open/Close Door"
            highlighted: UIStyle.darkTheme
            background:  Rectangle {
                radius: 9
                color: UIStyle.themeBlue
            }
            onClicked:
            {
                serialPort.close_open_door(true)
            }
            onHoveredChanged: btnCloseOpenDoor.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
        }
    }

}
