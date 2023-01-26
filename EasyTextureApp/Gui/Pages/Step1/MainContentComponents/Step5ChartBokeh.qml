// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15

import Gui.Globals 1.0 as ExGlobals

import easyApp.Gui.Style 1.0 as EaStyle
import easyApp.Gui.Elements 1.0 as EaElements
import easyApp.Gui.Components 1.0 as EaComponents


Rectangle {
    readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5

    color: EaStyle.Colors.mainContentBackground

    Column {

        anchors.left: parent.left
        anchors.leftMargin: commonSpacing
        anchors.top: parent.top
        anchors.topMargin: commonSpacing * 0.5
        spacing: commonSpacing

        EaElements.TextInput {
            font.family: EaStyle.Fonts.secondFontFamily
            font.pixelSize: EaStyle.Sizes.fontPixelSize * 3
            font.weight: Font.ExtraLight
            text: ExGlobals.Constants.proxy.project.projectInfoAsJson.name
            onEditingFinished: ExGlobals.Constants.proxy.editProjectInfo("name", text)
        }

        Grid {
            columns: 2
            rowSpacing: 0
            columnSpacing: commonSpacing

            EaElements.Label {
                font.bold: true
                text: qsTr("Short description:")
            }
            EaElements.TextInput {
                text: ExGlobals.Constants.proxy.project.projectInfoAsJson.short_description
                onEditingFinished: ExGlobals.Constants.proxy.editProjectInfo("short_description", text)
            }

            EaElements.Label {
                visible: ExGlobals.Constants.proxy.project.currentProjectPath !== '--- EXAMPLE ---'
                font.bold: true
                text: qsTr("Location:")
            }
            EaElements.Label {
                visible: ExGlobals.Constants.proxy.project.currentProjectPath !== '--- EXAMPLE ---'
                text: ExGlobals.Constants.proxy.project.currentProjectPath
            }

            EaElements.Label {
                font.bold: true
                text: qsTr("Samples:")
            }
            EaElements.Label {
                text: ExGlobals.Constants.proxy.project.projectInfoAsJson.samples
                //onEditingFinished: ExGlobals.Constants.proxy.editProjectInfo("samples", text)
            }

            EaElements.Label {
                font.bold: true
                text: qsTr("Experiments:")
            }
            EaElements.Label {
                text: ExGlobals.Constants.proxy.project.projectInfoAsJson.experiments
                //onEditingFinished: ExGlobals.Constants.proxy.editProjectInfo("experiments", text)
            }

            /*
            EaElements.Label {
                font.bold: true
                text: qsTr("Calculations:")
            }
            EaElements.TextInput {
                text: ExGlobals.Constants.proxy.project.projectInfoAsJson.calculations
                onEditingFinished: ExGlobals.Constants.proxy.editProjectInfo("calculations", text)
            }
            */

            EaElements.Label {
                font.bold: true
                text: qsTr("Modified:")
            }
            EaElements.Label {
                text: ExGlobals.Constants.proxy.project.projectInfoAsJson.modified
            }
        }

    }

}
