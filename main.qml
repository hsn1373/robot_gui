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


    //*********************************************************
    //*********************************************************
    // main menu

    Grid
    {
        id: main_grid
        width: parent.width
        height: parent.height
        padding: 5
        spacing: 3
        rows: 4

        Rectangle
        {
            width: parent.width
            height: parent.height * 1/4
            color: "transparent"
        }

        Row
        {
            width: parent.width
            height: parent.height * 1/5
            spacing: 3

            Button
            {
                id: btnSetMovesPage
                width: parent.width * 1/3
                height: parent.height
                text: "Set Moves"
                highlighted: UIStyle.darkTheme
                //icon.name: "edit-cut"
                //icon.source: "images/cut.png"
                background:  Rectangle {
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
                id: btnSettingsPage
                width: parent.width * 1/3
                height: parent.height
                text: "Settings"
                highlighted: UIStyle.darkTheme
                background:  Rectangle {
                    color: UIStyle.themeBlue
                }
                onClicked:
                {
                    main_grid.visible=false
                    settings_grid.visible=true
                }
                onHoveredChanged: btnSettingsPage.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
            }

            Button
            {
                id: btnExit
                width: parent.width * 1/3
                height: parent.height
                text: "exit"
                highlighted: UIStyle.darkTheme
                background:  Rectangle {
                    color: UIStyle.themeBlue
                }
                onClicked:
                {
                    Qt.callLater(Qt.quit)
                }
                onHoveredChanged: btnExit.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
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
        rows: 6
        visible: false

        Button
        {
            id: btnSetMovesBack
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
                setMoves_grid.visible=false
            }
            onHoveredChanged: btnSetMovesBack.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
        }


        Row
        {
            width: parent.width
            height: parent.height * 4/10
            spacing: 5

            Rectangle
            {
                width: parent.width * 1/12
                height: parent.height
                color: "transparent"
            }

            Frame
            {
                width: parent.width * 5/12
                height: parent.height
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                Grid
                {
                    width: parent.width
                    height: parent.height
                    rows: 9

                    Label
                    {
                        width: parent.width
                        height: parent.height * 1/9
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Source 1 </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
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

            Frame
            {
                width: parent.width * 5/12
                height: parent.height
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                Grid
                {
                    width: parent.width
                    height: parent.height
                    rows: 9

                    Label
                    {
                        width: parent.width
                        height: parent.height * 1/9
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Target </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
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
                width: parent.width * 1/12
                height: parent.height
                color: "transparent"
            }
        }


        Row
        {
            width: parent.width
            height: parent.height * 2/10
            spacing: 5

            Rectangle
            {
                width: parent.width * 1/12
                height: parent.height
                color: "transparent"
            }
            Frame
            {
                width: parent.width * 10/12 + 5
                height: parent.height
                Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                Grid
                {
                    width: parent.width
                    height: parent.height
                    rows: 2

                    Label
                    {
                        width: parent.width
                        height: parent.height * 1/2
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Source 2 </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                    }

                    Row
                    {
                        width: parent.width
                        height: parent.height * 1/2
                        Repeater
                        {
                            model: 13
                            Rectangle
                            {
                                width: parent.width * 1/13
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
            Rectangle
            {
                width: parent.width * 1/12
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
                id: btnSetMovesAddNewMove
                width: parent.width * 1/2
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
                width: parent.width * 1/4
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
                        height: parent.height * 1/5
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "<b> Source </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: parent.height * 1/5
                        color: "transparent"
                    }

                    Row
                    {
                        width: parent.width
                        height: parent.height * 1/5

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

                            displayText: _select_device_str
                            model: ["A","B","C","D","E","F","G","H"]
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

                            displayText: _select_device_str
                            model: ["1","2","3"]
                            onActivated: {
                                this.displayText = this.currentText
                            }
                        }
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: parent.height * 1/5
                        color: "transparent"
                    }

                    Row
                    {
                        width: parent.width
                        height: parent.height * 1/5

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
                            width: parent.width * 4/5
                            height: parent.height
                            from:1
                            to:12
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
                        text: "<b> Target </b>"
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
                        font.family: UIStyle.fontName
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: parent.height * 1/5
                        color: "transparent"
                    }

                    Row
                    {
                        width: parent.width
                        height: parent.height * 1/5

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

                            displayText: _select_device_str
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

                            displayText: _select_device_str
                            model: ["1","2","3"]
                            onActivated: {
                                this.displayText = this.currentText
                            }
                        }
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: parent.height * 1/5
                        color: "transparent"
                    }

                    Row
                    {
                        width: parent.width
                        height: parent.height * 1/5

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
                            width: parent.width * 4/5
                            height: parent.height
                            from:1
                            to:12
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

                        displayText: _select_device_str
                        model: ["Sampler-1","Sampler-2","Sampler-3"]
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

        Button
        {
            id: btnChangeTheme
            width: parent.width * 1/5
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
            id: btnOpenPort
            width: parent.width * 1/5
            height: parent.height * 1/8
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

        Label
        {
            id: lbl_status
            width: parent.width
            height: parent.height * 1/8
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "<b> Port Is ... </b>"
            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light
            font.family: UIStyle.fontName
            //font.pixelSize: parent.height - 2
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



    //    Grid
    //    {
    //        width: parent.width
    //        height: parent.height
    //        padding: 5
    //        spacing: 3
    //        columns: 2
    //        visible: false

    //        //*********************************************************************************
    //        //*********************************************************************************
    //        // left side _ main buttons
    //        Frame
    //        {
    //            width: parent.width * 1/10
    //            height: parent.height - 10
    //            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

    //            Grid
    //            {
    //                columns: 1
    //                width: parent.width
    //                height: parent.height
    //                spacing: 3
    //                Button
    //                {
    //                    id: btnHome
    //                    width: parent.width
    //                    height: parent.height * 1/10
    //                    text: "Home"
    //                    enabled: false
    //                    highlighted: UIStyle.darkTheme
    //                    background:  Rectangle {
    //                        radius: 9
    //                        color: UIStyle.themeBlue
    //                    }
    //                    onClicked:
    //                    {
    //                        btnHome.enabled = false
    //                        btnSetting.enabled = true
    //                        mainStackView.pop()
    //                        mainStackView.push("homePage.qml")
    //                    }
    //                    onHoveredChanged: btnHome.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
    //                }

    //                Button
    //                {
    //                    id: btnSetting
    //                    width: parent.width
    //                    height: parent.height * 1/10
    //                    text: "Setting"
    //                    highlighted: UIStyle.darkTheme
    //                    background:  Rectangle {
    //                        radius: 9
    //                        color: UIStyle.themeBlue
    //                    }
    //                    onClicked:
    //                    {
    //                        btnHome.enabled = true
    //                        btnSetting.enabled = false
    //                        mainStackView.pop()
    //                        mainStackView.push("settingPage.qml")
    //                    }
    //                    onHoveredChanged: btnSetting.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
    //                }

    //                Button
    //                {
    //                    id: btnChangeTheme
    //                    width: parent.width
    //                    height: parent.height * 1/10
    //                    text: "Change Theme"
    //                    highlighted: UIStyle.darkTheme
    //                    background:  Rectangle {
    //                        radius: 9
    //                        color: UIStyle.themeBlue
    //                    }
    //                    onClicked:
    //                    {
    //                        UIStyle.darkTheme = !UIStyle.darkTheme
    //                        btnHome.background.color = UIStyle.themeBlue
    //                        btnSetting.background.color = UIStyle.themeBlue
    //                        btnCloseOpenDoor.background.color = UIStyle.themeBlue
    //                    }
    //                    onHoveredChanged: btnChangeTheme.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
    //                }

    //                Rectangle
    //                {
    //                    width: parent.width
    //                    height: parent.height * 5/10
    //                    color: "transparent"
    //                }

    //                Button
    //                {
    //                    id: btnCloseOpenDoor
    //                    width: parent.width
    //                    height: parent.height * 1/10
    //                    text: "exit"
    //                    highlighted: UIStyle.darkTheme
    //                    background:  Rectangle {
    //                        radius: 9
    //                        color: UIStyle.themeBlue
    //                    }
    //                    onClicked:
    //                    {
    //                        Qt.callLater(Qt.quit)
    //                    }
    //                    onHoveredChanged: btnCloseOpenDoor.background.color=hovered?UIStyle.buttonHovered:UIStyle.themeBlue
    //                }

    //            }
    //        }

    //        //*********************************************************************************
    //        //*********************************************************************************
    //        // right side
    //        Frame
    //        {
    //            width: parent.width * 9/10 - 15
    //            height: parent.height - 10
    //            Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

    //            Grid
    //            {
    //                width: parent.width
    //                height: parent.height
    //                columns: 1
    //                spacing: 5

    //                StackView {
    //                    width: parent.width
    //                    height: parent.height
    //                    id: mainStackView
    //                    initialItem: "homePage.qml"
    //                }
    //            }
    //        }

    //    }
}
