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
        }

        protected void ibtnSearch_Click(object sender, EventArgs e)
        {
            
        }

        protected void btnUploadImage_Click(object sender, EventArgs e)
        { 
            string ServerMapPath = Server.MapPath("~//images//" + fileuploadRecipeThumb.FileName);
            fileuploadRecipeThumb.PostedFile.SaveAs(ServerMapPath);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //TODO: a lot of shit happens here. validation of inputs and sql query to insert new recipe to SQL

        }

        protected void ibtnNewRow_Click(object sender, ImageClickEventArgs e)
        {
            //TODO: add new row here intread of javascript.
            //String markup = "<div id='ing' + index + ' class="ingrediant_container"><input placeholder="Ingrediant Name" />\
            //< a href = "#" onclick = "toggle_ingrediant_type(vegan)" >< img src = "https://img.icons8.com/material-rounded/24/000000/vegan-food.png" ></ a >\
            //< a href = "#" onclick = "toggle_ingrediant_type(chicken)" >< img src = "https://img.icons8.com/material-rounded/24/000000/thanksgiving--v2.png" ></ a >\
            //< a href = "#" onclick = "toggle_ingrediant_type(dairy)" >< img src = "https://img.icons8.com/material-rounded/24/000000/cheese.png" ></ a >\
            //< a href = "#" onclick = "toggle_ingrediant_type(fish)" >< img src = "https://img.icons8.com/material-rounded/24/000000/fish-food.png" ></ a >\
            //< input placeholder = "quantity" />\
            //< select class="form-control" style="width:auto;display:inline-block;">\
            //    <option>Pieces</option> \
            //    <option>Grams</option> \
            //    <option>Ounzes</option> \
            //    <option>cups</option> \
            //</select>\
            //<a href = "#" onclick="del_raw(' + index + ')"><img class="close_window" src="https://img.icons8.com/flat_round/24/000000/minus.png" style="float: right"></a></div>';
            //index++;
            //$("#dvIngrediants").append(markup);
            //    divIngrediants.InnerText = "hello world";
            System.Diagnostics.Debug.WriteLine("SomeText");
        }   
    }
}
