using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
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

        protected void btn_Click(object sender, EventArgs e)
        {
            if(!String.IsNullOrEmpty(txtEmail.Text))
            {
                using (var db = new KitchenAppDBEntities1())
                {
                    if (IsValidEmail(txtEmail.Text))
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
                            Session["name"] = user.name.Trim();
                            Session["isadmin"] = user.isadmin;
                            Response.Redirect("recipes.aspx");
                        }
                    }
                    else
                    {
                        //show login failed! due to ilegal email address
                        pnlLoginFail.Visible = false;
                        pnlEmailError.Visible = true;
                    }
                }
            } else if (!String.IsNullOrEmpty(txtEmailRecover.Text)) {
                //TODO: add ability to send emails to recover passwords.
                lblMessage.Text = "Feature not suported yet!";
                valSummaryForm.Visible = true;
                return;
            } else if (!String.IsNullOrEmpty(txtEmailSignup.Text)) {
                //validate password confirmation
                if (!txtPasswordVerifySignup.Text.Equals(txtPasswordSignup.Text))
                {
                    lblMessage.Text = "Passwords do not match!";
                    valSummaryForm.Visible = true;
                    return;
                }
                if (String.IsNullOrEmpty(txtPasswordSignup.Text))
                {
                    lblMessage.Text = "Passwords Field Is Empty!";
                    valSummaryForm.Visible = true;
                    return;
                }
                //validate email address
                if (!IsValidEmail(txtEmailSignup.Text))
                {
                    lblMessage.Text = "Invalid Email Address!";
                    valSummaryForm.Visible = true;
                    return;
                }

                if (String.IsNullOrEmpty(txtNameSignup.Text))
                {
                    lblMessage.Text = "Please provide a Name!";
                    valSummaryForm.Visible = true;
                    return;
                }

                using (var db = new KitchenAppDBEntities1())
                {
                    var p = db.Users.Where(i => i.email == txtEmailSignup.Text).FirstOrDefault();
                    if (p != null)
                    {
                        lblMessage.Text = "Email Address Already Registered! Recover Password?";
                        valSummaryForm.Visible = true;
                        return;
                    }
                    User newUser = new User();
                    newUser.email = txtEmailSignup.Text;
                    newUser.name = txtNameSignup.Text;
                    if (!String.IsNullOrEmpty(txtDateOfBirthSignup.Text))
                    {
                        newUser.bdate = DateTime.Parse(txtDateOfBirthSignup.Text);
                    }

                    if (rblGenderSignup.SelectedValue != null)
                    {
                        if (rblGenderSignup.SelectedValue.Equals("male"))
                        {
                            newUser.gender = 1;
                        }
                        else
                        {
                            newUser.gender = 0;
                        }
                    }
                    newUser.isadmin = 0;
                    newUser.password = txtPasswordSignup.Text;

                    if (db.Users.Add(newUser) != null)
                    {
                        lblSucessSignUp.Text = "<div class='alert alert-dismissible alert-success'>Hi " + txtNameSignup.Text + " Welcome to <a href='recipes.aspx'>KitchenApp</a></div>";
                        lblSucessSignUp.Visible = true;
                        lblMessage.Visible = false;
                        signup.Visible = false;
                        Session["email"] = newUser.email.Trim();
                        Session["uid"] = newUser.id;
                        Session["name"] = newUser.name.Trim();
                        Session["isadmin"] = newUser.isadmin;
                        db.SaveChanges();
                    }

                }
            }
            
        }

        

        //check if email address is valid on server side. taken from https://docs.microsoft.com/en-us/dotnet/standard/base-types/how-to-verify-that-strings-are-in-valid-email-format
        public static bool IsValidEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
                return false;

            try
            {
                // Normalize the domain
                email = Regex.Replace(email, @"(@)(.+)$", DomainMapper,
                                      RegexOptions.None, TimeSpan.FromMilliseconds(200));

                // Examines the domain part of the email and normalizes it.
                string DomainMapper(Match match)
                {
                    // Use IdnMapping class to convert Unicode domain names.
                    var idn = new IdnMapping();

                    // Pull out and process domain name (throws ArgumentException on invalid)
                    var domainName = idn.GetAscii(match.Groups[2].Value);

                    return match.Groups[1].Value + domainName;
                }
            }
            catch (RegexMatchTimeoutException e)
            {
                return false;
            }
            catch (ArgumentException e)
            {
                return false;
            }

            try
            {
                return Regex.IsMatch(email,
                    @"^(?("")("".+?(?<!\\)""@)|(([0-9a-z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-z])@))" +
                    @"(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-z][-0-9a-z]*[0-9a-z]*\.)+[a-z0-9][\-a-z0-9]{0,22}[a-z0-9]))$",
                    RegexOptions.IgnoreCase, TimeSpan.FromMilliseconds(250));
            }
            catch (RegexMatchTimeoutException)
            {
                return false;
            }
        }
        
    }
}