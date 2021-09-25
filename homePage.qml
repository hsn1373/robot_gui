import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "./Style"

Item {

    Grid
    {
        width: parent.width
        height: parent.height
        spacing: 5
        rows: 6

        Rectangle
        {
            width: parent.width
            height: parent.height * 1/10
            color: "transparent"
        }

        Repeater
        {
            model: 4
            Row
            {
                width: parent.width
                height: parent.height * 2/10
                spacing: 1

                Rectangle
                {
                    width: parent.width * 1/12
                    height: parent.height
                    color: "transparent"
                }
                Repeater
                {
                    model: 10
                    Frame
                    {
                        width: parent.width * 1/12
                        height: parent.height
                        Material.theme: UIStyle.darkTheme ? Material.Dark : Material.Light

                        Grid
                        {
                            width: parent.width
                            height: parent.height
                            rows: 10

                            Repeater
                            {
                                model: 10
                                Row
                                {
                                    width: parent.width
                                    height: parent.height * 1/10
                                    Repeater
                                    {
                                        model: 5
                                        Rectangle
                                        {
                                            width: parent.width * 1/5
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
                }
                Rectangle
                {
                    width: parent.width * 1/12
                    height: parent.height
                    color: "transparent"
                }
            }
        }
    }

}
