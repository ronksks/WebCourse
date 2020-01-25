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
            if (Session["fname"] != null)
            {
                //user is logged in
                var email = Session["email"];
            }
        }

        protected void ibtnSearch_Click(object sender, EventArgs e)
        {
            
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //TODO: a lot of shit happens here. validation of inputs and sql query to insert new recipe to SQL

            //upload image to image folder
            //TODO: amke sure image does not alreay exists and if it does check what happends when you reupload it if it automatically renames it or overwites it
            //if overwrite... make sure rename happens.
            string ServerMapPath = Server.MapPath("~//images//" + fileuploadRecipeThumb.FileName);
            fileuploadRecipeThumb.PostedFile.SaveAs(ServerMapPath);



        }

        protected void txtDirections_TextChanged(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("SomeText");
            ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){EnableControls(); alert('Overrides successfully Updated.'); DisableControls();});", true);
        }
    }
}
