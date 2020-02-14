//Definitions

// new recipe form definitions.
ingredient_index = 0;      // index of ingrediant count
directions_index = 0;      // index of directions count
//food ingrediants source types
// bitwise:
VEGAN = 1;
DAIRY = 2;
MEAT = 4;
FISH = 8;


//angular.module('kitchenApp', []).controller('mainController', function ($scope) {
    //creating fake objects because no database is set up yet.
    //var rec_path = "https://www.diabetes.org/sites/default/files/styles/crop_large/public/2019-06/Healthy%20Food%20Made%20Easy%20-min.jpg";
    //var ing_path = "https://image.shutterstock.com/image-photo/red-apple-on-white-background-600w-158989157.jpg";
    //var ing_1 = new Ingredient(0, "Banana", "Pc", ing_path, 0);
    //var ing_2 = new Ingredient(1, "Apple", "Pc", ing_path, 0);
    //var admin = new User(0, "Daniel", "Tibi", MALE, new Date(), [0, 1, 2]);
    //var ings = [ing_1, ing_2];
    //$scope.recipes = [];
    //for (var i = 0; i < 25; i++) {
    //    $scope.recipes[i] = new Recipe(i, "Mock Recipe Title " + i, 30 + i, rec_path, 3, ings, "take 2 eggs scrable and eat",admin);
    //}
    //$scope.fullStarPath = "https://img.icons8.com/emoji/24/000000/star-emoji.png";
    //$scope.emptyStarPath = "https://img.icons8.com/color/24/000000/star--v1.png";
    //console.log("done with assignment");
    //console.log($scope.recipes);
    //$scope.range = function (num) {
    //    var ret = new Array(num);
    //    for (i = 0; i < num; i++) ret[i] = i;
    //    return ret;
    //}
    //$scope.rangeFromTo = function (from, to) {
    //    var ret = new Array(to - from);
    //    for (i = 0; i < to - from; i++) {
    //        ret[i] = from + i;
    //    }
    //    return ret;
    //}
//});

$(document).ready(function () {
    console.log("Document ready");
    arrange_ingrediants("init");
    change_content_to(localStorage["CurrentViewName"]);
    $(".rate-stars").hover(function () {
        id = $(this).attr("id").split('-')[1];
        for (i = 1; i <= 5; i++) {
            if (i <= id) {
                $("#star-" + i).attr("src", "/images/fullStar.png");
            } else {
                $("#star-" + i).attr("src", "/images/emptyStar.png");
            }
        }
    })
    //if (localStorage["NewRecipeWindow"] == "true") {
    //    show_new_recipe_form()
    //} else {
    //    close_new_recipe()
    //}
});

function arrange_directions(i) {
    console.log(directions_index);
    var latest_directions = $("#txtDirections" + directions_index);
    //if latest direction is empty remove it
    if (directions_index > 0) {
        var latest_val = latest_directions.val().trim();
        var before_latest_val = $("#txtDirections" + (directions_index - 1)).val().trim();
        if (latest_val == "" && before_latest_val == "") {
            $("#divDirections" + directions_index).remove();
            directions_index--;
            return;
        }
    }
    //if latest direction is full. make sure there is a new direction available for filling
    if (latest_directions.val().trim() != "") {
        directions_index++;
        var header = "";
        var num = directions_index + 1;
        if (num % 10 == 1) {
            header = num + "st Step";
        } else if (num % 10 == 2) {
            header = num + "nd Step";
        } else if (num % 10 == 3) {
            header = num + "rd Step";
        } else {
            header = num + "th Step";
        }
        var mark = '<div id="divDirections' + directions_index + '" class="card text-white bg-primary mb-3">\
            <div class="card-header"> ' + header + '</div >\
                <div class="card-body">\
                    <p class="card-text">\
                        <textarea id="txtDirections' + directions_index + '" class="directions_inputs" onkeyup="arrange_directions(' + directions_index + ')" ></textarea>\
                    </p>\
                </div>\
                    </div >';
        $("#directions").append(mark);
    }
}

function arrange_ingrediants(init) {
    console.log(init + ingredient_index)
    var latest_ingrediant = $("#txtIngrediant" + ingredient_index)
    //if latest direction is empty remove it
    if (init != "init" && ingredient_index > 0 ) {
        var latest_val = latest_ingrediant.val().trim();
        var before_latest_val = $("#txtIngrediant" + (ingredient_index - 1)).val().trim();
        if (latest_val == "" && before_latest_val == "") {
            //TODO: add while loop to remove all emptys until accurate
            $("#divIngrediant" + ingredient_index).remove();
            ingredient_index--;
            return;
        }
    }
    //if there is no Ingrediants at all or if latest Ingrediants is full. make sure there is a new ingrediant available for filling
    if (init == "init" || latest_ingrediant.val().trim() != "") {
        if (init != "init") {
            ingredient_index++
        }
        var header = "";
        var num = ingredient_index + 1;
        if (num % 10 == 1) {
            header = num + "st";
        } else if (num % 10 == 2) {
            header = num + "nd";
        } else if (num % 10 == 3) {
            header = num + "rd";
        } else {
            header = num + "th";
        }
        markup = '<div id="divIngrediant' + ingredient_index + '" class="ingrediant_container card border-primary mb-3">\
                    <div class="card-body">\
                        <label style="width:60px;">' + header + '</label>\
                        <input class="ingrediant_input_text" id="txtIngrediant' + ingredient_index + '" placeholder="Ingrediant Name" onkeyup="arrange_ingrediants(' + ingredient_index + ')" />\
                        <a href="#" onclick="toggle_ingrediant_type(\'vegan\',' + ingredient_index + ')">\
                        <img id="vegan_' + ingredient_index + '" alt="vegan" src="/images/icons8-vegan-food-24-toggle_off.png"/></a>\
                        <a href="#" onclick="toggle_ingrediant_type(\'chicken\',' + ingredient_index + ')">\
                        <img id="chicken_' + ingredient_index + '" alt="meat or chicken" src="/images/icons8-thanksgiving-24-toggle_off.png"/></a>\
                        <a href="#" onclick="toggle_ingrediant_type(\'dairy\',' + ingredient_index + ')">\
                        <img id="dairy_' + ingredient_index + '" alt="dairy" src="/images/icons8-cheese-24-toggle_off.png"/></a>\
                        <a href="#" onclick="toggle_ingrediant_type(\'fish\',' + ingredient_index + ')">\
                        <img id="fish_' + ingredient_index + '" alt="fish" src="/images/icons8-fish-food-24-toggle_off.png"/></a>\
                        <input id="txtQuantity' + ingredient_index + '" placeholder="quantity" style="width:60px;border-radius:8px;" onkeyup="organize_ingrediants_for_server()"/>\
                        <select id="slQuantityUnit' + ingredient_index + '" runat="server" "class="form-control" style="width:auto;display:inline-block;">\
                            <option>Pieces</option> \
                            <option>Grams</option> \
                            <option>Ounzes</option> \
                            <option>cups</option> \
                        </select>\
                    </div>\
                </div>';
        $("#divIngrediants").append(markup);
    }
    organize_ingrediants_for_server()
    return;
}

function organize_ingrediants_for_server() {
    var textbox = [];
    var serverTextBox = $("#txtIngrediants");
    var regex = RegExp("toggle_on");
    var qty = 0;
    var pcs = 0;
    serverTextBox.val("");
    for (i = 0, real_index = 0; i < ingredient_index; i++) {
        textbox = $("#txtIngrediant" + i);
        console.log("if (" + textbox.val() + ")");
        if (textbox.val() != "") {
            var source = 0x00;
            console.log("true");
            //check which toggled ingrediant is on/off
            if (regex.test($("#vegan_" + i).attr("src"))) { source = source | VEGAN; }
            if (regex.test($("#chicken_" + i).attr("src"))) { source = source | MEAT; }
            if (regex.test($("#dairy_" + i).attr("src"))) { source = source | DAIRY; }
            if (regex.test($("#fish_" + i).attr("src"))) { source = source | FISH; }
            qty = $("#txtQuantity" + i).val();
            pcs = $("#slQuantityUnit" + i).val();
            serverTextBox.val("" + serverTextBox.val() + "|" + real_index + "," + textbox.val().trim() + "," + source + "," + qty + "," + pcs);
            real_index++;
        }
    }
}

function toggle_ingrediant_type(type, index) {
    img_id = "#" + type + "_" + index;
    console.log(img_id);
    if ($(img_id).attr("src").search("toggle_off") != -1) {
        $(img_id).attr("src", $(img_id).attr("src").replace("toggle_off", "toggle_on"));
    } else if ($(img_id).attr("src").search("toggle_on") != -1) {
        $(img_id).attr("src", $(img_id).attr("src").replace("toggle_on", "toggle_off"));
    }
    organize_ingrediants_for_server()
    return;
}

function close_new_recipe() {
    localStorage["NewRecipeWindow"] = false;
    $(".new_recipe_container").attr("hidden", true);
}

function close_account_floaty() {
    $(".floating-account-info").attr("hidden", true);
}

function show_new_recipe_form() {
    console.log("showing new recipe form");
    localStorage["NewRecipeWindow"] = true;
    $(".new_recipe_container").attr("hidden", false);
}

function category_click(catName) {
    __doPostBack('category_panel', catName);
}

function change_content_to(page_name) {
    switch(page_name) {
        case "Browse":
            localStorage["CurrentViewName"] = "Browse";
            $(".recipes_container").attr("hidden", false);
            $(".home").attr("hidden", true);
            $(".categories_page").attr("hidden", true);
            break;
        case "Categories":
            localStorage["CurrentViewName"] = "Categories";
            $(".recipes_container").attr("hidden", true);
            $(".home").attr("hidden", true);
            $(".categories_page").attr("hidden", false);
            break;
        case "Home":
            localStorage["CurrentViewName"] = "Home";
            $(".recipes_container").attr("hidden", true);
            $(".home").attr("hidden", false);
            $(".categories_page").attr("hidden", true);
            break;
        case "Favorites":
            localStorage["CurrentViewName"] = "Favorites";
            break;
        case "Account":
            $(".floating-account-info").attr("hidden", false);
            break;
        case "Search":
            localStorage["CurrentViewName"] = "Search";
            break;
        case "AdvancedSearch":
            localStorage["CurrentViewName"] = "AdvancedSearch";
            break;
        default:
            console.log("default in swtich");
    }
    return;
}