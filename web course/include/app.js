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


//Gender Definition
MALE = 0;
FEMALE = 1;

// new recipe form definitions.
index = 0;
angular.module('kitchenApp', []).controller('mainController', function ($scope) {
    //creating fake objects because no database is set up yet.
    var rec_path = "https://www.diabetes.org/sites/default/files/styles/crop_large/public/2019-06/Healthy%20Food%20Made%20Easy%20-min.jpg";
    var ing_path = "https://image.shutterstock.com/image-photo/red-apple-on-white-background-600w-158989157.jpg";
    var ing_1 = new Ingredient(0, "Banana", "Pc", ing_path, 0);
    var ing_2 = new Ingredient(1, "Apple", "Pc", ing_path, 0);
    var admin = new User(0, "Daniel", "Tibi", MALE, new Date(), [0, 1, 2]);
    var ings = [ing_1, ing_2];
    $scope.recipes = [];
    for (var i = 0; i < 25; i++) {
        $scope.recipes[i] = new Recipe(i, "Mock Recipe Title " + i, 30 + i, rec_path, 3, ings, "take 2 eggs scrable and eat",admin);
    }
    $scope.fullStarPath = "https://img.icons8.com/emoji/24/000000/star-emoji.png";
    $scope.emptyStarPath = "https://img.icons8.com/color/24/000000/star--v1.png";
    $scope.range = function (num) {
        var ret = new Array(num);
        for (i = 0; i < num; i++) ret[i] = i;
        return ret;
    }
    $scope.rangeFromTo = function (from, to) {
        var ret = new Array(to - from);
        for (i = 0; i < to - from; i++) {
            ret[i] = from + i;
        }
        return ret;
    }
    console.log("done with assignment");
    console.log($scope.recipes);

});

$(document).on('input', '.directions_inputs', function () {
    alert('Input changed');
});

function new_raw() {
    console.log("new line clicked!");
    markup = '<div id="ing' + index + '" class="ingrediant_container"><input placeholder="Ingrediant Name" />\
            <a href="#" onclick="toggle_ingrediant_type(vegan)"><img src="https://img.icons8.com/material-rounded/24/000000/vegan-food.png"></a>\
            <a href="#" onclick="toggle_ingrediant_type(chicken)"><img src="https://img.icons8.com/material-rounded/24/000000/thanksgiving--v2.png"></a>\
            <a href="#" onclick="toggle_ingrediant_type(dairy)"><img src="https://img.icons8.com/material-rounded/24/000000/cheese.png"></a>\
            <a href="#" onclick="toggle_ingrediant_type(fish)"><img src="https://img.icons8.com/material-rounded/24/000000/fish-food.png"></a>\
            <input placeholder="quantity" />\
            <select class="form-control" style="width:auto;display:inline-block;">\
                <option>Pieces</option> \
                <option>Grams</option> \
                <option>Ounzes</option> \
                <option>cups</option> \
            </select>\
            <a href="#" onclick="del_raw(' + index + ')"><img class="close_window" src="https://img.icons8.com/flat_round/24/000000/minus.png" style="float: right"></a></div>';
    index++;
    $("#divIngrediants").append(markup);
}
function del_raw(i) {
    //TODO: fix this to work with new container metodology
    $("#ing" + i).remove();
}



function close_new_recipe() {
    $(".new_recipe_container").attr("hidden", true);
    console.log("close clicked");
}

function show_new_recipe_form() {
    $(".new_recipe_container").attr("hidden", false);
}

function change_content_to(page_name) {
    switch(page_name) {
        case "Browse":
            $(".recipes_container").attr("hidden", false);
            $(".home").attr("hidden", true);
            $(".categories_page").attr("hidden", true);
            break;
        case "Categories":
            $(".recipes_container").attr("hidden", true);
            $(".home").attr("hidden", true);
            $(".categories_page").attr("hidden", false);
            break;
        case "Home":
            $(".recipes_container").attr("hidden", true);
            $(".home").attr("hidden", false);
            $(".categories_page").attr("hidden", true);
            break;
        case "Favorites":
            break;
        case "Account":
            break;
        case "Search":
            break;
        case "AdvancedSearch":
            break;
        default:
            console.log("default in swtich");
    }
    return;
}