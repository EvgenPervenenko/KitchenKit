import QtQuick 2.0

ListModel {
    ListElement {
        title: "Pancakes"
        picture: "pics/pancakes.jpg"
        ingredients: '{"self-raising flour":"1 cup (150g)",
                     "caster sugar":"1 tbs",
                     "milk":"3/4 cup (185ml)",
                     "egg":"1"}'
        method: "<html>
                  <ol, padding: 0>
                   <li> 1.Sift flour and sugar together into a bowl. Add a pinch of salt.
                   <li> 2.Beat milk and egg together, then add to dry ingredients. Beat until smooth.
                   <li> 3.Pour mixture into a pan on medium heat and cook until bubbles appear on the surface.
                   <li> 4.Turn over and cook other side until golden.
                  </ol>
                 </html>"
        cookingTime: 60
        mass: "120 g"
        startTime: "12:45"
        count: 1
    }
    ListElement {
        title: "Fruit Salad"
        picture: "pics/fruit-salad.jpg"
        ingredients: '{"* Seasonal Fruit" : ""}'
        method: "* Chop fruit and place in a bowl."
        cookingTime: 400
        mass: "145 g"
        startTime: "12:45"
        count: 1
    }
    ListElement {
        title: "Vegetable Soup"
        picture: "pics/vegetable-soup.jpg"
        ingredients: '{
                        "onion" : "1", 
                        "turnip": "1", 
                        "potato" : "1", 
                        "carrot" : "1", 
                        "head of celery": "1", 
                        "1/2 litres of water": "1"}'
        method: "<html>
                  <ol>
                   <li> Chop vegetables.
                   <li> Boil in water until vegetables soften.
                   <li> Season with salt and pepper to taste.
                  </ol>
                 </html>"
        cookingTime: 500
        mass: "250 g"
        startTime: "12:45"
        count: 2
    }
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
