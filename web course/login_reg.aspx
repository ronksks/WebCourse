<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login_reg.aspx.cs" Inherits="web_course.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form class="login100-form validate-form p-b-33 p-t-5" id="form1" runat="server">
         <div class="jumbotron login_container" hidden>
                <div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-50">
                        <span class="login100-form-title p-b-33">
                            Account Login
                        </span>
                        <div class="wrap-input100 validate-input" data-validate="Valid email is required: ex@abc.xyz">
                            <%--<asp:TextBox runat="server" cssClass="input100" ID="txtEmail" placeholder="Email" autocomplete="off" >--%>
                        </div>
                        <div class="wrap-input100 rs1 validate-input" data-validate="Password is required">
                            <%--<asp: runat="server" cssClass="input100" ID="txtPassword"/>--%>
                        </div>
                        <div class="container-login100-form-btn m-t-20">
                            <button class="login100-form-btn">
                                Sign in
                            </button>
                        </div>
                        <div class="text-center p-t-45 p-b-4">
                            <span class="txt1">
                                Forgot
                            </span>
                            <a href="#" class="txt2 hov1">
                                Username / Password?
                            </a>
                        </div>
                        <div class="text-center">
                            <span class="txt1">
                                Create an account?
                            </span>
                            <a href="#" class="txt2 hov1">
                                Sign up
                            </a>
                        </div>
                </div>
            </div>
    </form>
</body>
</html>
