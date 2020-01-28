using System;
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
            //ibtnNewRow.Style = "float:right";
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
            if (Session["fname"] != null)
            {
                //TODO: a lot of shit happens here. validation of inputs and sql query to insert new recipe to SQL

                //upload image to image folder
                //TODO: amke sure image does not alreay exists and if it does check what happends when you reupload it if it automatically renames it or overwites it
                //if overwrite... make sure rename happens.
                using (FileUpload fileuploadRecipeThumb1 = fileuploadRecipeThumb)
                {
                    string ServerMapPath = Server.MapPath("~//images//recipes//" + fileuploadRecipeThumb1.FileName);
                    fileuploadRecipeThumb.PostedFile.SaveAs(ServerMapPath);
                }
            } 
            else
            {

            }
            



        }

        protected void txtDirections_TextChanged(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("SomeText");
            ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){EnableControls(); alert('Overrides successfully Updated.'); DisableControls();});", true);
        }

    }

}

