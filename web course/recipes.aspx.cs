using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace web_course
{
    public partial class recipes : System.Web.UI.Page
    {
        //ibtnSearch_Click
        //txtSearch
        //fileuploadRecipeThumb
        //txtQuantity
        //ddlCategory
        //txtRecipeName
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loggedIn())
            {
                ltLoginStatus.Text = String.Empty;
                hlLoginLink.Visible = false;
                btnSignOut.Visible = true;
                hlLoginLink2.Visible = false;
                pnlNewRecipeForm.Visible = true;
                ltUserName.Text = (String)Session["name"];
            }
            else
            {
                setGuestFloaty();
            }

            using (var db = new KitchenAppDBEntities())
            {
                myRecipes.DataSource = db.Recipes.ToList();
                myRecipes.DataBind();
            }
        }
        private void setGuestFloaty()
        {
            ltUserName.Text = "Guest";
            ltLoginStatus.Text = "You are not logged in -> You cannot add new recipes to our database.";
            hlLoginLink.Visible = true;
            hlLoginLink2.Visible = true;
            btnSignOut.Visible = false;
            pnlNewRecipeForm.Visible = false;
        }
        private bool loggedIn()
        {
            if (Session["email"] != null && Session["name"] != null && Session["uid"] != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void ibtnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void signOut_Click(object sender, EventArgs e)
        {
            Session["email"] = null;
            Session["uid"] = null;
            Session["name"] = null;
            Session["isadmin"] = null;
            setGuestFloaty();

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            if (Session["uid"] != null)
            {
                int owner_id = (int)Session["uid"];
                //adding ingrediants to database
                string[] strs_ings = txtIngrediants.Text.Split('|');
                ArrayList ingrediants = new ArrayList();
                Dictionary<Ingredient, string> ings_qty_Map = new Dictionary<Ingredient, string>();
                using (var db = new KitchenAppDBEntities())
                {
                    foreach (string ing in strs_ings)
                    {
                        string[] info = ing.Split(',');
                        if (info.Length < 5) { continue; }
                        Ingredient tmp = new Ingredient();
                        tmp.name = info[1];
                        tmp.source = Int16.Parse(info[2]);
                        ings_qty_Map[tmp] = info[3];
                        tmp.unit_type = info[4];
                        ingrediants.Add(tmp);
                        //FIXME: bug here still creating new ingredients even when exist
                        var first = db.Ingredients.Where(i => i.name.Trim() == tmp.name.Trim()).FirstOrDefault();
                        if (first == null)
                        {
                            db.Ingredients.Add(tmp);
                        }
                    }
                    db.SaveChanges();
                }


                //creating new recipe object

                Recipe rcp = new Recipe();
                rcp.title = txtRecipeName.Text;
                rcp.owner = owner_id;
                rcp.rate = 0;
                rcp.time = Int16.Parse(txtTime.Text);
                rcp.description = txtDirections0.Text;

                //upload image to image folder
                //TODO: amke sure image does not alreay exists and if it does check what happends when you reupload it if it automatically renames it or overwites it
                //if overwrite... make sure rename happens.
                string relativePath = "";
                using (FileUpload fileuploadRecipeThumb1 = fileuploadRecipeThumb)
                {
                    relativePath = "/images/recipes/" + fileuploadRecipeThumb1.FileName;
                    string ServerMapPath = Server.MapPath("~//images//recipes//" + fileuploadRecipeThumb1.FileName);
                    fileuploadRecipeThumb.PostedFile.SaveAs(ServerMapPath);
                }
                rcp.img_path = relativePath;

                using (var db = new KitchenAppDBEntities())
                {
                    //adding recipe to database
                    db.Recipes.Add(rcp);
                    db.SaveChanges();

                    foreach (Ingredient i in ingrediants)
                    {
                        IngredientsInRecipe ingInRec = new IngredientsInRecipe();
                        ingInRec.ingredient_id = i.id;
                        ingInRec.recipe_id = rcp.id;
                        ingInRec.qty = ings_qty_Map[i].Substring(0, Math.Min(63, ings_qty_Map[i].Length));    //making sure string does not exceed 64 characters 
                        ingInRec.Recipe = rcp;
                        ingInRec.Ingredient = i;
                        db.IngredientsInRecipes.Add(ingInRec);
                    }
                    db.SaveChanges();
                }


            }
            else
            {

            }
            //LocalDataStoreSlot[""];
            Response.Redirect("recipes.aspx");


        }

        protected void txtDirections_TextChanged(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("SomeText");
            ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){EnableControls(); alert('Overrides successfully Updated.'); DisableControls();});", true);
        }

        protected String RateToImagePath(Object rateVal, int index)
        {

            int rate = (int)rateVal;
            if (rate < index)
            {
                return "/images/emptyStar.png";
            }
            else
            {
                return "/images/fullStar.png";
            }


        }

        protected String RecipeIsVegan(Object recipe_idVal)
        {
            int recipe_id = (int)recipe_idVal;
            using (var db = new KitchenAppDBEntities())
            {
                var recipe = db.Recipes.Where(i => i.id == recipe_id).FirstOrDefault();
                if (recipe == null)
                {
                    //wierd should have never gotten here...
                    return "SOMTHING WENT WRONG";
                    //return "/images/icons8-vegan-food-24-toggle_off.png";
                }
                else
                {
                    if (recipe.isVegan())
                    {
                        return "/images/icons8-vegan-food-24-toggle_on.png";
                    }
                    else
                    {
                        return "/images/icons8-vegan-food-24-toggle_off.png";
                    }
                }
            }
        }

        protected String RecipeContainsDairy(Object recipe_idVal)
        {
            int recipe_id = (int)recipe_idVal;
            using (var db = new KitchenAppDBEntities())
            {
                var recipe = db.Recipes.Where(i => i.id == recipe_id).FirstOrDefault();
                if (recipe == null)
                {
                    //wierd should have never gotten here...
                    return "SOMTHING WENT WRONG";
                    //return "/images/icons8-vegan-food-24-toggle_off.png";
                }
                else
                {
                    if (recipe.containsDairy())
                    {
                        return "/images/icons8-cheese-24-toggle_on.png";
                    }
                    else
                    {
                        return "/images/icons8-cheese-24-toggle_off.png";
                    }
                }
            }
        }

        protected String RecipeContainsMeat(Object recipe_idVal)
        {
            int recipe_id = (int)recipe_idVal;
            using (var db = new KitchenAppDBEntities())
            {
                var recipe = db.Recipes.Where(i => i.id == recipe_id).FirstOrDefault();
                if (recipe == null)
                {
                    //wierd should have never gotten here...
                    return "SOMTHING WENT WRONG";
                    //return "/images/icons8-vegan-food-24-toggle_off.png";
                }
                else
                {
                    if (recipe.containsMeat())
                    {
                        return "/images/icons8-thanksgiving-24-toggle_on.png";
                    }
                    else
                    {
                        return "/images/icons8-thanksgiving-24-toggle_off.png";
                    }
                }
            }
        }

        protected String RecipeContainsFish(Object recipe_idVal)
        {
            int recipe_id = (int)recipe_idVal;
            using (var db = new KitchenAppDBEntities())
            {
                var recipe = db.Recipes.Where(i => i.id == recipe_id).FirstOrDefault();
                if (recipe == null)
                {
                    //wierd should have never gotten here...
                    return "SOMTHING WENT WRONG";
                    //return "/images/icons8-vegan-food-24-toggle_off.png";
                }
                else
                {
                    if (recipe.containsFish())
                    {
                        return "/images/icons8-fish-food-24-toggle_on.png";
                    }
                    else
                    {
                        return "/images/icons8-fish-food-24-toggle_off.png";
                    }
                }
            }
        }

        protected String getOwnerName(Object user_idVal)
        {
            int user_id = (int)user_idVal;
            using (var db = new KitchenAppDBEntities())
            {
                var user = db.Users.Where(i => i.id == user_id).FirstOrDefault();
                if (user == null)
                {
                    //wierd should have never gotten here...
                    return "SOMTHING WENT WRONG";
                    //return "/images/icons8-vegan-food-24-toggle_off.png";
                }
                else
                {
                    return user.name.Split(' ')[0];
                }
            }
        }

    }
}

