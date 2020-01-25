<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login_reg.aspx.cs" Inherits="web_course.login_reg" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="include/style.css" rel="stylesheet" />
    <script src="include/jquery-2.0.0.min.js"></script>
    <link href="include/bootstrap_journal.min.css" rel="stylesheet" />
    <title>Login - Register</title>
    <script>
        $(document).ready(function () {
            sign_in_recover(localStorage["CurrentViewName"]);
        });

        function sign_in_recover(page) {
            switch (page) {
                case "sign_in":
                    localStorage["CurrentViewName"] = "sign_in";
                    $("#login").attr("hidden", false);
                    $("#recover").attr("hidden", true);
                    $("#signup").attr("hidden", true);
                    break;
                case "recover":
                    localStorage["CurrentViewName"] = "recover";
                    $("#recover").attr("hidden", false);
                    $("#login").attr("hidden", true);
                    $("#signup").attr("hidden", true);
                    break;
                case "register":
                    localStorage["CurrentViewName"] = "register";
                    $("#recover").attr("hidden", true);
                    $("#login").attr("hidden", true);
                    $("#signup").attr("hidden", false);
                    break;
            }
            return;
        }
    </script>
</head>
<body style="background: url('/images/login-bg.jpg'); background-size: cover;">
    <form class="login100-form validate-form p-b-33 p-t-5" id="form1" runat="server">
         <div class="jumbotron login_container">
             <!--login page-->
             <div id="login" class="wrap-login">
                        <span class="login-form-title">
                            Account Login
                        </span>
                        <div class="wrap-input validate-input" data-validate="Valid email is required: ex@abc.xyz">
                        <asp:TextBox runat="server" cssClass="input100" ID="txtEmail" type="email" autocomplete="off" placeholder="Email"></asp:TextBox>
                        </div>
                        <div class="wrap-input validate-input" data-validate="Password is required">
                        <asp:TextBox runat="server" cssClass="input100" ID="txtPassword" placeholder="password" type="password"></asp:TextBox>
                        </div>
                        <div class="container-login-form-btn">
                            <asp:Button runat="server" ID="btnSignIn" text="Sign in" onclick="btnSignIn_Click" cssClass="login-form-btn"></asp:Button>
                        </div>
                        <asp:Panel runat="server" CssClass="alert alert-danger" ID="pnlLoginFail" Visible="false">
                        LogIn Authentication Failed! try again.
                        </asp:Panel>
                        <asp:Panel runat="server" CssClass="alert alert-danger" ID="pnlEmailError" Visible="false">
                        Email provided is not valid! Try again.
                        </asp:Panel>
                        <div class="text-center">
                            <span class="txt1">
                                Forgot
                            </span>
                            <a href="#" class="a-login" onclick="sign_in_recover('recover')">
                                Password?
                            </a>
                        </div>
                        <div class="text-center">
                            <span class="txt1">
                                Create an account?
                            </span>
                            <a href="#" class="a-login" onclick="sign_in_recover('register')">
                                Sign Up
                            </a>
                        </div>
                        <div class="text-center">
                            <span class="txt1">
                                Continue as
                            </span>
                            <a href="/recipes.aspx" class="a-login">
                                guest
                            </a>
                        </div>
                </div>
             
             <!--registration page-->
            <div id="signup" class="wrap-login" hidden="hidden">
                <p class="bg-primary">
                    <asp:Literal ID="ltMessage" runat="server"></asp:Literal>
                    <asp:ValidationSummary runat="server" ID="valSummaryForm" CssClass="bg-error" ValidationGroup="signupForm" DisplayMode="BulletList" HeaderText="Please Fix the following errors." Visible="false"/>
                </p>
                <span class="login-form-title">
                    Account Creation
                </span>
                <div class="wrap-input validate-input" data-validate="Valid email is required: ex@abc.xyz">
                <asp:TextBox runat="server" cssClass="input100" ID="txtEmailSignup" type="email" placeholder="Email"></asp:TextBox>
                <asp:RegularExpressionValidator CssClass="validation-text" ValidationGroup="signupForm" runat="server" ID="revEmailSignup" ControlToValidate="txtEmailSignup" ErrorMessage="*Valid Email is required." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" ></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator CssClass="validation-text" ValidationGroup="signupForm" runat="server" ID="rfvEmailSignup" ControlToValidate="txtEmailSignup" ErrorMessage="*Email is required." Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="wrap-input validate-input" data-validate="Valid name is required: letters only">
                <asp:TextBox runat="server" cssClass="input100" ID="txtNameSignup" type="text" placeholder="Name"></asp:TextBox>
                <asp:RequiredFieldValidator CssClass="validation-text" ValidationGroup="signupForm" runat="server" ID="rfvNameSignup" ControlToValidate="txtNameSignup" ErrorMessage="*Name is required."></asp:RequiredFieldValidator>
                </div>
                <div class="wrap-input">
                <asp:TextBox runat="server" ID="txtDateOfBirthSignup" type="date"></asp:TextBox>
                </div>
                <asp:RadioButtonList ID="rblGenderSignup" runat="server" CssClass="gender-radio">
                    <asp:ListItem Text='<img src="/images/male.png" />' Value="male" />
                    <asp:ListItem Text='<img src="/images/female.png" />' Value="female" />
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator CssClass="validation-text" ValidationGroup="signupForm" runat="server" ID="RequiredFieldValidator1" ControlToValidate="rblGenderSignup" ErrorMessage="*Please choose your gender."></asp:RequiredFieldValidator>
                <div class="wrap-input validate-input" data-validate="Password is required">
                <asp:TextBox runat="server" cssClass="input100" ID="txtPasswordSignup" placeholder="password" type="password"></asp:TextBox>
                <asp:RequiredFieldValidator CssClass="validation-text" ValidationGroup="signupForm" runat="server" ID="rfvPasswordVerifySignup" ControlToValidate="txtPasswordSignup" ErrorMessage="*You did not type in a Password."></asp:RequiredFieldValidator>
                </div>
                <div class="wrap-input validate-input" data-validate="Password is required">
                <asp:TextBox runat="server" cssClass="input100" ID="txtPasswordVerifySignup" placeholder="password" type="password"></asp:TextBox>    
                </div>
                <div class="container-login-form-btn">
                    <asp:Button runat="server" ID="btnSignup" text="Create Account" onclick="btnSignup_Click" cssClass="login-form-btn"></asp:Button>
                </div>
                <div class="text-center">
                    <span class="txt1">
                        Back to
                    </span>
                    <a href="#" class="a-login" onclick="sign_in_recover('sign_in')">
                        Sign-in?
                    </a>
                </div>
                <div class="text-center">
                    <span class="txt1">
                        Continue as
                    </span>
                    <a href="/recipes.aspx" class="a-login">
                        guest
                    </a>
                </div>
            </div>

             <!--recover page-->
             <div id="recover" class="wrap-login" hidden="hidden">
                        <span class="login-form-title">
                            Recover Password
                        </span>
                        <div class="wrap-input validate-input" data-validate="Valid email is required: ex@abc.xyz">
                        <asp:TextBox runat="server" cssClass="input100" ID="txtEmailRecover" type="email" autocomplete="off" placeholder="Email"></asp:TextBox>
                        </div>
                        <div class="container-login-form-btn">
                            <asp:Button runat="server" ID="btnRecover" text="Recover" onclick="btnRecover_Click" cssClass="login-form-btn"></asp:Button>
                        </div>
                        <div class="text-center">
                            <span class="txt1">
                                Back to
                            </span>
                            <a href="#" class="a-login" onclick="sign_in_recover('sign_in')">
                                Sign-in
                            </a>
                        </div>
                        <div class="text-center">
                            <span class="txt1">
                                Create an account?
                            </span>
                            <a href="#" class="a-login" onclick="sign_in_recover('register')">
                                Sign Up
                            </a>
                        </div>
                        <div class="text-center">
                            <span class="txt1">
                                Continue as
                            </span>
                            <a href="/recipes.aspx" class="a-login">
                                guest
                            </a>
                        </div>
                </div>
            </div>
    </form>
    
</body>
</html>
