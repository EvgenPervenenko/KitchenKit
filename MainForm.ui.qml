import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.3

Item {
    width: 640
    height: 480
    property alias listView1: listView1
    
    
    RowLayout {
        id: rowLayout1
        anchors.fill: parent
        
        Rectangle {
            id: rectangle1
            color: "#3e3e3e"
            border.width: 1
            anchors.fill: parent
            
            ColumnLayout {
                id: columnLayout1
                x: 10
                y: 10
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.bottomMargin: 10
                anchors.topMargin: 10
                anchors.fill: parent
                
                ListView {
                    id: listView1
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    anchors.fill: parent
                    model: ListModel {
                        ListElement {
                            name: "Grey"
                            colorCode: "grey"
                        }
                        
                        ListElement {
                            name: "Red"
                            colorCode: "red"
                        }
                        
                        ListElement {
                            name: "Blue"
                            colorCode: "blue"
                        }
                        
                        ListElement {
                            name: "Green"
                            colorCode: "green"
                        }
                    }
                }
            }
        }
    }
}
