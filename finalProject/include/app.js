//Definitions

//food ingrediants source types
// bitwise:
// 1 - vegan
// 2 - dairy
// 4 - meat
// 8 - fish
VEGAN = 1;
DAIRY = 2;
MEAT = 4;
FISH = 8;

angular.module('kitchenApp', [])

    .controller('mainController', function ($scope) {
    var rec_path = "https://www.diabetes.org/sites/default/files/styles/crop_large/public/2019-06/Healthy%20Food%20Made%20Easy%20-min.jpg";
    var ing_path = "https://image.shutterstock.com/image-photo/red-apple-on-white-background-600w-158989157.jpg";
    var ing_1 = new Ingredient(0, "Banana", "Pc", ing_path, 0);
    var ing_2 = new Ingredient(1, "Apple", "Pc", ing_path, 0);
    var ings = [ing_1, ing_2];
        $scope.recipes = [];
    for (var i = 0; i < 25; i++) {
        $scope.recipes[i] = new Recipe(i, "Mock Recipe Title " + i, 30 + i, rec_path, 3, ings);
    }
    console.log("done with assignment")
    console.log($scope.recipes)
});