//food ingrediants source types
// bitwise:
VEGAN = 1;
DAIRY = 2;
MEAT = 4;
FISH = 8;


//Gender Definition
MALE = 0;
FEMALE = 1;

class Recipe {
    constructor(id, title, time_to_prepare, path_to_thumbnail, rate, ingredients, description, user) {
        this.id = id;
        this.title = title;
        this.timeToPrepare = time_to_prepare;
        this.pathToThumbnail = path_to_thumbnail;
        this.rate = rate;
        this.ingredients = ingredients
        this.description = description;
        this.user = user;
    }

    containsDairy() {
        for (i = 0; i < this.ingredients.length; i++) {
            if (this.ingredients[i].isDairy()) return true;
        }
        return false;
    }

    isVegan() {
        for (i = 0; i < this.ingredients.length; i++) {
            if (!this.ingredients[i].isVegan()) return false;
        }
        return true;
    }

    containsMeat() {
        for (i = 0; i < this.ingredients.length; i++) {
            if (this.ingredients[i].containsMeat()) return true;
        }
        return false;
    }

    containsFish() {
        for (i = 0; i < this.ingredients.length; i++) {
            if (this.ingredients[i].containsFish()) return true;
        }
        return false;
    }

}


class Ingredient {
    constructor(id, title, defaultUnit, pathToThumbnail, source) {
        this.id = id;
        this.title = title;
        this.defaultUnit = defaultUnit;
        this.pathToThumbnail = pathToThumbnail;
        this.source = source;       //mention if its vegan, meat, dairy, other (bitwise)
    }

    //isVegetarian() {
    //    return this.source & VE;
    //}

    isDairy() {
        return this.source & DAIRY;
    }

    isVegan() {
        return this.source & VEGAN;
    }

    containsMeat() {
        return this.source & MEAT;
    }

    containsFish() {
        return this.source & FISH;
    }
}

class User {
    constructor(id, fname, email, lname, gender, bdate, favoriteRecipes) {
        this.id = id;
        this.firstName = fname;
        this.lastName = lname;
        this.gender = gender;
        this.birthDate = bdate;
        this.favoriteRecipes = favoriteRecipes;
        this.email = email;
    }
}


class SQLController {
    //add function that will get information and update information into sql database.
}