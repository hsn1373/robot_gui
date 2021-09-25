import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Window 2.2
import "./Style"
import Qt.labs.settings 1.0

Window {
    id:window
    visible: true
    width: 640
    height: 480
    title: qsTr("ROBOT GUI")
    visibility: "Maximized"
    Rectangle
    {
        id: background
        anchors.fill: parent
        color: UIStyle.shapeColor3
    }

    Settings {
        id: settings
        property bool darkTheme
    }

    Binding {
        target: UIStyle
        property: "darkTheme"
        value: settings.darkTheme
    }

    Grid
    {
        width: parent.width
        height: parent.height
        padding: 5
        spacing: 3
        columns: 2

        //*********************************************************************************
        //*********************************************************************************
        // left side _ main buttons
        Frame
        {
            width: parent.width * 1/10
            height: parent.height - 10
            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

            Grid
            {
                columns: 1
                width: parent.width
                height: parent.height
                spacing: 3
                Button
                {
                    id: btnHome
                    width: parent.width
                    height: parent.height * 1/10
                    text: "Home"
                    enabled: false
                    highlighted: UIStyle.darkTheme
                    background:  Rectangle {
                        radius: 9
                        color: UIStyle.themeBlue
                    }
                    onClicked:
                    {
                        btnHome.enabled = false
                        btnSetting.enabled = true
                        mainStackView.pop()
                        mainStackView.push("homePage.qml")
                    }
                    onHoveredChanged: btnHome.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                }

                Button
                {
                    id: btnSetting
                    width: parent.width
                    height: parent.height * 1/10
                    text: "Setting"
                    highlighted: UIStyle.darkTheme
                    background:  Rectangle {
                        radius: 9
                        color: UIStyle.themeBlue
                    }
                    onClicked:
                    {
                        btnHome.enabled = true
                        btnSetting.enabled = false
                        mainStackView.pop()
                        mainStackView.push("settingPage.qml")
                    }
                    onHoveredChanged: btnSetting.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                }

                Button
                {
                    id: btnChangeTheme
                    width: parent.width
                    height: parent.height * 1/10
                    text: "Change Theme"
                    highlighted: UIStyle.darkTheme
                    background:  Rectangle {
                        radius: 9
                        color: UIStyle.themeBlue
                    }
                    onClicked:
                    {
                        UIStyle.darkTheme = !UIStyle.darkTheme
                        btnHome.background.color = UIStyle.themeBlue
                        btnSetting.background.color = UIStyle.themeBlue
                        btnCloseOpenDoor.background.color = UIStyle.themeBlue
                    }
                    onHoveredChanged: btnChangeTheme.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                }

                Rectangle
                {
                    width: parent.width
                    height: parent.height * 5/10
                    color: "transparent"
                }

                Button
                {
                    id: btnCloseOpenDoor
                    width: parent.width
                    height: parent.height * 1/10
                    text: "exit"
                    highlighted: UIStyle.darkTheme
                    background:  Rectangle {
                        radius: 9
                        color: UIStyle.themeBlue
                    }
                    onClicked:
                    {
                        Qt.callLater(Qt.quit)
                    }
                    onHoveredChanged: btnCloseOpenDoor.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                }

            }
        }

        //*********************************************************************************
        //*********************************************************************************
        // right side
        Frame
        {
            width: parent.width * 9/10 - 15
            height: parent.height - 10
            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

            Grid
            {
                width: parent.width
                height: parent.height
                columns: 1
                spacing: 5

                StackView {
                    width: parent.width
                    height: parent.height
                    id: mainStackView
                    initialItem: "homePage.qml"
                }
            }
        }

    }
}
