import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick

PanelWindow {
    //color: "transparent"
    color: "blue"
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 50
    focusable: false

    Repeater {
        model: Hyprland.workspaces
        delegate: Rectangle {
            width: parent.height
            height: parent.height
            //height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: index * (width + 5)
            border.width: 1
            radius: 25
            Text {
                anchors.centerIn: parent
                text: index
                color: HyprlandWorkspace.active ? "blue" : "black"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.workspace = index
            }
        }
    }
}
