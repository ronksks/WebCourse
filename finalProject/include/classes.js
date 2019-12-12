

class Recipe {
    constructor(id, title, time_to_prepare, path_to_thumbnail, rate, ingredients) {
        this.id = id;
        this.title = title;
        this.timeToPrepare = time_to_prepare;
        this.pathToThumbnail = path_to_thumbnail;
        this.rate = rate;
        this.ingredients = ingredients
    }
}


class Ingredient {
    constructor(id, title, defaultUnit, pathToThumbnail) {
        this.id = id;
        this.title = title;
        this.defaultUnit = defaultUnit;
        this.pathToThumbnail = pathToThumbnail;
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