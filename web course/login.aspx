<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="web_course.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form class="login100-form validate-form p-b-33 p-t-5" id="form1" runat="server">
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100 p-t-30 p-b-50">
                    <span class="login100-form-title p-b-41">Account Login
                    </span>
                    <div class="wrap-input100 validate-input" data-validate="Enter username">
                        <input class="input100" name="username" placeholder="User name" type="text" />
                        <span class="focus-input100" data-placeholder=""></span>
                    </div>
                    <div class="wrap-input100 validate-input" data-validate="Enter password">
                        <input class="input100" name="pass" placeholder="Password" type="password" />
                        <span class="focus-input100" data-placeholder=""></span>
                    </div>
                    <div class="container-login100-form-btn m-t-32">
                        <button runat="server" id="loginButton" class="login100-form-btn">
                            Login
                        </button>
                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>
