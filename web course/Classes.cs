using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace web_course
{
    public class Recipe
    {
        int id;
        String title;
        int time_to_prepare;
        String path_to_thumbnail;
        int rate;
        Ingredient *ingredients;
        String *description;
        int userid;
        public Recipe(int id, String title, int time_to_prepare, String path_to_thumbnail, int rate, Ingredient *ingredients,String *description, int userid)
        {
            this.id = id;
            this.title = title;
            this.timeToPrepare = time_to_prepare;
            this.pathToThumbnail = path_to_thumbnail;
            this.rate = rate;
            this.ingredients = ingredients;
            this.description = description;
            this.user = user;
        }


        isVegetarian()
        {
            return true;
        }

        isDairy()
        {
            return true;
        }

        isVegan()
        {
            return true;
        }

        containsMeat()
        {
            return true;
        }
    }
    public class Ingredient
    {
        int id;
        String title;
        String defaultUnit;
        String pathToThumbnail;
        int source;

        public Ingredient(int id, String title, String defaultUnit, String pathToThumbnail, int source)
        {
            this.id = id;
            this.title = title;
            this.defaultUnit = defaultUnit;
            this.pathToThumbnail = pathToThumbnail;
            this.source = source;       //mention if its vegan, meat, dairy, other (bitwise)
        }

        isVegetarian()
        {
            return true;
        }

        isDairy()
        {
            return true;
        }

        isVegan()
        {
            return true;
        }

        containsMeat()
        {
            return true;
        }
    }
}