import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.0

ApplicationWindow {
    id: appWindow
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    
    MainForm {
        id:mainForm
        //Диалог с рецептом
        property CustomPopupMenu detailsDialog: CustomPopupMenu{
            id: detailsDialog
            visible: false
        }
        
        Item {
            id: settings
            property var orders: null
            property var ordersContent: null
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
            
            // Список заказов
            ListView {
                //Используется для расчета высоты viewRectangle
                property real headerHeight: 40
                
                id: listView
                anchors.fill: parent
                anchors.margins: 10
                model: ListModel{
                    id: listModel
                    
                    Component.onCompleted: {
                        var content = JSON.parse(model.content);
                        listModel.append({title: content.title, 
                                             qty: content.qty, 
                                             time: content.time, 
                                             comment: content.comment, 
                                             picture: content.picture, 
                                             ingredients: content.ingredients, 
                                             method: content.method, 
                                             cookingTime: content.cookingTime, 
                                             mass: content.mass, 
                                             startTime: content.startTime, 
                                             count: content.count
                                         })
                        
                        settings.orders["on" + model.order_number].contentModel = listModel;
                    }
                }
                
                CustomListDelegate{
                    id: customDelegate
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
                            id: orderNumber
                            width: parent.width / 2
                            renderType: Text.NativeRendering
                            text: "№" + mainModel.count
                            font.bold: true; font.pointSize: 16
                        }
                        
                        Text {
                            id: orderInfo
                            width: parent.width / 2
                            color: "#696969"
                            renderType: Text.NativeRendering
                            text: " "
                        }
                    }
                    
                    Component.onCompleted: {
                        var content = JSON.parse(model.content);
                        orderInfo.text = qsTr("Nick") + "\n" + qsTr("Table ") + content.table_number
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
        
        //Главная модель для добавления заказов
        listView1.model: ListModel{
            id: mainModel
        }
        
        //Функция показывает диалог с деталями заказа
        function showDialog(title, recipeImg, method, ingredients, item, cookingTime){
            detailsDialog.show(title, recipeImg, method, ingredients, item, cookingTime)
        }
        
        Connections {
            target: tcpServer
            onNewOrderContentTask: {
                if(settings.orders === null)
                    settings.orders = {};
                
                if(typeof settings.orders["on" + orderItem.order_number] === 'undefined') {
                    settings.orders["on"+orderItem.order_number] = {order_number: orderItem.order_number, content: [orderItem]};
                    mainModel.append({order_number: orderItem.order_number, content: JSON.stringify(orderItem)});
                } else {
                    settings.orders["on" + orderItem.order_number].content.push(orderItem);
                    settings.orders["on" + orderItem.order_number].contentModel.append({title: orderItem.title, 
                                                                                           qty: orderItem.qty, 
                                                                                           time: orderItem.time, 
                                                                                           comment: orderItem.comment, 
                                                                                           picture: orderItem.picture, 
                                                                                           ingredients: orderItem.ingredients, 
                                                                                           method: orderItem.method, 
                                                                                           cookingTime: orderItem.cookingTime, 
                                                                                           mass: orderItem.mass, 
                                                                                           startTime: orderItem.startTime, 
                                                                                           count: orderItem.count, 
                                                                                           table_number: orderItem.table_number
                                                                                       })
                }
            }
        }
    }
    
}
