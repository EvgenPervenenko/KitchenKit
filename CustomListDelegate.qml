import QtQuick 2.0
import QtQuick.Controls 1.4

// Делегат для заказа
Component {
    id: recipeDelegate
    
    //! [0]
    Item {
        id: recipe
        width: parent.width
        height: 100
        
        // Rect делегата
        Rectangle {
            id: background
            x: 2; y: 2; width: parent.width - x * 2; 
            height: parent.height - y * 2
            color: "white"
            //                radius: 5
            
            //Строка с названием блюда и порядковым номером
            Grid {
                id: topLayout
                x: background.x; y: background.y; 
                height: recipe.height / 2; width: parent.width
                columns: 4
                spacing: 10
                
                Item {
                    id: recipeIndex
                    width: indexText.width; height: topLayout.height
                    
                    Text{ id: indexText; anchors.centerIn: parent; 
                        text : model.data[index].count ; font.bold: true; 
                        font.pointSize: 14 }
                }
                
                Item{
                    id: titleItem
                    width: titleText.width; height: topLayout.height
                    
                    Text {
                        id: titleText
                        anchors.centerIn: parent
                        text: model.data[index].title
                        font.bold: false; font.pointSize: 12
                    }
                }
                
                Item{
                    id: massItem
                    width: massText.width; height: topLayout.height
                    
                    Text {
                        id: massText
                        anchors.centerIn: parent
                        text: model.data[index].mass
                        font.bold: false; font.pointSize: 12
                    }
                }
                
                Item{
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 5
                    
                    Text {
                        id: startTimeText
                        anchors.top: parent.top
                        anchors.right: parent.right
                        text: model.data[index].startTime
                        font.bold: false; font.pointSize: 8
                    }
                }
            }
            
            //Строка с кнопкой
            Grid
            {
                id: buttonGrid
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.top: topLayout.bottom
                columns: 2
                spacing: 0
                
                Rectangle{
                    id: stateButton
                    x: 2
                    width: (parent.width - x * 2 )// * 2 / 3
                    height: parent.height
                    color: "#FFC928"
                    
                    Text {
                        id: stateButtonText
                        text: qsTr("Start")
                        font.bold: false; font.pointSize: 12
                        anchors.centerIn: parent
                        color: "white"
                    }
                }
                
                Rectangle{
                    id: timeRect
                    width: 0//(parent.width - x * 2 ) * 1 / 3
                    height: parent.height
                    color: "#969696"
                    
                    Text{
                        id: timerText
                        anchors.centerIn: parent
                        color: "white"
                    }
                }
            }
        }
        
        
        //Area для вызова диалога
        MouseArea {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            height: topLayout.height
            onClicked: {detailsDialog.show(model.data[index].title, 
                                           model.data[index].picture, 
                                           model.data[index].method, 
                                           model.data[index].ingredients)}
        }
        
        //Area для старта задачи
        MouseArea {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            height: buttonGrid.height
            onClicked: {startCooking(model.data[index].cookingTime)}
        }
        
        //Диалог с рецептом
        CustomDialog{
            id: detailsDialog
            onStart: recipe.startCooking(model.data[index].cookingTime)
        }
        
        //Таймер для отсчета момента готовности блюда
        Timer{
            id: timer
            interval: 1000; running: false; repeat: true;
            onTriggered: { 
                var hms = timerText.text
                '02:04:33';   // your input string
                var a = hms.split(':'); // split it at the colons
                
                // minutes are worth 60 seconds. Hours are worth 60 minutes.
                var seconds = (+a[0]) * 60 * 60 + (+a[1]) * 60 + (+a[2]);
                
                if ( ( seconds - 1 ) < 1 )
                {
                    timerText.text = ""
                    timeRect.width = 0
                    stateButton.width = parent.width - x * 2
                    timer.stop()
                }
                else
                {
                    timerText.text = getTimeString( seconds - 1 )
                }
            }
        }
        
        //Функция запуска готовки
        function startCooking( time ){
            stateButton.color = "#54D210";
            stateButtonText.text = qsTr("Ready")
            timerText.text = getTimeString( time )
            timeRect.width = stateButton.width * 1 / 3
            stateButton.width = stateButton.width * 2 / 3
            timer.start()
        }
        
        //функция перевода секунд в строку времени
        function getTimeString( sec_num ) {
            var hours   = Math.floor(sec_num / 3600);
            var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
            var seconds = sec_num - (hours * 3600) - (minutes * 60);
            
            if (hours   < 10) {hours   = "0"+hours;}
            if (minutes < 10) {minutes = "0"+minutes;}
            if (seconds < 10) {seconds = "0"+seconds;}
            return hours+':'+minutes+':'+seconds;
        }
    }
}
