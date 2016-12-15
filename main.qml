import QtQuick 2.6
import QtQuick.Controls 1.5

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    
    Connections{
        target: sender
        
        onSend: {
            addOrder( model )
        }
    }
    
    MainForm {
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
            
            // Список заказов
            ListView {
                //Используется для расчета высоты viewRectangle
                property real headerHeight: 40
                
                id: listView
                anchors.fill: parent
                anchors.margins: 10
                model: listViewModel
                delegate: CustomListDelegate{}
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
                        var itemCount = listView.model.data.length
                        var headerHeight = listView.headerHeight
                        var listViewHeight = itemHeight * itemCount 
                                + listView.spacing * (itemCount + 1) 
                                + headerHeight
                        
                        viewRectangle.height = listViewHeight
                    }
                    else
                    {
                        //Если один элемент или элементов нет
                        var delegateHeight = 100
                        listViewHeight = delegateHeight
                                + listView.spacing * 2
                                + listView.headerHeight
                        
                        viewRectangle.height = listViewHeight
                    }
                }
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
        
//        button1.onClicked:{
//            addOrder( testModel )
//            addOrder( testModel2 )
//        }
    }
    
    function addOrder( modelForView ){
        mainModel.append( ( {listViewModel: modelForView} ) )
    }
}
