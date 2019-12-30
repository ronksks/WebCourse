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

    isVegetarian() {
        return true;
    }

    isDairy() {
        return true;
    }

    isVegan() {
        return true;
    }

    containsMeat() {
        return true;
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

    isVegetarian() {
        return true;
    }

    isDairy() {
        return true;
    }

    isVegan() {
        return true;
    }

    containsMeat() {
        return true;
    }

}

class User {
    constructor(id, fname, lname, gender, bdate, favoriteRecipes) {
        this.id = id;
        this.firstName = fname;
        this.lastName = lname;
        this.gender = gender;
        this.birthDate = bdate;
        this.favoriteRecipes = favoriteRecipes;
    }
}


class SQLController {
    //add function that will get information and update information into sql database.
}