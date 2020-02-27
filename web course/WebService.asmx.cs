using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml;
using System.Xml.Serialization;

namespace web_course
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {

        [WebMethod]
        public string getUserId()
        {
            if(Session != null) return (string) Session["uid"];
            return "null";
        }

        [WebMethod]
        public string getMyStuff()
        {
            XmlSerializer xsSubmit = new XmlSerializer(typeof(List<RecipeDTO>));
            List<RecipeDTO> recipes = new List<RecipeDTO>();
            string xml = "";
            using (var sww = new StringWriter())
            {
                using (XmlWriter writer = XmlWriter.Create(sww))
                {
                    using (var db = new KitchenAppDBEntities())
                    {
                        foreach (Recipe r in db.Recipes.ToList())
                        {
                            List<IngredientDTO> ingrediants = new List<IngredientDTO>();
                            UserDTO u = new UserDTO(r.User.id, r.User.bdate, r.User.email, r.User.name, r.User.isadmin, r.User.gender);
                            foreach (IngredientsInRecipe ing in r.IngredientsInRecipes)
                            {
                                IngredientDTO cur_ing = new IngredientDTO(ing.Ingredient.id, ing.Ingredient.name, ing.Ingredient.unit_type, ing.Ingredient.img_path, ing.Ingredient.source, ing.qty);
                                ingrediants.Add(cur_ing);
                            }
                            RecipeDTO cur_recipe = new RecipeDTO(r.id, r.title.Trim(), r.img_path, r.rate, r.time, r.description.Trim(), ingrediants, u);
                            recipes.Add(cur_recipe);
                        }
                    }
                    xsSubmit.Serialize(writer, recipes);
                    xml = sww.ToString(); // Your XML
                }
            }
            
            return xml;
        }
    }
}
