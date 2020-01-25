using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace web_course
{
    public partial class login_reg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            using (var db = new KitchenAppContext())
            {
                if (isValidEmail(txtEmail.Text))
                {
                    //var user = db.Users.FirstOrDefault();
                    var user = db.Users.Where(i => i.email.Trim() == txtEmail.Text.Trim() && i.password.Trim() == txtPassword.Text.Trim()).FirstOrDefault();
                    if (user == null)
                    {
                        //show login failed!
                        pnlLoginFail.Visible = true;
                    }
                    else
                    {
                        Session["email"] = user.email.Trim();
                        Session["uid"] = user.id;
                        Session["fname"] = user.fname.Trim();
                        Session["lname"] = user.lname.Trim();
                        Session["isadmin"] = user.isadmin;
                        Response.Redirect("recipes.aspx");
                    }
                }
                else
                {
                    //show login failed! due to ilegal email address
                    pnlEmailError.Visible = true;
                }
            }
        }

        private bool isValidEmail(String email)
        {
           return true;
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                valSummaryForm.Visible = true;
            }
            else
            {
                valSummaryForm.Visible = true;
            }
            ltMessage.Text = txtEmailSignup.Text + " " + txtNameSignup.Text + " " + rblGenderSignup.SelectedValue + " " + txtPasswordSignup.Text;
        }

        protected void btnRecover_Click(object sender, EventArgs e)
        {

        }
        
    }
    public class PasswordTextBox : TextBox
    {
        public PasswordTextBox()
        {
            TextMode = TextBoxMode.Password;
        }

        public override string Text
        {
            get
            {
                return base.Text;
            }
            set
            {
                base.Text = value;

                Attributes["value"] = value;
            }
        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            Attributes["value"] = Text;
        }
    }
}