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

var all_recipes = []
var recipes_hash = {}
var loggedUser = "null";

var app = angular.module('app', []);
app.controller('ctrl', function ($scope, $http) {
    angular.element(document).ready(function () {
        if (typeof localStorage["recipe_view"] !== 'undefined') {
            $scope.view = JSON.parse(localStorage["recipe_view"]);
        } else {
            $scope.view = new Recipe(999, "title", 99, "/images/icons8-circle-16.png", 3, [], "description", new User(999, "moshe", "no@email.com", "cohen", 0, null, null));
            localStorage["recipe_view"] = JSON.stringify($scope.view);
        }
        
        $scope.recipes = []
        $scope.fullStarPath = "/images/fullStar.png";
        $scope.emptyStarPath = "/images/emptyStar.png";
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

        $scope.getChickenIcon = function (state) {
            if (state) {
                return "/images/icons8-thanksgiving-24-toggle_on.png";
            } else {
                return "/images/icons8-thanksgiving-24-toggle_off.png";
            }
        }
        $scope.getVeganIcon = function (state) {
            if (state) {
                return "/images/icons8-vegan-food-24-toggle_on.png";
            } else {
                return "/images/icons8-vegan-food-24-toggle_off.png";
            }
        }
        $scope.getDairyIcon = function (state) {
            if (state) {
                return "/images/icons8-cheese-24-toggle_on.png";
            } else {
                return "/images/icons8-cheese-24-toggle_off.png";
            }
        }
        $scope.getFishIcon = function (state) {
            if (state) {
                return "/images/icons8-fish-food-24-toggle_on.png";
            } else {
                return "/images/icons8-fish-food-24-toggle_off.png";
            }
        }

        var url = 'webservice.asmx/getMyStuff';
        $http.get(url, null).then(
            function (res) {
                localStorage["user_id"] = $("#txtUserId").val();
                var x2js = new X2JS();
                all_recipes = x2js.xml_str2json(x2js.xml_str2json(res.data).string.__text).ArrayOfRecipeDTO.RecipeDTO
                $scope.recipes = [];
                $scope.allRecipes = [];
                all_recipes.forEach(function (element, j) {
                    recipe_ings = [];
                    ing_arr = [];
                    if (element.IngredientsInRecipes.IngredientDTO != 'undefined')
                        ing_arr = element.IngredientsInRecipes.IngredientDTO;
                    len = ing_arr == undefined ? 0 : ing_arr.length;
                    for (i = 0; i < len; i++) {
                        recipe_ings.push(new Ingredient(ing_arr[i].id, ing_arr[i].name, ing_arr[i].unit_type, ing_arr[i].qty, ing_arr[i].source));
                    }
                    rcp = new Recipe(element.id, element.title, element.time, element.img_path, element.rate, recipe_ings, element.description, element.owner);
                    $scope.allRecipes.push(rcp);
                    if (element.owner.id == localStorage["user_id"])
                        $scope.recipes.push(rcp);
                });
                all_recipes = $scope.allRecipes;
                console.log("scope recipes: " + $scope.allRecipes);
                hash_all_recepies()
            },
            function (er) {
                console.log("error:")
                console.log(er);
            });
        $scope.showRecipeASP = function (id) {
            mock_element = { recipe: findRecipe(id) };
            $scope.showRecipe(mock_element);
        }
        $scope.showRecipe = function (element) {
            $scope.view = element.recipe;
            localStorage["recipe_view"] = JSON.stringify($scope.view);
            change_content_to("recipe_view");
        }
        $scope.showIngrediants = function (ingredients) {
            if (typeof ingredients !== 'undefined') {
                $("#ingredients_view").empty();
                ingredients.forEach(function (e, i) {
                    $("#ingredients_view").append("<span class='ingredient'>" + e.qty + " " + e.defaultUnit + " - " + e.title + "</span>");
                });
            }
        }
    })
});


$(document).ready(function () {
    console.log("Document ready");
    arrange_ingrediants("init");
    localStorage["user_id"] = $("#txtUserId").val();
    $(".rate-stars").hover(function () {
        id = $(this).attr("id").split('-')[1];
        show_stars_edit_recipe(id);
        organize_rate_for_server(id);
    });
    search_term = $("#txtSearch").val();
    console.log("search_term: " + search_term);
    if (search_term != "") {
        change_content_to("Search");
    } else {
        if (localStorage["CurrentViewName"] != "Search") {
            change_content_to(localStorage["CurrentViewName"]);
        } else {
            change_content_to("Home");
        }
    }
});

function update_my_recipes() {
    $http = angular.injector(["ng"]).get("$http");
    var url = 'webservice.asmx/getMyStuff';
    $http.get(url, null).then(
        function (res) {
            localStorage["user_id"] = $("#txtUserId").val();
            var x2js = new X2JS();
            recipes = x2js.xml_str2json(x2js.xml_str2json(res.data).string.__text).ArrayOfRecipeDTO.RecipeDTO
            angular.element($("#txtUserId")).scope().recipes = [];
            recipes.forEach(function (element, j) {
                if (element.owner.id != localStorage["user_id"]) return;
                recipe_ings = [];
                ing_arr = [];
                if (element.IngredientsInRecipes.IngredientDTO != 'undefined')
                    ing_arr = element.IngredientsInRecipes.IngredientDTO;
                len = ing_arr == undefined ? 0 : ing_arr.length;
                for (i = 0; i < len; i++) {
                    recipe_ings.push(new Ingredient(ing_arr[i].id, ing_arr[i].name, ing_arr[i].unit_type, ing_arr[i].qty, ing_arr[i].source));
                }
                angular.element($("#txtUserId")).scope().recipes.push(new Recipe(element.id, element.title, element.time, element.img_path, element.rate, recipe_ings, element.description, element.owner));
            });
            console.log("scope recipes: " + angular.element($("#txtUserId")).scope().recipes);
        },
        function (er) {
            console.log("error:")
            console.log(er);
        });
    angular.element($("#txtUserId")).scope().$apply();
}

function findRecipe(id) {
    return recipes_hash[id];
}
function show_stars_edit_recipe(rate) {
    for (i = 1; i <= 5; i++) {
        if (i <= rate) {
            $("#star-" + i).attr("src", "/images/fullStar.png");
        } else {
            $("#star-" + i).attr("src", "/images/emptyStar.png");
        }
    }
}

function hash_all_recepies() {
    console.log("all recipes" + all_recipes);
    all_recipes.forEach(element => recipes_hash[element.id] = element);
}

function editImage_Clicked_ng(element) {
    if (element.id != undefined) {
        editImage_Clicked(element.id.trim());
    } else if (element.attr != undefined)  {
        editImage_Clicked(element.attr("id").trim());
    }
    
}

function editImage_Clicked(id) {
    edit_recipe = recipes_hash[id];
    console.log("about to edit recipe: " + edit_recipe.title);
    $("#btnRemove").attr("hidden", false);
    show_new_recipe_form();
    $("#txtEditModeId").val(id);
    $("#txtRecipeName").val(edit_recipe.title);
    $("#txtTime").val(edit_recipe.timeToPrepare);
    $("#txtRate").val(edit_recipe.rate);
    $("#current_image_container").append("<img src='" + edit_recipe.pathToThumbnail + "' id='recipe_image' />");
    show_stars_edit_recipe(edit_recipe.rate);
    edit_recipe.ingredients.forEach(function (e, i) {
        console.log(e);
        $("#txtIngrediant" + i).val(e.title);
        if (e.isVegan() != 0) { toggle_ingrediant_type("vegan", i); }
        if (e.containsMeat() != 0) { toggle_ingrediant_type("chicken", i); }
        if (e.containsFish() != 0) { toggle_ingrediant_type("fish", i); }
        if (e.isDairy() != 0) { toggle_ingrediant_type("dairy", i); }
        $("#txtQuantity" + i).val(e.qty);
        $("#slQuantityUnit" + i).val(e.defaultUnit);
        arrange_ingrediants("synthetic");
    });
    organize_ingrediants_for_server();
    $("#txtDirections0").val(edit_recipe.description);
    $("#txtEditRecipeID").val(edit_recipe.id);
    $("#btnSubmit").val("Update");
}


//function arrange_directions(i) {
//    console.log(directions_index);
//    var latest_directions = $("#txtDirections" + directions_index);
//    //if latest direction is empty remove it
//    if (directions_index > 0) {
//        var latest_val = latest_directions.val().trim();
//        var before_latest_val = $("#txtDirections" + (directions_index - 1)).val().trim();
//        if (latest_val == "" && before_latest_val == "") {
//            $("#divDirections" + directions_index).remove();
//            directions_index--;
//            return;
//        }
//    }
//    //if latest direction is full. make sure there is a new direction available for filling
//    if (latest_directions.val().trim() != "") {
//        directions_index++;
//        var header = "";
//        var num = directions_index + 1;
//        if (num % 10 == 1) {
//            header = num + "st Step";
//        } else if (num % 10 == 2) {
//            header = num + "nd Step";
//        } else if (num % 10 == 3) {
//            header = num + "rd Step";
//        } else {
//            header = num + "th Step";
//        }
//        var mark = '<div id="divDirections' + directions_index + '" class="card text-white bg-primary mb-3">\
//            <div class="card-header"> ' + header + '</div >\
//                <div class="card-body">\
//                    <p class="card-text">\
//                        <textarea id="txtDirections' + directions_index + '" class="directions_inputs" onkeyup="arrange_directions(' + directions_index + ')" ></textarea>\
//                    </p>\
//                </div>\
//                    </div >';
//        $("#directions").append(mark);
//    }
//}

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

function organize_rate_for_server(rate) {
    $("#txtRate").val(rate);
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
    $("#recipe_image").remove();
    $("#txtEditModeId").val("");
    $("#txtRecipeName").val("");
    $("#txtTime").val("");
    $("#txtRate").val("");
    $("#current_image_container").empty();
    show_stars_edit_recipe(1);
    for (i = ingredient_index; i >= 0; i--) {
        $("#txtIngrediant" + i).val("");
        $("#txtQuantity" + i).val("");
        arrange_ingrediants("synthetic");
    };
    organize_ingrediants_for_server();
    $("#txtDirections0").val("");
    $("#txtEditRecipeID").val("");
    $("#btnSubmit").val("Submit");
}

function close_account_floaty() {
    $(".floating-account-info").attr("hidden", true);
    $("#btnRemove").attr("hidden", true);
    $("#txtEditRecipeID").val("");
}

function show_new_recipe_form() {
    console.log("showing new recipe form");
    localStorage["NewRecipeWindow"] = true;
    $(".new_recipe_container").attr("hidden", false);
}

function category_click(catName) {
    __doPostBack('category_panel', catName);
}

var content_names = [".recipes_container", ".home", ".categories_page", ".search_results", ".my_recipes_container", ".recipe_view"]

function change_content_to(page_name) {
    switch(page_name) {
        case "Browse":
            localStorage["CurrentViewName"] = "Browse";
            content_names.forEach(element => $(element).attr("hidden", true));
            $(".recipes_container").attr("hidden", false);
            break;
        case "Categories":
            localStorage["CurrentViewName"] = "Categories";
            content_names.forEach(element => $(element).attr("hidden", true));
            $(".categories_page").attr("hidden", false);
            break;
        case "Home":
        case "sign_in":
        case "recover":
        case "register":
            localStorage["CurrentViewName"] = "Home";
            content_names.forEach(element => $(element).attr("hidden", true));
            $(".home").attr("hidden", false);
            break;
        case "Account":
            $(".floating-account-info").attr("hidden", false);
            break;
        case "Search":
            localStorage["CurrentViewName"] = "Search";
            content_names.forEach(element => $(element).attr("hidden", true));
            $(".search_results").attr("hidden", false);
            break;
        case "manage_recipes":
            localStorage["CurrentViewName"] = "manage_recipes";
            content_names.forEach(element => $(element).attr("hidden", true));
            $(".my_recipes_container").attr("hidden", false);
            update_my_recipes();
            break;
        case "recipe_view":
            localStorage["CurrentViewName"] = "recipe_view";
            content_names.forEach(element => $(element).attr("hidden", true));
            $(".recipe_view").attr("hidden", false);
            break;

        default:
            alert("unhandled currentViewName " + localStorage["CurrentViewName"] );
    }
    $("#txtSearch").val("");
    return;
}