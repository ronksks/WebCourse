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
                hlEditMyRecipes.Visible = true;
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

            var controlName = Request.Params.Get("__EVENTTARGET");
            var argument = Request.Params.Get("__EVENTARGUMENT");
            if (controlName == "category_panel")
            {
                pnlCategory_Click(argument);
            }
            else
            {
                ShowCategories_Click(null,null);
            }
        }

        protected void Page_PreRender()
        {
            //This function returns a string calling __doPostBack(); but also forces the page to output the __doPostBack() function definition for later use in the app.js file
            this.Page.ClientScript.GetPostBackEventReference(pnlCategoriesPage, string.Empty);
        }
        private void setGuestFloaty()
        {
            ltUserName.Text = "Guest";
            ltLoginStatus.Text = "You are not logged in -> You cannot add new recipes to our database.";
            hlLoginLink.Visible = true;
            hlLoginLink2.Visible = true;
            hlEditMyRecipes.Visible = false;
            btnSignOut.Visible = false;
            pnlNewRecipeForm.Visible = false;
        }
        private bool loggedIn()
        {
            if (Session != null && Session["email"] != null && Session["name"] != null && Session["uid"] != null)
            {
                txtUserId.Text = Session["uid"].ToString();
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void ibtnSearch_Click(object sender, EventArgs e)
        {
            ltSearchTerm.Text = txtSearch.Text;
            using (var db = new KitchenAppDBEntities())
            {
                rptSearchResults.DataSource = db.Recipes.Where(i => i.title.Contains(txtSearch.Text)).ToList();
                rptSearchResults.DataBind();
            }
        }

        

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string edit_mode_id = txtEditModeId.Text;
            if (loggedIn())
            {
                //Here we are in Add New Recipe Mode
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
                String rate = txtRate.Text;
                if (rate.Length != 0)
                {
                    try
                    {
                        rcp.rate = Convert.ToInt32(rate);
                    }
                    catch
                    {

                    }
                }
                String time = txtTime.Text;
                if (time.Length != 0)
                {
                    try
                    {
                        rcp.time = Convert.ToInt32(time);
                    }
                    catch
                    {

                    }
                }
                rcp.owner = owner_id;
                rcp.description = txtDirections0.Text;



                //upload image to image folder
                //TODO: amke sure image does not alreay exists and if it does check what happends when you reupload it if it automatically renames it or overwites it
                //if overwrite... make sure rename happens.
                string relativePath = "";
                using (FileUpload fileuploadRecipeThumb1 = fileuploadRecipeThumb)
                {
                    if (fileuploadRecipeThumb1.FileName != "")
                    {
                        relativePath = "/images/recipes/" + fileuploadRecipeThumb1.FileName;
                        string ServerMapPath = Server.MapPath("~//images//recipes//" + fileuploadRecipeThumb1.FileName);
                        fileuploadRecipeThumb.PostedFile.SaveAs(ServerMapPath);
                        rcp.img_path = relativePath;
                    } 
                    else if (edit_mode_id != "")
                    {
                        using (var db = new KitchenAppDBEntities())
                        {
                            int id = Int16.Parse(edit_mode_id);
                            Recipe get_path = db.Recipes.Find(id);
                            if (get_path != null)
                            {
                                rcp.img_path = get_path.img_path;
                            }
                            else
                            {
                                rcp.img_path = relativePath;
                            }
                        }
                    } 
                    else
                    {
                        rcp.img_path = relativePath;
                    }
                }

                using (var db = new KitchenAppDBEntities())
                {
                    if (edit_mode_id != "")
                    {
                        //editing existing recipe
                        int id = Int16.Parse(edit_mode_id);
                        Recipe to_change = db.Recipes.Find(id);
                        if (to_change != null) {
                            to_change.time = rcp.time;
                            to_change.title = rcp.title;
                            to_change.rate = rcp.rate;
                            to_change.description = rcp.description;
                            to_change.owner = rcp.owner;
                            to_change.User = rcp.User;

                            db.SaveChanges();
                            rcp = to_change;
                        }
                        // removing old ingredients. will insert new ones after this block.
                        List<IngredientsInRecipe> l = db.IngredientsInRecipes.Where(i => i.recipe_id == id).ToList();
                        foreach (IngredientsInRecipe i in l)
                        {
                            db.IngredientsInRecipes.Remove(i);
                        }
                        db.SaveChanges();
                    }
                    else
                    {
                        //adding recipe to database
                        db.Recipes.Add(rcp);
                        db.SaveChanges();
                    }
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
                //user not logged in
            }
            //LocalDataStoreSlot[""];
            Response.Redirect("recipes.aspx");
        }

        protected void pnlCategory_Click(String category)
        {
            //change category view
            pnlCategoriesPage.Visible = false;
            pnlCategoryView.Visible = true;
            pnlNoRecipes.Visible = false;
            ltrCategoryName.Text = category.First().ToString().ToUpper() + category.Substring(1) + " Recipes";
            using (var db = new KitchenAppDBEntities())
            {
                List<Recipe> catRecipes = new List<Recipe>();
                foreach (Recipe r in db.Recipes.ToList())
                {
                    switch (category)
                    {
                        case "vegan":
                            if (r.isVegan()) catRecipes.Add(r);
                            break;
                        case "meat":
                            if (r.containsMeat()) catRecipes.Add(r);
                            break;
                        case "dairy":
                            if (r.containsDairy()) catRecipes.Add(r);
                            break;
                        case "fish":
                            if (r.containsFish()) catRecipes.Add(r);
                            break;
                    }
                }
                if (catRecipes.Count == 0)
                {
                    pnlNoRecipes.Visible = true;
                    ltrNoRecipes.Text = "No " + category + " Recipes Found. Maybe constider adding one?";
                }
                rptCategory.DataSource = catRecipes;
                rptCategory.DataBind();
            }
        }
        protected void btnRemove_Click(object sender, EventArgs e)
        {
            if (loggedIn())
            {
                string remove_id = txtEditRecipeID.Text;
                int id = Int16.Parse(remove_id);
                using (var db = new KitchenAppDBEntities())
                {
                    // removing old ingredients. will insert new ones after this block.
                    List<IngredientsInRecipe> l = db.IngredientsInRecipes.Where(i => i.recipe_id == id).ToList();
                    foreach (IngredientsInRecipe i in l)
                    {
                        db.IngredientsInRecipes.Remove(i);
                    }
                    db.SaveChanges();
                    Recipe del_me = db.Recipes.Find(id);
                    if (del_me == null)
                    {
                        return;
                    }
                    db.Recipes.Remove(del_me);
                    db.SaveChanges();
                }
            }
            Response.Redirect("recipes.aspx");
        }

        protected void ShowCategories_Click(object sender, EventArgs e)
        {
            pnlCategoriesPage.Visible = true;
            pnlCategoryView.Visible = false;
            pnlNoRecipes.Visible = false;
        }

        protected void editImage_Click(object sender, EventArgs e)
        {
            pnlCategoriesPage.Visible = true;
            pnlCategoryView.Visible = false;
            pnlNoRecipes.Visible = false;
        }
        protected void txtDirections_TextChanged(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("SomeText");
            ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){EnableControls(); alert('Overrides successfully Updated.'); DisableControls();});", true);
        }

        protected String EditOnOwnership(Object user_idVal, Object recipe_idVal)
        {
            int user_id = (int)user_idVal;
            int recipe_id = (int)recipe_idVal;

            using (var db = new KitchenAppDBEntities())
            {
                var recipe = db.Recipes.Where(i => i.id == recipe_id && i.owner == user_id).FirstOrDefault();
                if (recipe == null)
                {
                    return "hidden";
                }
                else
                {
                    return "";
                }
            }
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

        protected string enableEditRecipe(Object recipe_id)
        {
            int res_id = (int)recipe_id;
            if (!loggedIn())
            {
                return "";
            }
            int loggedInUserId = (int)Session["uid"];
            int isAdmin = (int)Session["isadmin"];
            //getting here means we are logged in
            if (isAdmin == 1)
            {
                return "<img src = 'images/icons8-edit-32.png' class='edit_image' onclick='editImage_Clicked(" + res_id + ")' />";
            }
            using (var db = new KitchenAppDBEntities())
            {
                var recipe = db.Recipes.Where(i => i.id == res_id && i.owner == loggedInUserId).FirstOrDefault();
                if (recipe == null)
                {
                    
                    return "";
                    
                }
                else
                {

                    return "<img src = 'images/icons8-edit-32.png' class='edit_image' onclick='editImage_Clicked(" + res_id + ")' />";

                }
            }
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            Session["email"] = null;
            Session["uid"] = null;
            Session["name"] = null;
            Session["isadmin"] = null;
            setGuestFloaty();
            Response.Redirect("recipes.aspx");
        }
    }
}

