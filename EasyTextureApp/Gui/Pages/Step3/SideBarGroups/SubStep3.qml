// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15
import QtQuick.Controls 2.15

import easyApp.Gui.Style 1.0 as EaStyle
import easyApp.Gui.Elements 1.0 as EaElements
import easyApp.Gui.Logic 1.0 as EaLogic

import Gui.Globals 1.0 as ExGlobals


Grid {
    rows: 6
    columnSpacing: EaStyle.Sizes.fontPixelSize
    rowSpacing: 30

    Row{

        Grid {
            readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5


            columns: 1

            columnSpacing: commonSpacing

            EaElements.Label {
                text: qsTr("Save Set of d-Spacing Patterns")
            }
            EaElements.Label {
                text: "in MAUD Format."
            }
        }
    }




    // Name-Format
    Row {
        spacing: EaStyle.Sizes.fontPixelSize * 1.5

        Row {
            spacing: EaStyle.Sizes.fontPixelSize * 0.5

            EaElements.Label {
                enabled: false
                width: locationLabel.width
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: TextInput.AlignRight
                text: qsTr("Name")
            }

            EaElements.TextField {
                id: reportNameField

                width: EaStyle.Sizes.sideBarContentWidth - locationLabel.width - formatLabel.width - reportFormatField.width - EaStyle.Sizes.fontPixelSize * 2.5
                horizontalAlignment: TextInput.AlignLeft
                placeholderText: qsTr("Enter report file name here")

                Component.onCompleted: text = 'report'
            }
        }

        Row {
            spacing: EaStyle.Sizes.fontPixelSize * 0.5

            EaElements.Label {
                id: formatLabel
                enabled: false
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Format")
            }

            EaElements.ComboBox {
                id: reportFormatField

                topInset: 0
                bottomInset: 0
                width: EaStyle.Sizes.fontPixelSize * 10

                textRole: "text"
                valueRole: "value"
                model: [
                    { value: 'maud', text: qsTr("MAUD *.maud") },
                    { value: 'txt', text: qsTr("Text *.txt") }                    ]
            }
        }

    }

    // Location
    Row {
        spacing: EaStyle.Sizes.fontPixelSize * 0.5

        EaElements.Label {
            id: locationLabel

            enabled: false
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Location")
        }

        EaElements.TextField {
            id: reportLocationField

            width: EaStyle.Sizes.sideBarContentWidth - locationLabel.width - EaStyle.Sizes.fontPixelSize * 0.5
            rightPadding: chooseButton.width
            horizontalAlignment: TextInput.AlignLeft

            placeholderText: qsTr("Enter report location here")
            text: ExGlobals.Constants.proxy.project.projectCreated ?
                      EaLogic.Utils.urlToLocalFile(reportParentDirDialog.folder + '/' + reportNameField.text + '.' + reportFormatField.currentValue) :
                      ''

            EaElements.ToolButton {
                id: chooseButton

                anchors.right: parent.right

                showBackground: false
                fontIcon: "folder-open"
                ToolTip.text: qsTr("Choose report parent directory")

                onClicked: reportParentDirDialog.open()
            }
        }
    }

    // Export button
    EaElements.SideBarButton {
        wide: true
        fontIcon: "download"
        text: qsTr("Save")

        onClicked: {
            if (reportFormatField.currentValue === 'html') {
                ExGlobals.Constants.proxy.project.saveReport(reportLocationField.text)
            } else if (reportFormatField.currentValue === 'pdf') {
                ExGlobals.Variables.reportWebView.printToPdf(reportLocationField.text)
            }
        }

        Component.onCompleted: ExGlobals.Variables.exportReportButton = this
    }





    // Logic

    function inputFieldWidth() {
        return (EaStyle.Sizes.sideBarContentWidth - columnSpacing * (columns - 1)) / columns
    }

}
