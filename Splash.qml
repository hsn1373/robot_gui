import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "./Style"



Item{
    id: splash
    visible: true
    width: 640
    height: 480
    signal timeout

    Rectangle
    {
        id: background
        anchors.fill: parent
        color: UIStyle.shapeColor3
    }

    Grid
    {
        id:mainGrid
        width: parent.width
        height: parent.height
        rows: 3


        Label
        {
            width: parent.width
            height: parent.height * 1/6
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "<b> ARON AUTO LAB </b>"
            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
            font.family: UIStyle.fontName
            font.pixelSize: UIStyle.fontSize_VeryBig
        }

        Row
        {
            width: parent.width
            height: parent.height * 4/6

            Rectangle
            {
                width: parent.width * 1/4
                height: parent.height
                color: "transparent"
            }

            Image {
                id: image
                source: "qrc:/Images/5.jpg"
                width: parent.width * 1/2
                height: parent.height
            }

            Rectangle
            {
                width: parent.width * 1/4
                height: parent.height
                color: "transparent"
            }
        }

        Rectangle
        {
            width: parent.width
            height: parent.height * 1/6
            color: UIStyle.shapeColor3
            ProgressBar
            {
                id: mainProgressBar
                height: 7
                width: parent.width * 1/2
                anchors.centerIn: parent
                from:0
                to:60
                value: 0

                background: Rectangle {
                    anchors.left: mainProgressBar.left
                    anchors.verticalCenter: mainProgressBar.verticalCenter
                    implicitWidth: 50
                    implicitHeight: 6
                    color: UIStyle.colorWhite
                    radius: 3
                }

                contentItem: Rectangle {
                    anchors.left: mainProgressBar.left
                    anchors.verticalCenter: mainProgressBar.verticalCenter
                    width: mainProgressBar.visualPosition * mainProgressBar.width
                    height: mainProgressBar.height
                    radius: 2
                    color: UIStyle.themeBlue
                }

            }
        }
    }

    Timer {
        interval: 3000; running: true; repeat: false
        onTriggered: {
            visible = false
            splash.timeout()
        }
    }

    Timer
    {
        interval: 50; running: true; repeat: true
        onTriggered:
        {
            mainProgressBar.value +=1
        }
    }

    Component.onCompleted:
    {
        visible = true
        setX(window.width / 2 - width / 2);
        setY(window.height / 2 - height / 2);
    }
}
