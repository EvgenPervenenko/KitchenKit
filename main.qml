import QtQuick 2.6
import QtQuick.Controls 1.5
import QtQuick.Window 2.0

ApplicationWindow {
    id: appWindow
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    property MouseArea mouseArea: MouseArea{}
    
    MainForm {
        id:mainForm
        Component.onCompleted: {
            appWindow.mouseArea = mouseArea1
        }
        
        anchors.fill: parent
        listView1.orientation: Qt.Horizontal
        listView1.spacing: 10
        listView1.delegate:
            Rectangle{
            id: viewRectangle
            anchors.leftMargin: 10
            anchors.top: parent.top
            height: parent.height
            width : 310
            color: "#E2E2E2"
            signal clicked(var x, var y)
            
//            Component.onCompleted:{
//                appWindow.mouseArea.clicked.connect( viewRectangle.onClicked )
//            }
            
            // Список заказов
            ListView {
                //Используется для расчета высоты viewRectangle
                property real headerHeight: 40
                
                id: listView
                anchors.fill: parent
                anchors.margins: 10
                model: listViewModel
                CustomListDelegate{
                    id: customDelegate
                    
//                    Component.onCompleted: {
//                        viewRectangle.clicked.connect( customDelegate.globalClick )
//                    }
                }
                delegate: customDelegate.component
                spacing: 10
                
                header: Rectangle{
                    width: parent.width
                    height: listView.headerHeight
                    color: viewRectangle.color
                    
                    Grid{
                        id: headerLayout
                        anchors.fill: parent
                        columns: 2
                        spacing: 10
                        
                        Text {
                            width: parent.width / 2
                            renderType: Text.NativeRendering
                            text: "№301"
                            font.bold: true; font.pointSize: 16
                        }
                        
                        Text {
                            width: parent.width / 2
                            color: "#696969"
                            renderType: Text.NativeRendering
                            text: qsTr("Nick") + "\n" + qsTr("Table 7")
                        }
                    }
                }
                
                onCountChanged: {
                    //Установка высоты listView1.delegate(viewRectangle) динамически
                    var root = listView.visibleChildren[0]
                    
                    if( root.visibleChildren.length > 0 ){
                        var itemHeight = root.visibleChildren[root.visibleChildren.length - 1].height
                        var itemCount = listView.model.count
                        var headerHeight = listView.headerHeight
                        var listViewHeight = itemHeight * itemCount 
                                + listView.spacing * (itemCount + 1) 
                                + headerHeight
                        
                        viewRectangle.height = listViewHeight
                    }
                }
                
            }
            
            function onClicked(){
                clicked( appWindow.mouseArea.mouseX, appWindow.mouseArea.mouseY )
            }
        }
        
        listView1.model: ListModel{
            id: mainModel
        }
        
        RecipesModel{
            id: testModel
        }
        
        RecipesModel2{
            id: testModel2
        }
        
        button1.onClicked:{
            addOrder( testModel )
            addOrder( testModel2 )
        }
        
        function addOrder( modelForView ){
            mainModel.append( ( {listViewModel: modelForView} ) )
        }
        
        //чтобы не перехватывались клики
        mouseArea1.visible: false
    }
}
