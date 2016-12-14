import QtQuick 2.0

ListModel {
    ListElement {
        title: "Hamburger"
        picture: "pics/hamburger.jpg"
        ingredients: '{
                        "minced beef" : "500g", 
                        "Seasoning" : " ", 
                        "lettuce, tomato, onion, cheese" : " ", 
                        "hamburger bun for each burger" : "1"}'
        method: "<html>
                  <ol>
                   <li> Mix the beef, together with seasoning, in a food processor.
                   <li> Shape the beef into burgers.
                   <li> Grill the burgers for about 5 mins on each side (until cooked through)
                   <li> Serve each burger on a bun with ketchup, cheese, lettuce, tomato and onion.
                  </ol>
                 </html>"
        cookingTime: 600
        mass: "250 g"
        startTime: "12:45"
        count: 2
    }
    ListElement {
        title: "Lemonade"
        picture: "pics/lemonade.jpg"
        ingredients: '{
                        "cup Lemon Juice" : "1", 
                        "cup Sugar" : "1", 
                        "Cups of Water (2 cups warm water, 4 cups cold water)" : "6" 
                       }'
        method: "<html>
                  <ol>
                   <li> Pour 2 cups of warm water into a pitcher and stir in sugar until it dissolves.
                   <li> Pour in lemon juice, stir again, and add 4 cups of cold water.
                   <li> Chill or serve over ice cubes.
                  </ol>
                 </html>"
        cookingTime: 700
        mass: "200 g"
        startTime: "12:45"
        count: 3
    }
}
