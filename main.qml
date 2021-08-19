import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Window 2.12
import QtQuick.Shapes 1.12
import "./Style"
import Qt.labs.settings 1.0

Window {
    id:window
    visible: true
    width: 640
    height: 480
    title: qsTr("ROBOT GUI")
    visibility: "Maximized"

    Settings {
        id: settings
        property bool darkTheme
    }

    Binding {
        target: UIStyle
        property: "darkTheme"
        value: settings.darkTheme
    }

    Shape {
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        ShapePath {
            fillGradient: LinearGradient {
                x1: 0; y1: 0
                x2: window.width; y2: window.height
                GradientStop { position: 1; color: UIStyle.shapeColor3 }
            }
            PathArc {
                x: 0 ; y: window.height
                radiusX: window.width ; radiusY: window.height
                useLargeArc: true
            }
        }
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
            width: parent.width * 2/10
            height: parent.height - 10
            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

            Grid
            {
                columns: 1
                width: parent.width
                height: parent.height
                Button
                {
                    id: btnHome
                    width: parent.width
                    height: parent.height * 1/10
                    text: "Home"
                    highlighted: UIStyle.darkTheme
                    background:  Rectangle {
                        radius: 9
                        color: UIStyle.themeBlue
                    }
                    onClicked:
                    {
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
                    }
                    onHoveredChanged: btnChangeTheme.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                }
            }
        }

        //*********************************************************************************
        //*********************************************************************************
        // right side
        Frame
        {
            width: parent.width * 8/10 - 15
            height: parent.height - 10
            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

            Grid
            {
                width: parent.width
                height: parent.height
                columns: 1
                spacing: 5

                StackView {
                    width: parent.width * 17/20
                    height: parent.height
                    id: mainStackView
                    initialItem: "homePage.qml"
                }
            }
        }

    }
}
