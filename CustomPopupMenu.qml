import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import QtQuick.Controls.Styles 1.4

Popup {
    id: detailsDialog
    modal: true
    focus: true
    x: 0//(Screen.desktopAvailableWidth - width) / 2
    y: 0//Screen.desktopAvailableHeight / 6
    width: /*Math.min(*/Screen.desktopAvailableWidth/*, Screen.desktopAvailableHeight) / 3 * 2*/
    height: Screen.desktopAvailableHeight// * 2 / 3
    contentHeight: contentRect.height
    //Своиство содержит выбранный item в моделе, для обратной связи
    property Item recipe: Item{}
    //Время приготовления задается в секундах
    property real cookingTime: 0
    
    //Сигнал нажатия кнопки старт
    signal start()
    
    Component.onCompleted: {
        dialogButtonOk.onClicked.connect( start )
    }
    
    contentItem: Rectangle{
        id: contentRect
        anchors.fill: parent
        color: "#f7f7f7"
        
        // Область для сообщения диалогового окна
        Rectangle {
            /* Прибиваем область к левой, правой и верхней частям диалога,
                            * а также снизу к разделителю, который отделяет область от кнопок
                            */
            id: dataRect
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: row.top
            anchors.margins: 10
            anchors.leftMargin: 30
            color: "#f7f7f7"  // Задаём цвет области
            height: childrenRect.height
            
            // Задаём сообщение диалогового окна
            Row {
                id: topLayout
                x: 0; y: 0; height: recipeImage.height; width: parent.width - 40
                spacing: 10
                
                Image {
                    id: recipeImage
                    width: 50; height: 50
                }
                
                Column {
                    width: parent.width - recipeImage.width - 20; height: recipeImage.height
                    spacing: 5
                    
                    Text {
                        id: recipeTitle
                        font.bold: true; font.pointSize: 16
                    }
                }
            }
            
            Row{
                id: rowDivider
                x: 0; y: topLayout.y + topLayout.height; height: 20; width: parent.width - 40
            }
            
            Grid{
                id: details
                
                x: 0; y: rowDivider.y + rowDivider.height; height: 20; width: parent.width - 40
                columns: 4
                spacing: 6
                
                Text { text: qsTr("Ingredients"); width: parent.width / 2; font.pointSize: 12; font.bold: true }
                Text { text: qsTr("Net"); width: parent.width / (2 * 6); font.pointSize: 12; font.bold: true }
                Text { text: qsTr("Processing"); font.pointSize: 12; font.bold: true }
                Text { text: qsTr("Total"); width: parent.width / (2 * 6); font.pointSize: 12; font.bold: true }
                
                //Модель для динамического добавления данных в Grid
                ListModel{
                    id: modelForAdd
                }
                
                Repeater{
                    model: modelForAdd
                    Text{ text: modelData; font.pointSize: 12; font.bold: false }
                }
            }
            
            Row
            {
                id: dividerRow
                x: 0; y: details.y + details.height; 
                height: 2; width: parent.width - 40
                
                Rectangle {
                    color: "#d7d7d7"
                    height: 2
                    width: parent.width
                }
            }
            
            Row
            {
                id: methodRow
                x: 0; y: dividerRow.y + dividerRow.height + parent.height / 2; 
                height: 20; width: parent.width - 40
                
                Text {
                    id: methodTitle
                    text: qsTr("Method")
                    font.pointSize: 12; font.bold: true
                }
            }
            
            Row{
                id: processingRow
                x: 0; y: methodRow.y + methodRow.height; 
                height: parent.height / 2 - methodRow.height; 
                width: parent.width - 40
                
                Text { id: methodText; text: ""; 
                    wrapMode: Text.WordWrap; width: parent.width }
            }
        }
        
        Row {
            id: row
            anchors.margins: 10
            x: 30
            height: 50 // Задаём высоту
            // А также прибиваем строку к низу диалогового окна
            width: parent.width - 40
            anchors.bottom: parent.bottom
            
            Button {
                id: dialogButtonCancel
                // Растягиваем кнопку по высоте строки
                anchors.top: parent.top
                height: 40
                // Задаём ширину кнопки на половину строки минус 1 пиксель
                width: parent.width / 2 - 10
                
                // Стилизуем кнопку
                background: Rectangle {
                        color: "#C62827"
                        border.width: 0
                    }
                
                contentItem: Text {
                    text: qsTr("Cancel")
                    color: "white"
                    // Устанавливаем текст в центр кнопки
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                // По нажатию кнопки закрываем диалог
                onClicked: {
                    detailsDialog.close()
                }
            }
            
            // Создаём разделитель между кнопками шириной в 2 пикселя
            Rectangle {
                id: dividerVertical
                width: 20
                // Растягиваем разделитель по высоте объекта строки
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: "#f7f7f7" // Задаём цвет разделителя
                border.width: 0
            }
            
            Button {
                id: dialogButtonOk
                // Растягиваем кнопку по высоте строки
                anchors.top: parent.top
                height: 40
                // Задаём ширину кнопки на половину строки минус 1 пиксель
                width: parent.width / 2 - 10
                
                // Стилизуем кнопку
                background: Rectangle {
                    color: "#FFC928"
                    border.width: 0
                }
                
                contentItem: Text {
                    text: qsTr("Start")
                    color: "white"
                    // Устанавливаем текст в центр кнопки
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                // По нажатию кнопки закрываем диалог and start cooking
                onClicked: {
                    detailsDialog.recipe.startCooking(detailsDialog.cookingTime)
                    detailsDialog.close()
                }
            }
        }
    }
    
    //Функция отображения диалога с добавлением данных по выбранному рецепту
    function show(title, recipeImg, method, ingredients, item, cookingTime){
        detailsDialog.recipe = item
        detailsDialog.cookingTime = cookingTime
        recipeTitle.text = title
        recipeImage.source = recipeImg
        methodText.text = method
        var obj = JSON.parse(ingredients)
        
        var count = 0;
        for (var k in obj) {
            if (obj.hasOwnProperty(k)) {
                ++count;
            }
        }

        modelForAdd.clear()
        
        for( var i in obj )
        {
            modelForAdd.append( {text: i} )
            
            if ( count > 1 )
            {
                modelForAdd.append( { text: obj[i] } )
                modelForAdd.append( { text: " " } )
                modelForAdd.append( { text: "0" } )
            }
        }

        detailsDialog.open()
    }
}
