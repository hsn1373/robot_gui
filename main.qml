import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Window 2.2
import SerialPort 1.0
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

    SerialPort {
        id: serialPort

        onPortOpenSignal:
        {
            lbl_status.text = "<b> Port Is Opened. </b>";
            lbl_status.color = UIStyle.portSatusLabelColorOpened
            btnOpenPort.enabled = false
            btnClosePort.enabled = true
        }
        onPortNotOpenSignal:
        {
            lbl_status.text = "<b> Error In Openning Port ! Port Is Closed </b>";
            lbl_status.color = UIStyle.portSatusLabelColorClosed
            btnOpenPort.enabled = true
            btnClosePort.enabled = false
        }
        onDataSent:
        {
            lbl_status.text = "<b> G-code is sent ! </b>";
        }
    }


    //*********************************************************
    //*********************************************************
    // main menu

    Grid
    {
        id: main_grid
        width: parent.width
        height: parent.height
        padding: 5
        spacing: 6
        rows: 4

        Rectangle
        {
            width: parent.width
            height: parent.height * 1/4
            color: "transparent"
        }

        Row
        {
            width: parent.width - 6
            height: parent.height * 1/5
            spacing: 6

            Button
            {
                id: btnSetMovesPage
                width: parent.width * 1/3 - 6
                height: parent.height
                text: "Set Moves"
                highlighted: UIStyle.darkTheme
                font.pixelSize: UIStyle.fontSize_Big
                //icon.name: "edit-cut"
                //icon.source: "images/cut.png"
                background:  Rectangle {
                    radius: 5
                    color: UIStyle.themeBlue
                }
                onClicked:
                {
                    main_grid.visible=false
                    setMoves_grid.visible=true
                }
                onHoveredChanged: btnSetMovesPage.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            }

            Button
            {
                id: btnManualMovementPage
                width: parent.width * 1/3 - 6
                height: parent.height
                text: "Manual Move"
                highlighted: UIStyle.darkTheme
                font.pixelSize: UIStyle.fontSize_Big
                background:  Rectangle {
                    radius: 5
                    color: UIStyle.themeBlue
                }
                onClicked:
                {
                    serialPort.set_moves_relative()
                    main_grid.visible=false
                    manulaMovement_grid.visible=true
                }
                onHoveredChanged: btnManualMovementPage.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            }

            Button
            {
                id: btnSettingsPage
                width: parent.width * 1/3 - 6
                height: parent.height
                text: "Settings"
                highlighted: UIStyle.darkTheme
                font.pixelSize: UIStyle.fontSize_Big
                background:  Rectangle {
                    radius: 5
                    color: UIStyle.themeBlue
                }
                onClicked:
                {
                    main_grid.visible=false
                    settings_grid.visible=true
                }
                onHoveredChanged: btnSettingsPage.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            }


        }

        Row
        {
            width: parent.width - 6
            height: parent.height * 1/5
            spacing: 6

            Button
            {
                id: btnTemperaturePage
                width: parent.width * 1/3 - 6
                height: parent.height
                text: "Temperature"
                highlighted: UIStyle.darkTheme
                font.pixelSize: UIStyle.fontSize_Big
                background:  Rectangle {
                    radius: 5
                    color: UIStyle.themeBlue
                }
                onClicked:
                {
                    main_grid.visible=false
                    temperature_grid.visible=true
                }
                onHoveredChanged: btnTemperaturePage.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            }

            Button
            {
                id: btnWashReaderPage
                width: parent.width * 1/3 - 6
                height: parent.height
                text: "Wash Reader"
                highlighted: UIStyle.darkTheme
                font.pixelSize: UIStyle.fontSize_Big
                background:  Rectangle {
                    radius: 5
                    color: UIStyle.themeBlue
                }
                onClicked:
                {
                    main_grid.visible=false
                    washReader_grid.visible=true
                }
                onHoveredChanged: btnWashReaderPage.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            }

            Button
            {
                id: btnOpenCloseDoor
                width: parent.width * 1/3 - 6
                height: parent.height
                text: "Open/Close Door"
                highlighted: UIStyle.darkTheme
                font.pixelSize: UIStyle.fontSize_Big
                background:  Rectangle {
                    radius: 5
                    color: UIStyle.themeBlue
                }
                onClicked:
                {

                }
                onHoveredChanged: btnOpenCloseDoor.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            }

        }

        Row
        {
            width: parent.width - 6
            height: parent.height * 1/5
            spacing: 6

            Button
            {
                id: btnInOutWorkSpace
                width: parent.width * 1/3 - 6
                height: parent.height
                text: "In/Out Workspace"
                highlighted: UIStyle.darkTheme
                font.pixelSize: UIStyle.fontSize_Big
                background:  Rectangle {
                    radius: 5
                    color: UIStyle.themeBlue
                }
                onClicked:
                {

                }
                onHoveredChanged: btnInOutWorkSpace.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            }

            Button
            {
                id: btnExit
                width: parent.width * 1/3 - 6
                height: parent.height
                text: "exit"
                highlighted: UIStyle.darkTheme
                font.pixelSize: UIStyle.fontSize_Big
                background:  Rectangle {
                    radius: 5
                    color: UIStyle.themeBlue
                }
                onClicked:
                {
                    Qt.callLater(Qt.quit)
                }
                onHoveredChanged: btnExit.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            }

            Rectangle
            {
                width: parent.width * 1/3 - 6
                height: parent.height
                color: "transparent"
            }
        }


    }

    //*********************************************************
    //*********************************************************
    // set moves grid

    Grid
    {
        id: setMoves_grid
        width: parent.width
        height: parent.height
        spacing: 10
        rows: 3
        visible: false

        Button
        {
            id: btnSetMovesBack
            width: parent.width
            height: parent.height * 2/20
            text: "Back"
            highlighted: UIStyle.darkTheme
            background:  Rectangle {
                radius: 9
                color: UIStyle.themeBlue
            }
            onClicked:
            {
                main_grid.visible=true
                setMoves_grid.visible=false
            }
            onHoveredChanged: btnSetMovesBack.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
        }

        Row
        {
            width: parent.width
            height: parent.height * 17/20

            Rectangle
            {
                width: parent.width * 1/12
                height: parent.height
                color: "transparent"
            }

            //************************************
            // Left Column
            Column
            {
                width: parent.width * 1/6
                height: parent.height

                // Tip Type 1
                Frame
                {
                    width: parent.width
                    height: parent.height * 1/3
                    Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                    Label
                    {
                        width: parent.width
                        height: parent.height
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Tip Type 1 </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                    }
                }

                Row
                {
                    width: parent.width
                    height: parent.height * 2/3

                    // source 2 frame
                    Frame
                    {
                        width: parent.width * 1/2
                        height: parent.height
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                        Column
                        {
                            width: parent.width
                            height: parent.height

                            Row
                            {
                                width: parent.width
                                height: parent.height * 4/9

                                Column
                                {
                                    width: parent.width * 1/2
                                    height: parent.height
                                    Rectangle
                                    {
                                        id: source2_kit1_dot
                                        width: parent.width
                                        height: parent.height * 1/4
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                    Rectangle
                                    {
                                        id: source2_kit3_dot
                                        width: parent.width
                                        height: parent.height * 1/4
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                    Rectangle
                                    {
                                        id: source2_kit5_dot
                                        width: parent.width
                                        height: parent.height * 1/4
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                    Rectangle
                                    {
                                        id: source2_kit7_dot
                                        width: parent.width
                                        height: parent.height * 1/4
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                }
                                Column
                                {
                                    width: parent.width * 1/2
                                    height: parent.height
                                    Rectangle
                                    {
                                        id: source2_kit2_dot
                                        width: parent.width
                                        height: parent.height * 1/4
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                    Rectangle
                                    {
                                        id: source2_kit4_dot
                                        width: parent.width
                                        height: parent.height * 1/4
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                    Rectangle
                                    {
                                        id: source2_kit6_dot
                                        width: parent.width
                                        height: parent.height * 1/4
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                    Rectangle
                                    {
                                        id: source2_kit8_dot
                                        width: parent.width
                                        height: parent.height * 1/4
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                }
                            }

                            Row
                            {
                                width: parent.width
                                height: parent.height * 5/9
                                Rectangle
                                {
                                    width: parent.width * 1/4
                                    height: parent.height
                                    color: "transparent"
                                }
                                Column
                                {
                                    width: parent.width * 1/2
                                    height: parent.height
                                    Rectangle
                                    {
                                        id: source2_kit9_dot
                                        width: parent.width
                                        height: parent.height * 1/5
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                    Rectangle
                                    {
                                        id: source2_kit10_dot
                                        width: parent.width
                                        height: parent.height * 1/5
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                    Rectangle
                                    {
                                        id: source2_kit11_dot
                                        width: parent.width
                                        height: parent.height * 1/5
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                    Rectangle
                                    {
                                        id: source2_kit12_dot
                                        width: parent.width
                                        height: parent.height * 1/5
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                    Rectangle
                                    {
                                        id: source2_kit13_dot
                                        width: parent.width
                                        height: parent.height * 1/5
                                        color: UIStyle.shapeColor1
                                        border.color: UIStyle.shapeColor3
                                        border.width: 1
                                        radius: width*0.5
                                    }
                                }

                                Rectangle
                                {
                                    width: parent.width * 1/4
                                    height: parent.height
                                    color: "transparent"
                                }
                            }


                        }
                    }

                    Column
                    {
                        width: parent.width * 1/2
                        height: parent.height

                        // Tip Type 2
                        Frame
                        {
                            width: parent.width
                            height: parent.height * 1/2
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                            Label
                            {
                                width: parent.width
                                height: parent.height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "<b> Tip Type 2 </b>"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                        }

                        // Tip Type 3
                        Frame
                        {
                            width: parent.width
                            height: parent.height * 1/2
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                            Label
                            {
                                width: parent.width
                                height: parent.height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "<b> Tip Type 3 </b>"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                        }

                    }
                }

            }
            //************************************
            // Right Column
            Column
            {
                width: parent.width * 3/6
                height: parent.height

                // source 1 frame
                Frame
                {
                    width: parent.width * 7/8
                    height: parent.height * 8/15
                    Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                    Row
                    {
                        width: parent.width
                        height: parent.height

                        Column
                        {
                            width: parent.width * 2/12
                            height: parent.height
                            Rectangle
                            {
                                width: parent.width
                                height: parent.height * 4/9
                                color: "transparent"
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "<b>Source1</b>"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Rectangle
                            {
                                width: parent.width
                                height: parent.height * 4/9
                                color: "transparent"
                            }
                        }

                        Column
                        {
                            width: parent.width * 1/12
                            height: parent.height
                            Rectangle
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                color: "transparent"
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "1"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "2"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "3"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "4"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "5"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "6"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "7"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "8"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "9"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "10"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "11"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/13
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "12"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                        }

                        Column
                        {
                            width: parent.width * 7/12
                            height: parent.height

                            Grid
                            {
                                id: source_dots_grid
                                width: parent.width
                                height: parent.height
                                rows: 13

                                Row
                                {
                                    width: parent.width
                                    height: parent.height * 1/13
                                    Label
                                    {
                                        width: parent.width * 1/8
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "A"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/8
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "B"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/8
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "C"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/8
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "D"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/8
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "E"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/8
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "F"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/8
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "G"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/8
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "H"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                }

                                Repeater
                                {
                                    model: 12
                                    Row
                                    {
                                        width: parent.width
                                        height: parent.height * 1/13
                                        Repeater
                                        {
                                            model: 8
                                            Rectangle
                                            {
                                                width: parent.width * 1/8
                                                height: parent.height
                                                color: UIStyle.shapeColor1
                                                border.color: UIStyle.shapeColor3
                                                border.width: 1
                                                radius: width*0.5
                                            }
                                        }
                                    }
                                }
                            }

                        }

                        Rectangle
                        {
                            width: parent.width * 2/12
                            height: parent.height
                            color: "transparent"
                        }
                    }


                }

                // discharge place
                Frame
                {
                    width: parent.width * 7/8
                    height: parent.height * 1/15
                    Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                    Label
                    {
                        width: parent.width
                        height: parent.height
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Discharge Place </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                    }
                }

                // target frame
                Frame
                {
                    width: parent.width
                    height: parent.height * 6/15
                    Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                    Row
                    {
                        width: parent.width
                        height: parent.height

                        Column
                        {
                            width: parent.width * 2/12
                            height: parent.height
                            Rectangle
                            {
                                width: parent.width
                                height: parent.height * 4/9
                                color: "transparent"
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "<b>Target</b>"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Rectangle
                            {
                                width: parent.width
                                height: parent.height * 4/9
                                color: "transparent"
                            }
                        }

                        Column
                        {
                            width: parent.width * 1/12
                            height: parent.height
                            Rectangle
                            {
                                width: parent.width
                                height: parent.height * 1/9
                                color: "transparent"
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "A"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "B"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "C"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "D"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "E"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "F"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "G"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                            Label
                            {
                                width: parent.width
                                height: parent.height * 1/9
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: "H"
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.family: UIStyle.fontName
                            }
                        }

                        Column
                        {
                            width: parent.width * 7/12
                            height: parent.height

                            Grid
                            {
                                id: target_dots_grid
                                width: parent.width
                                height: parent.height
                                rows: 9

                                Row
                                {
                                    width: parent.width
                                    height: parent.height * 1/9
                                    Label
                                    {
                                        width: parent.width * 1/12
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "1"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/12
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "2"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/12
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "3"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/12
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "4"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/12
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "5"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/12
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "6"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/12
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "7"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/12
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "8"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/12
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "9"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/12
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "10"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/12
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "11"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                    Label
                                    {
                                        width: parent.width * 1/12
                                        height: parent.height
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        text: "12"
                                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                        font.family: UIStyle.fontName
                                    }
                                }

                                Repeater
                                {
                                    model: 8
                                    Row
                                    {
                                        width: parent.width
                                        height: parent.height * 1/9
                                        Repeater
                                        {
                                            model: 12
                                            Rectangle
                                            {
                                                width: parent.width * 1/12
                                                height: parent.height
                                                color: UIStyle.shapeColor1
                                                border.color: UIStyle.shapeColor3
                                                border.width: 1
                                                radius: width*0.5
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Rectangle
                        {
                            width: parent.width * 2/12
                            height: parent.height
                            color: "transparent"
                        }
                    }
                }

            }

            //************************************
            // add new move & clear & start button Column
            Column
            {
                width: parent.width * 2/8
                height: parent.height

                Rectangle
                {
                    width: parent.width
                    height: parent.height * 1/4
                    color: "transparent"
                }

                Row
                {
                    width: parent.width
                    height: parent.height * 1/10
                    Rectangle
                    {
                        width: parent.width * 1/8
                        height: parent.height
                        color: "transparent"
                    }
                    Button
                    {
                        id: btnSetMovesAddNewMove
                        width: parent.width * 6/8
                        height: parent.height
                        text: "Add New Move"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            setMoves_grid.visible=false
                            addNewMove_grid.visible=true
                        }
                        onHoveredChanged: btnSetMovesAddNewMove.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Rectangle
                    {
                        width: parent.width * 1/8
                        height: parent.height
                        color: "transparent"
                    }
                }

                Rectangle
                {
                    width: parent.width
                    height: parent.height * 1/10
                    color: "transparent"
                }

                Row
                {
                    width: parent.width
                    height: parent.height * 1/10
                    Rectangle
                    {
                        width: parent.width * 1/8
                        height: parent.height
                        color: "transparent"
                    }
                    Button
                    {
                        id: btnSetMovesClearMoves
                        width: parent.width * 6/8
                        height: parent.height
                        text: "Clear"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.clear_moves()
                            //********************************************************************
                            // change dots colors of source
                            var SourceRowObjects=[]
                            for(var i=1;i<13;i++)
                                SourceRowObjects.push(source_dots_grid.children[i])

                            for(var j=0;j<12;j++)
                                for(var k=0;k<8;k++)
                                    SourceRowObjects[j].children[k].color= UIStyle.shapeColor1

                            var Source2KitsObjs=[source2_kit1_dot,source2_kit2_dot,source2_kit3_dot,
                                                source2_kit4_dot,source2_kit5_dot,source2_kit6_dot,
                                                source2_kit7_dot,source2_kit8_dot,source2_kit9_dot,
                                                source2_kit10_dot,source2_kit11_dot,source2_kit12_dot,
                                                source2_kit13_dot]
                            // source type2
                            for(i=0;i<13;i++)
                                Source2KitsObjs[i].color= UIStyle.shapeColor1

                            //********************************************************************

                            //********************************************************************
                            // change dots colors of target
                            var TargetRowObjects=[]
                            for(i=1;i<9;i++)
                                TargetRowObjects.push(target_dots_grid.children[i])

                            for(j=0;j<8;j++)
                                for(k=0;k<12;k++)
                                    TargetRowObjects[j].children[k].color= UIStyle.shapeColor1

                            //********************************************************************
                        }
                        onHoveredChanged: btnSetMovesClearMoves.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Rectangle
                    {
                        width: parent.width * 1/8
                        height: parent.height
                        color: "transparent"
                    }
                }

                Rectangle
                {
                    width: parent.width
                    height: parent.height * 1/10
                    color: "transparent"
                }

                Row
                {
                    width: parent.width
                    height: parent.height * 1/10
                    Rectangle
                    {
                        width: parent.width * 1/8
                        height: parent.height
                        color: "transparent"
                    }
                    Button
                    {
                        id: btnSetMovesStartMove
                        width: parent.width * 6/8
                        height: parent.height
                        text: "Start"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.start_algorithm()
                        }
                        onHoveredChanged: btnSetMovesStartMove.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Rectangle
                    {
                        width: parent.width * 1/8
                        height: parent.height
                        color: "transparent"
                    }
                }

                Rectangle
                {
                    width: parent.width
                    height: parent.height * 1/10
                    color: "transparent"
                }

                Row
                {
                    width: parent.width
                    height: parent.height * 1/10
                    Rectangle
                    {
                        width: parent.width * 1/8
                        height: parent.height
                        color: "transparent"
                    }
                    Button
                    {
                        id: btnSetMovesRunOneStep
                        width: parent.width * 6/8
                        height: parent.height
                        text: "Next Step"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.run_next_step()
                        }
                        onHoveredChanged: btnSetMovesRunOneStep.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Rectangle
                    {
                        width: parent.width * 1/8
                        height: parent.height
                        color: "transparent"
                    }
                }
            }
        }


        Rectangle
        {
            width: parent.width
            height: parent.height * 1/20
            color: "transparent"
        }
    }


    //*********************************************************
    //*********************************************************
    // Manual Movement grid

    Grid
    {
        id: manulaMovement_grid
        width: parent.width
        height: parent.height
        spacing: 10
        rows: 6
        visible: false

        Button
        {
            id: btnManulaMovementBack
            width: parent.width
            height: parent.height * 1/10
            text: "Back"
            highlighted: UIStyle.darkTheme
            background:  Rectangle {
                radius: 9
                color: UIStyle.themeBlue
            }
            onClicked:
            {
                serialPort.set_moves_absolut()
                main_grid.visible=true
                manulaMovement_grid.visible=false
            }
            onHoveredChanged: btnManulaMovementBack.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
        }

        Row
        {
            width: parent.width
            height: parent.height * 8/10

            Rectangle
            {
                width: parent.width * 1/14
                height: parent.height
                color: "transparent"
            }

            //********************************
            // X - Y
            Column
            {
                width: parent.width * 6/14
                height: parent.height

                // first row
                Row
                {
                    width: parent.width
                    height: parent.height * 1/7

                    Button
                    {
                        id: btnManulaMovement_Y_Home
                        width: parent.width * 1/7
                        height: parent.height
                        text: "Home Y"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.home_axis(2)
                        }
                        onHoveredChanged: btnManulaMovement_Y_Home.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }

                    Rectangle
                    {
                        width: parent.width * 1/7
                        height: parent.height
                        color: "transparent"
                    }

                    Label
                    {
                        width: parent.width * 1/7
                        height: parent.height
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Y+ </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                        font.pixelSize: UIStyle.fontSize_Big
                    }

                    Button
                    {
                        id: btnManulaMovement_Yp100
                        width: parent.width * 1/7
                        height: parent.height
                        text: "100"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.y_relative_move(100.0)
                        }
                        onHoveredChanged: btnManulaMovement_Yp100.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }

                    Rectangle
                    {
                        width: parent.width * 2/7
                        height: parent.height
                        color: "transparent"
                    }
                    Button
                    {
                        id: btnManulaMovement_X_Home
                        width: parent.width * 1/7
                        height: parent.height
                        text: "Home X"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.home_axis(1)
                        }
                        onHoveredChanged: btnManulaMovement_X_Home.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                }
                // second row
                Row
                {
                    width: parent.width
                    height: parent.height * 1/7

                    Rectangle
                    {
                        width: parent.width * 3/7
                        height: parent.height
                        color: "transparent"
                    }

                    Button
                    {
                        id: btnManulaMovement_Yp10
                        width: parent.width * 1/7
                        height: parent.height
                        text: "10"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.y_relative_move(10.0)
                        }
                        onHoveredChanged: btnManulaMovement_Yp10.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }

                    Rectangle
                    {
                        width: parent.width * 3/7
                        height: parent.height
                        color: "transparent"
                    }
                }
                // third row
                Row
                {
                    width: parent.width
                    height: parent.height * 1/7

                    Label
                    {
                        width: parent.width * 1/7
                        height: parent.height
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> X- </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                        font.pixelSize: UIStyle.fontSize_Big
                    }

                    Rectangle
                    {
                        width: parent.width * 2/7
                        height: parent.height
                        color: "transparent"
                    }

                    Button
                    {
                        id: btnManulaMovement_Yp1
                        width: parent.width * 1/7
                        height: parent.height
                        text: "1"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.y_relative_move(1.0)
                        }
                        onHoveredChanged: btnManulaMovement_Yp1.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }

                    Rectangle
                    {
                        width: parent.width * 2/7
                        height: parent.height
                        color: "transparent"
                    }

                    Label
                    {
                        width: parent.width * 1/7
                        height: parent.height
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> X+ </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                        font.pixelSize: UIStyle.fontSize_Big
                    }
                }
                // forth row
                Row
                {
                    width: parent.width
                    height: parent.height * 1/7

                    Button
                    {
                        id: btnManulaMovement_Xn100
                        width: parent.width * 1/7
                        height: parent.height
                        text: "-100"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.x_relative_move(-100.0)
                        }
                        onHoveredChanged: btnManulaMovement_Xn100.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Xn10
                        width: parent.width * 1/7
                        height: parent.height
                        text: "-10"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.x_relative_move(-10.0)
                        }
                        onHoveredChanged: btnManulaMovement_Xn10.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Xn1
                        width: parent.width * 1/7
                        height: parent.height
                        text: "-1"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.x_relative_move(-1.0)
                        }
                        onHoveredChanged: btnManulaMovement_Xn1.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }

                    Rectangle
                    {
                        width: parent.width * 1/7
                        height: parent.height
                        color: "transparent"
                    }
                    Button
                    {
                        id: btnManulaMovement_Xp1
                        width: parent.width * 1/7
                        height: parent.height
                        text: "1"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.x_relative_move(1.0)
                        }
                        onHoveredChanged: btnManulaMovement_Xp1.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Xp10
                        width: parent.width * 1/7
                        height: parent.height
                        text: "10"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.x_relative_move(10.0)
                        }
                        onHoveredChanged: btnManulaMovement_Xp10.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Xp100
                        width: parent.width * 1/7
                        height: parent.height
                        text: "100"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.x_relative_move(100.0)
                        }
                        onHoveredChanged: btnManulaMovement_Xp100.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }

                }
                // fifth row
                Row
                {
                    width: parent.width
                    height: parent.height * 1/7

                    Rectangle
                    {
                        width: parent.width * 3/7
                        height: parent.height
                        color: "transparent"
                    }

                    Button
                    {
                        id: btnManulaMovement_Yn1
                        width: parent.width * 1/7
                        height: parent.height
                        text: "-1"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.y_relative_move(-1.0)
                        }
                        onHoveredChanged: btnManulaMovement_Yn1.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }

                    Rectangle
                    {
                        width: parent.width * 3/7
                        height: parent.height
                        color: "transparent"
                    }
                }
                // sixth row
                Row
                {
                    width: parent.width
                    height: parent.height * 1/7

                    Rectangle
                    {
                        width: parent.width * 3/7
                        height: parent.height
                        color: "transparent"
                    }

                    Button
                    {
                        id: btnManulaMovement_Yn10
                        width: parent.width * 1/7
                        height: parent.height
                        text: "-10"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.y_relative_move(-10.0)
                        }
                        onHoveredChanged: btnManulaMovement_Yn10.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }

                    Rectangle
                    {
                        width: parent.width * 3/7
                        height: parent.height
                        color: "transparent"
                    }
                }
                // seventh row
                Row
                {
                    width: parent.width
                    height: parent.height * 1/7

                    Rectangle
                    {
                        width: parent.width * 2/7
                        height: parent.height
                        color: "transparent"
                    }

                    Label
                    {
                        width: parent.width * 1/7
                        height: parent.height
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Y- </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                        font.pixelSize: UIStyle.fontSize_Big
                    }

                    Button
                    {
                        id: btnManulaMovement_Yn100
                        width: parent.width * 1/7
                        height: parent.height
                        text: "-100"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.y_relative_move(-100.0)
                        }
                        onHoveredChanged: btnManulaMovement_Yn100.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }

                    Rectangle
                    {
                        width: parent.width * 3/7
                        height: parent.height
                        color: "transparent"
                    }
                }
            }

            Rectangle
            {
                width: parent.width * 1/14
                height: parent.height
                color: "transparent"
            }

            //******************************
            // Z
            Row
            {
                width: parent.width * 2/14
                height: parent.height

                Column
                {
                    width: parent.width * 1/2
                    height: parent.height

                    Label
                    {
                        width: parent.width
                        height: parent.height * 1/7
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Z+ </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                        font.pixelSize: UIStyle.fontSize_Big
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: parent.height * 5/7
                        color: "transparent"
                    }

                    Label
                    {
                        width: parent.width
                        height: parent.height * 1/7
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Z- </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                        font.pixelSize: UIStyle.fontSize_Big
                    }
                }

                Column
                {
                    width: parent.width * 1/2
                    height: parent.height

                    Button
                    {
                        id: btnManulaMovement_Zp100
                        width: parent.width
                        height: parent.height * 1/7
                        text: "100"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.z_relative_move(100.0)
                        }
                        onHoveredChanged: btnManulaMovement_Zp100.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Zp10
                        width: parent.width
                        height: parent.height * 1/7
                        text: "10"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.z_relative_move(10.0)
                        }
                        onHoveredChanged: btnManulaMovement_Zp10.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Zp1
                        width: parent.width
                        height: parent.height * 1/7
                        text: "1"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.z_relative_move(1.0)
                        }
                        onHoveredChanged: btnManulaMovement_Zp1.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Z_Home
                        width: parent.width
                        height: parent.height * 1/7
                        text: "Home"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.home_axis(3)
                        }
                        onHoveredChanged: btnManulaMovement_Z_Home.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Zn1
                        width: parent.width
                        height: parent.height * 1/7
                        text: "-1"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.z_relative_move(-1.0)
                        }
                        onHoveredChanged: btnManulaMovement_Zn1.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Zn10
                        width: parent.width
                        height: parent.height * 1/7
                        text: "-10"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.z_relative_move(-10.0)
                        }
                        onHoveredChanged: btnManulaMovement_Zn10.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Zn100
                        width: parent.width
                        height: parent.height * 1/7
                        text: "-100"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.z_relative_move(-100.0)
                        }
                        onHoveredChanged: btnManulaMovement_Zn100.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                }
            }

            Rectangle
            {
                width: parent.width * 1/14
                height: parent.height
                color: "transparent"
            }

            //******************************
            // U
            Row
            {
                width: parent.width * 2/14
                height: parent.height

                Column
                {
                    width: parent.width * 1/2
                    height: parent.height

                    Label
                    {
                        width: parent.width
                        height: parent.height * 1/7
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> U+ </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                        font.pixelSize: UIStyle.fontSize_Big
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: parent.height * 5/7
                        color: "transparent"
                    }

                    Label
                    {
                        width: parent.width
                        height: parent.height * 1/7
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> U- </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                        font.pixelSize: UIStyle.fontSize_Big
                    }
                }

                Column
                {
                    width: parent.width * 1/2
                    height: parent.height

                    Button
                    {
                        id: btnManulaMovement_Up100
                        width: parent.width
                        height: parent.height * 1/7
                        text: "100"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.u_relative_move(100.0)
                        }
                        onHoveredChanged: btnManulaMovement_Up100.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Up10
                        width: parent.width
                        height: parent.height * 1/7
                        text: "10"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.u_relative_move(10.0)
                        }
                        onHoveredChanged: btnManulaMovement_Up10.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Up1
                        width: parent.width
                        height: parent.height * 1/7
                        text: "1"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.u_relative_move(1.0)
                        }
                        onHoveredChanged: btnManulaMovement_Up1.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_U_Home
                        width: parent.width
                        height: parent.height * 1/7
                        text: "Home"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.home_axis(4)
                        }
                        onHoveredChanged: btnManulaMovement_U_Home.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Un1
                        width: parent.width
                        height: parent.height * 1/7
                        text: "-1"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.u_relative_move(-1.0)
                        }
                        onHoveredChanged: btnManulaMovement_Un1.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Un10
                        width: parent.width
                        height: parent.height * 1/7
                        text: "-10"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.u_relative_move(-10.0)
                        }
                        onHoveredChanged: btnManulaMovement_Un10.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                    Button
                    {
                        id: btnManulaMovement_Un100
                        width: parent.width
                        height: parent.height * 1/7
                        text: "-100"
                        highlighted: UIStyle.darkTheme
                        background:  Rectangle {
                            radius: 9
                            color: UIStyle.themeBlue
                        }
                        onClicked:
                        {
                            serialPort.u_relative_move(-100.0)
                        }
                        onHoveredChanged: btnManulaMovement_Un100.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
                    }
                }
            }

            Rectangle
            {
                width: parent.width * 1/14
                height: parent.height
                color: "transparent"
            }
        }

    }


    //*********************************************************
    //*********************************************************
    // add new move grid

    Grid
    {
        id: addNewMove_grid
        width: parent.width
        height: parent.height
        spacing: 10
        rows: 3
        visible: false

        Button
        {
            id: btnAddNewMoveCancel
            width: parent.width
            height: parent.height * 1/10
            text: "Cancel"
            highlighted: UIStyle.darkTheme
            background:  Rectangle {
                radius: 9
                color: UIStyle.themeBlue
            }
            onClicked:
            {
                setMoves_grid.visible=true
                addNewMove_grid.visible=false
            }
            onHoveredChanged: btnAddNewMoveCancel.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
        }


        Row
        {
            width: parent.width
            height: parent.height * 1/2
            spacing: 5
            Rectangle
            {
                width: parent.width * 1/8
                height: parent.height
                color: "transparent"
            }


            Frame
            {
                width: parent.width * 2/8
                height: parent.height
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                Grid
                {
                    width: parent.width
                    height: parent.height
                    rows: 5

                    Label
                    {
                        width: parent.width
                        height: parent.height * 1/7
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Source </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: parent.height * 1/7
                        color: "transparent"
                    }


                    Row
                    {
                        width: parent.width
                        height: parent.height * 2/7

                        Label
                        {
                            width: parent.width * 2/5
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "<b> Source Type </b>"
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                            font.family: UIStyle.fontName
                        }

                        ComboBox
                        {
                            id: cmb_addNewMove_Source_sourceType
                            width: parent.width * 3/5
                            height: parent.height
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

                            model: ["Source-1","Source-2"]
                            onActivated: {
                                this.displayText = this.currentText
                                if(cmb_addNewMove_Source_sourceType.currentIndex==1)
                                {
                                    sourceType1_row1.visible=false
                                    sourceType2_row1.visible=true
                                }
                                else
                                {
                                    sourceType1_row1.visible=true
                                    sourceType2_row1.visible=false
                                }
                            }
                        }
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: parent.height * 1/7
                        color: "transparent"
                    }

                    Row
                    {
                        id: sourceType1_row1
                        width: parent.width
                        height: parent.height * 2/7

                        Label
                        {
                            width: parent.width * 1/5
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "<b> Start </b>"
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                            font.family: UIStyle.fontName
                        }

                        ComboBox
                        {
                            id: cmb_addNewMove_Source_Start_row
                            width: parent.width * 2/5
                            height: parent.height
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

                            model: ["1","2","3","4","5","6","7","8","9","10","11","12"]
                            onActivated: {
                                this.displayText = this.currentText
                            }
                        }

                        ComboBox
                        {
                            id: cmb_addNewMove_Source_Start_column
                            width: parent.width * 2/5
                            height: parent.height
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

                            model: ["A","B","C","D","E","F","G","H"]
                            onActivated: {
                                this.displayText = this.currentText
                            }
                        }
                    }

                    Row
                    {
                        id: sourceType2_row1
                        width: parent.width
                        height: parent.height * 2/7
                        visible: false

                        Label
                        {
                            width: parent.width * 2/5
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "<b> Source Number </b>"
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                            font.family: UIStyle.fontName
                        }

                        ComboBox
                        {
                            id: cmb_addNewMove_Source2_source_number
                            width: parent.width * 3/5
                            height: parent.height
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

                            model: ["1","2","3","4","5","6","7","8","9","10","11","12","13"]
                            onActivated: {
                                this.displayText = this.currentText
                            }
                        }
                    }

                }
            }

            Frame
            {
                width: parent.width * 2/8
                height: parent.height
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                Grid
                {
                    width: parent.width
                    height: parent.height
                    rows: 5

                    Label
                    {
                        width: parent.width
                        height: parent.height * 1/7
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Target </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: parent.height * 1/7
                        color: "transparent"
                    }

                    Row
                    {
                        width: parent.width
                        height: parent.height * 2/7

                        Label
                        {
                            width: parent.width * 1/5
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "<b> Start </b>"
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                            font.family: UIStyle.fontName
                        }

                        ComboBox
                        {
                            id: cmb_addNewMove_Target_Start_row
                            width: parent.width * 2/5
                            height: parent.height
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

                            model: ["A","B","C","D","E","F","G","H"]
                            onActivated: {
                                this.displayText = this.currentText
                            }
                        }

                        ComboBox
                        {
                            id: cmb_addNewMove_Target_Start_column
                            width: parent.width * 2/5
                            height: parent.height
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

                            model: ["1","2","3","4","5","6","7","8","9","10","11","12"]
                            onActivated: {
                                this.displayText = this.currentText
                            }
                        }
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: parent.height * 1/7
                        color: "transparent"
                    }

                    Row
                    {
                        width: parent.width
                        height: parent.height * 2/7

                        Label
                        {
                            width: parent.width * 1/5
                            height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "<b> Count </b>"
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                            font.family: UIStyle.fontName
                        }

                        SpinBox
                        {
                            id: txt_addNewMove_Target_number_of_units
                            width: parent.width * 4/5
                            height: parent.height
                            from:1
                            to:96
                            value: 2
                        }
                    }

                }
            }

            Frame
            {
                width: parent.width * 2/8
                height: parent.height
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                Grid
                {
                    width: parent.width
                    height: parent.height
                    rows: 5

                    Label
                    {
                        width: parent.width
                        height: parent.height * 1/5
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Sampler Type </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                    }
                    Rectangle
                    {
                        width: parent.width
                        height: parent.height * 1/5
                        color: "transparent"
                    }
                    ComboBox
                    {
                        id: cmb_addNewMove_Sampler_Type
                        width: parent.width
                        height: parent.height * 1/5
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

                        model: ["Sampler-1","Sampler-2"]
                        onActivated: {
                            this.displayText = this.currentText
                        }
                    }
                }
            }


            Rectangle
            {
                width: parent.width * 1/8
                height: parent.height
                color: "transparent"
            }
        }
        Row
        {
            width: parent.width
            height: parent.height * 1/10
            Rectangle
            {
                width: parent.width * 1/4
                height: parent.height
                color: "transparent"
            }
            Button
            {
                id: btnAddNewMoveAdd
                width: parent.width * 1/2
                height: parent.height
                text: "Add"
                highlighted: UIStyle.darkTheme
                background:  Rectangle {
                    radius: 9
                    color: UIStyle.themeBlue
                }
                onClicked:
                {
                    setMoves_grid.visible=true
                    addNewMove_grid.visible=false
                    serialPort.add_new_move(cmb_addNewMove_Source_sourceType.currentIndex+1,
                                            cmb_addNewMove_Source_Start_row.currentIndex+1,
                                            cmb_addNewMove_Source_Start_column.currentIndex+1,
                                            cmb_addNewMove_Source2_source_number.currentIndex+1,
                                            cmb_addNewMove_Target_Start_row.currentIndex+1,
                                            cmb_addNewMove_Target_Start_column.currentIndex+1,
                                            txt_addNewMove_Target_number_of_units.value,
                                            cmb_addNewMove_Sampler_Type.currentIndex+1)

                    //********************************************************************
                    // change dots colors of source
                    if(cmb_addNewMove_Source_sourceType.currentIndex==0)
                    {// Type 1 Source
                        var SourceRowObjects=[]
                        for(var i=1;i<13;i++)
                        SourceRowObjects.push(source_dots_grid.children[i])

                        var current_row=cmb_addNewMove_Source_Start_row.currentIndex
                        var current_col=cmb_addNewMove_Source_Start_column.currentIndex

                        for(var j=1;j<=txt_addNewMove_Target_number_of_units.value;j++)
                        {
                            SourceRowObjects[current_row].children[current_col].color=UIStyle.colorQtAuxGreen2
                            current_col++

                            if((j+cmb_addNewMove_Source_Start_column.currentIndex)%8==0)
                            {
                                current_row++
                                current_col=0
                            }
                        }
                    }
                    else
                    {// Type 2 Source
                        switch(cmb_addNewMove_Source2_source_number.currentIndex)
                        {
                        case 0:
                            source2_kit1_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        case 1:
                            source2_kit2_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        case 2:
                            source2_kit3_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        case 3:
                            source2_kit4_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        case 4:
                            source2_kit5_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        case 5:
                            source2_kit6_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        case 6:
                            source2_kit7_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        case 7:
                            source2_kit8_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        case 8:
                            source2_kit9_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        case 9:
                            source2_kit10_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        case 10:
                            source2_kit11_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        case 11:
                            source2_kit12_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        case 12:
                            source2_kit13_dot.color=UIStyle.colorQtAuxGreen2
                            break
                        }

                    }

                    //********************************************************************

                    //********************************************************************
                    // change dots colors of target
                    var TargetRowObjects=[]
                    for(i=1;i<9;i++)
                        TargetRowObjects.push(target_dots_grid.children[i])

                    current_row=cmb_addNewMove_Target_Start_row.currentIndex
                    current_col=cmb_addNewMove_Target_Start_column.currentIndex
                    for(j=1;j<=txt_addNewMove_Target_number_of_units.value;j++)
                    {
                        TargetRowObjects[current_row].children[current_col].color=UIStyle.colorQtAuxGreen2
                        current_col++

                        if((j+cmb_addNewMove_Target_Start_column.currentIndex)%12==0)
                        {
                            current_row++
                            current_col=0
                        }
                    }
                    //********************************************************************

                }
                onHoveredChanged: btnAddNewMoveAdd.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            }
            Rectangle
            {
                width: parent.width * 1/4
                height: parent.height
                color: "transparent"
            }
        }

    }


    //*********************************************************
    //*********************************************************
    // settings grid

    Grid
    {
        id: settings_grid
        width: parent.width
        height: parent.height
        rows: 8
        visible: false

        Button
        {
            id: btnSettingsBack
            width: parent.width
            height: parent.height * 1/10
            text: "Back"
            highlighted: UIStyle.darkTheme
            background:  Rectangle {
                radius: 9
                color: UIStyle.themeBlue
            }
            onClicked:
            {
                main_grid.visible=true
                settings_grid.visible=false
            }
            onHoveredChanged: btnSettingsBack.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
        }

        Rectangle
        {
            width: parent.width
            height: parent.height * 1/7
            color: "transparent"
        }

        Row
        {
            width: parent.width
            height: parent.height * 1/9
            spacing: 5

            Rectangle
            {
                width: parent.width * 1/7
                height: parent.height
                color: "transparent"
            }

            Label
            {
                width: parent.width * 1/7
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "<b> Serial Port: </b>"
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                font.family: UIStyle.fontName
                font.pixelSize: UIStyle.fontSize_Big
            }

            TextField
            {
                id: txt_serialport_name
                width: parent.width * 1/7
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "ttyUSB0"
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                font.family: UIStyle.fontName
            }

            Rectangle
            {
                width: parent.width * 1/8
                height: parent.height
                color: "transparent"
            }

            Button
            {
                id: btnOpenPort
                width: parent.width * 1/7
                height: parent.height
                text: "Open Port"
                highlighted: UIStyle.darkTheme
                background:  Rectangle {
                    radius: 9
                    color: UIStyle.themeBlue
                }
                onClicked:
                {
                    serialPort.open_port()
                }
                onHoveredChanged: btnOpenPort.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            }

            Button
            {
                id: btnClosePort
                width: parent.width * 1/7
                height: parent.height
                enabled: false
                text: "Close Port"
                highlighted: UIStyle.darkTheme
                background:  Rectangle {
                    radius: 9
                    color: UIStyle.themeBlue
                }
                onClicked:
                {
                    serialPort.open_port()
                }
                onHoveredChanged: btnClosePort.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            }

            Rectangle
            {
                width: parent.width * 1/8
                height: parent.height
                color: "transparent"
            }

        }

        Rectangle
        {
            width: parent.width
            height: parent.height * 1/8
            color: "transparent"
        }

        Label
        {
            id: lbl_status
            width: parent.width
            height: parent.height * 1/8
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "<b> Port Is Closed </b>"
            //Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
            color: UIStyle.portSatusLabelColorClosed
            font.family: UIStyle.fontName
            font.pixelSize: UIStyle.fontSize_Big
        }

        Rectangle
        {
            width: parent.width
            height: parent.height * 1/8
            color: "transparent"
        }

        Row
        {
            width: parent.width
            height: parent.height * 1/9
            spacing: 5

            Rectangle
            {
                width: parent.width * 1/6
                height: parent.height
                color: "transparent"
            }

            Label
            {
                width: parent.width * 1/6
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "<b> Theme </b>"
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                font.family: UIStyle.fontName
                font.pixelSize: UIStyle.fontSize_Big
            }

            Rectangle
            {
                width: parent.width * 1/6
                height: parent.height
                color: "transparent"
            }

            Label
            {
                width: parent.width * 1/20
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "<b> Dark </b>"
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                font.family: UIStyle.fontName
                font.pixelSize: UIStyle.fontSize_Medium
            }

            Switch
            {
                width: parent.width * 1/20
                height: parent.height
                //                text: qsTr("Wi-Fi")
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                onToggled:
                {
                    UIStyle.darkTheme = !UIStyle.darkTheme
                }
            }

            //            Button
            //            {
            //                id: btnChangeTheme
            //                width: parent.width * 1/6
            //                height: parent.height
            //                text: "Change Theme"
            //                highlighted: UIStyle.darkTheme
            //                background:  Rectangle {
            //                    radius: 9
            //                    color: UIStyle.themeBlue
            //                }
            //                onClicked:
            //                {
            //                    UIStyle.darkTheme = !UIStyle.darkTheme
            //                    btnHome.background.color = UIStyle.themeBlue
            //                    btnSetting.background.color = UIStyle.themeBlue
            //                    btnCloseOpenDoor.background.color = UIStyle.themeBlue
            //                }
            //                onHoveredChanged: btnChangeTheme.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            //            }

            Label
            {
                width: parent.width * 1/20
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "<b> Light </b>"
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                font.family: UIStyle.fontName
                font.pixelSize: UIStyle.fontSize_Medium
            }

            Rectangle
            {
                width: parent.width * 1/6
                height: parent.height
                color: "transparent"
            }

        }



    }

    //*********************************************************
    //*********************************************************
    // Temperature grid

    Grid
    {
        id: temperature_grid
        width: parent.width
        height: parent.height
        rows: 8
        visible: false

        Button
        {
            id: btnTemperatureBack
            width: parent.width
            height: parent.height * 1/10
            text: "Back"
            highlighted: UIStyle.darkTheme
            background:  Rectangle {
                radius: 9
                color: UIStyle.themeBlue
            }
            onClicked:
            {
                main_grid.visible=true
                temperature_grid.visible=false
            }
            onHoveredChanged: btnTemperatureBack.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
        }

        Rectangle
        {
            width: parent.width
            height: parent.height * 1/20
            color: "transparent"
        }

        Row
        {
            width: parent.width
            height: parent.height * 8/10
            spacing: 5

            Rectangle
            {
                width: parent.width * 1/10
                height: parent.height
                color: "transparent"
            }

            // left frame
            Frame
            {
                width: parent.width * 4/10
                height: parent.height
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                Row
                {
                    width: parent.width
                    height: parent.height

                    Rectangle
                    {
                        width: parent.width * 2/10
                        height: parent.height
                        color: "transparent"
                    }

                    Column
                    {
                        width: parent.width * 6/10
                        height: parent.height

                        Image
                        {
                            width: parent.width
                            height: parent.height * 1/5
                            source: "qrc:/Images/2.png"
                        }

                        Label
                        {
                            width: parent.width
                            height: parent.height * 1/5
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "<b> Actual Temperature: </b>"
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                            font.family: UIStyle.fontName
                            font.pixelSize: UIStyle.fontSize_Big
                        }

                        Label
                        {
                            id: lbl_actual_temp1
                            width: parent.width
                            height: parent.height * 1/5
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "<b>20<b>"
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                            font.family: UIStyle.fontName
                            font.pixelSize: UIStyle.fontSize_VeryBig
                        }

                        Label
                        {
                            width: parent.width
                            height: parent.height * 1/5
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "<b> Target Temperature: </b>"
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                            font.family: UIStyle.fontName
                            font.pixelSize: UIStyle.fontSize_Big
                        }

                        Column
                        {
                            width: parent.width
                            height: parent.height * 1/5

                            Rectangle
                            {
                                width: parent.width
                                height: parent.height * 1/4
                                color: "transparent"
                            }

                            SpinBox
                            {
                                width: parent.width
                                height: parent.height * 1/2
                                from:0
                                to:99
                                value: 20
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.pixelSize: UIStyle.fontSize_Big
                            }

                            Rectangle
                            {
                                width: parent.width
                                height: parent.height * 1/4
                                color: "transparent"
                            }
                        }

                    }

                    Rectangle
                    {
                        width: parent.width * 2/10
                        height: parent.height
                        color: "transparent"
                    }

                }

            }

            //right frame
            Frame
            {
                width: parent.width * 4/10
                height: parent.height
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                Row
                {
                    width: parent.width
                    height: parent.height

                    Rectangle
                    {
                        width: parent.width * 2/10
                        height: parent.height
                        color: "transparent"
                    }

                    Column
                    {
                        width: parent.width * 6/10
                        height: parent.height

                        Image
                        {
                            width: parent.width
                            height: parent.height * 1/5
                            source: "qrc:/Images/3.png"
                        }

                        Label
                        {
                            width: parent.width
                            height: parent.height * 1/5
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "<b> Actual Temperature: </b>"
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                            font.family: UIStyle.fontName
                            font.pixelSize: UIStyle.fontSize_Big
                        }

                        Label
                        {
                            id: lbl_actual_temp2
                            width: parent.width
                            height: parent.height * 1/5
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "<b>20<b>"
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                            font.family: UIStyle.fontName
                            font.pixelSize: UIStyle.fontSize_VeryBig
                        }

                        Label
                        {
                            width: parent.width
                            height: parent.height * 1/5
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "<b> Target Temperature: </b>"
                            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                            font.family: UIStyle.fontName
                            font.pixelSize: UIStyle.fontSize_Big
                        }

                        Column
                        {
                            width: parent.width
                            height: parent.height * 1/5

                            Rectangle
                            {
                                width: parent.width
                                height: parent.height * 1/4
                                color: "transparent"
                            }

                            SpinBox
                            {
                                width: parent.width
                                height: parent.height * 1/2
                                from:0
                                to:99
                                value: 20
                                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                                font.pixelSize: UIStyle.fontSize_Big
                            }

                            Rectangle
                            {
                                width: parent.width
                                height: parent.height * 1/4
                                color: "transparent"
                            }
                        }

                    }

                    Rectangle
                    {
                        width: parent.width * 2/10
                        height: parent.height
                        color: "transparent"
                    }

                }
            }

            Rectangle
            {
                width: parent.width * 1/10
                height: parent.height
                color: "transparent"
            }

        }

        Rectangle
        {
            width: parent.width
            height: parent.height * 1/20
            color: "transparent"
        }






        Rectangle
        {
            width: parent.width
            height: parent.height * 1/8
            color: "transparent"
        }

    }


    //*********************************************************
    //*********************************************************
    // Wash Reader grid

    Grid
    {
        id: washReader_grid
        width: parent.width
        height: parent.height
        rows: 3
        visible: false

        Button
        {
            id: btnWashReaderBack
            width: parent.width
            height: parent.height * 1/10
            text: "Back"
            highlighted: UIStyle.darkTheme
            background:  Rectangle {
                radius: 9
                color: UIStyle.themeBlue
            }
            onClicked:
            {
                main_grid.visible=true
                washReader_grid.visible=false
            }
            onHoveredChanged: btnWashReaderBack.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
        }

        Label
        {
            width: parent.width
            height: parent.height * 1/2
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "<b> Under Construction </b>"
            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
            font.family: UIStyle.fontName
            font.pixelSize: 50
        }


    }

}
