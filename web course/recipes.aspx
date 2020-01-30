<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="recipes.aspx.cs" Inherits="web_course.recipes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Kitchen Web App</title>
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="50">
    <form id="form1" runat="server">
        <div class="main_container" ng-app="kitchenApp" ng-controller="mainController">
            <!-- Navigation bar -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-primary navbar-fixed-top">
                <a class="navbar-brand" href="#" onclick="change_content_to('Home')">
                    <img src="https://img.icons8.com/flat_round/30/000000/home.png"/>
                    <!--KitchenApp-->
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarColor01">
                    <ul class="navbar-nav mr-auto">
                        <!--<li class="nav-item active">
                            <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                        </li>-->
                        <li class="nav-item">
                            <a class="nav-link" onclick="change_content_to('Browse')" href="#">Browse</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" onclick="change_content_to('Categories')" href="#">Categories</a>
                        </li>
                    </ul>
                    <ul class="navbar-nav navbar-nav-right">
                        <li class="nav-item">
                        <asp:TextBox runat="server" CssClass="form-control mr-sm-2" id="txtSearch" Text="Search" />
                        </li>
                        <li class="nav-item">
                        <asp:ImageButton cssClass="btn btn-primary my-2 my-sm-0" id="ibtnSearch" runat="server" AlternateText="" ImageAlign="right" ImageUrl="https://img.icons8.com/material-rounded/24/000000/search.png" OnClick="ibtnSearch_Click"/>
                        </li>
                        <%--<li class="nav-item">
                            <!-- TODO: add new items in dropdown like settings and more also change text to icon of account-->
                            <img alt="Favorite Recipes" class="nav-link" src="https://img.icons8.com/material-rounded/24/000000/like.png" onclick="change_content_to('Favorites')"/>
                        </li>--%>
                        <li class="nav-item">
                            <img alt="Account info" class="nav-link" src="https://img.icons8.com/material-rounded/24/000000/user.png" onclick="change_content_to('Account')"/>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- sidebar -->
            <div class="sidenav">
                <a href="#" data-toggle="tooltip" title="Add New Recipe" onclick="show_new_recipe_form()">
                    <img src="https://img.icons8.com/cute-clipart/64/000000/add-property.png">
                </a>
                <!--<a href="#">Services</a>
                <a href="#">Clients</a>
                <a href="#">Contact</a>-->
            </div>
        
            <!-- Recipes view  -->
            <div class="jumbotron page_container recipes_container" hidden>
                <h1 class="display-3">Recipes</h1>

                <!--<p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.</p>-->
                <hr class="my-4">
                <!-- TODO: add onclick functionality to show recipe on same page-->
                <%--<asp:GridView runat="server" ID="myGrid"
                    AutoGenerateColumns="false"
                    CssClass="table table-sm table-bordered"
                    OnRowCommand="myGrid_RowCommand"
                    OnRowEditing="myGrid_RowEditing"
                    OnRowUpdating="myGrid_RowUpdating"
                    OnRowDeleting="myGrid_RowDeleting"
                    allowpaging="True" 
                    OnRowCancelingEdit="myGrid_RowCancelingEdit"
                    emptydatatext="No data available." >
                    <Columns>
                        <asp:TemplateField ItemStyle-CssClass="recipeField">
                            <ItemTemplate>
                                <div class="card-header">
                                    <asp:Label ID="lbID" runat="server" Text='<%#Eval("title") %>'></asp:Label>
                                </div>
                                <div class="card-body">
                                    <asp:Image ID="img" runat="server" src='<%#Eval("img_path").ToString().Trim() %>' style="max-width: 17rem;"></asp:Image>
                                    <asp:Label ID="Label2" runat="server" Text='<%#Eval("rate") %>' ></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>--%><%--<asp:GridView runat="server" ID="myGrid"
                    AutoGenerateColumns="false"
                    CssClass="table table-sm table-bordered"
                    OnRowCommand="myGrid_RowCommand"
                    OnRowEditing="myGrid_RowEditing"
                    OnRowUpdating="myGrid_RowUpdating"
                    OnRowDeleting="myGrid_RowDeleting"
                    allowpaging="True" 
                    OnRowCancelingEdit="myGrid_RowCancelingEdit"
                    emptydatatext="No data available." >
                    <Columns>
                        <asp:TemplateField ItemStyle-CssClass="recipeField">
                            <ItemTemplate>
                                <div class="card-header">
                                    <asp:Label ID="lbID" runat="server" Text='<%#Eval("title") %>'></asp:Label>
                                </div>
                                <div class="card-body">
                                    <asp:Image ID="img" runat="server" src='<%#Eval("img_path").ToString().Trim() %>' style="max-width: 17rem;"></asp:Image>
                                    <asp:Label ID="Label2" runat="server" Text='<%#Eval("rate") %>' ></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>--%>
                <asp:Repeater runat="server" ID="myRecipes">
                    <ItemTemplate>
                        <div class="card border-primary mb-3 recipe">
                            <div class="card-header">
                                <asp:Literal runat="server" Text='<%#Eval("title") %>'></asp:Literal>
                            </div>
                            <div class="card-body">
                                <h4 class="card-title">
                                    Time: <asp:Literal runat="server" Text='<%#Eval("time") %>' ></asp:Literal> Minutes
                                </h4>
                                <p class="card-text">
                                    <asp:Image ID="img" runat="server" src='<%#Eval("img_path").ToString().Trim() %>' style="max-width: 17rem;"></asp:Image>
                                </p>
                                <%--<span ng-repeat="i in range(recipe.rate)"><img src="{{fullStarPath}}"/></span>
                                <span ng-repeat="i in rangeFromTo(recipe.rate,5)"><img src="{{emptyStarPath}}"/></span>--%>
                                <svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="40" height="40" viewBox="0 0 172 172" style=" fill:#000000;"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,172v-172h172v172z" fill="none"></path><g><path d="M55.9,148.35c-26.5826,0 -45.15,-11.4939 -45.15,-27.95v-15.8197c54.5025,-24.7078 136.2369,-33.0713 159.1,-33.6045v15.0242c0,43.0731 -57.233,62.35 -113.95,62.35z" fill="#e09a82"></path><path d="M167.7,73.1946v12.8054c0,15.4972 -9.0386,29.8807 -25.4474,40.5017c-19.9219,12.8871 -49.7811,19.6983 -86.3526,19.6983c-25.3184,0 -43,-10.6081 -43,-25.8v-14.4265c52.5718,-23.4135 129.6536,-31.8243 154.8,-32.7789M172,68.8c-21.5,0 -107.5,8.6 -163.4,34.4c0,2.9283 0,13.9191 0,17.2c0,16.2497 17.2,30.1 47.3,30.1c81.7,0 116.1,-32.8735 116.1,-64.5c0,-2.2016 0,-13.6826 0,-17.2z" fill="#a16a4a"></path><path d="M55.9,131.15c-26.5826,0 -45.15,-11.4939 -45.15,-27.95c0,-15.9745 15.6262,-22.059 29.4163,-27.4254c5.6416,-2.1973 10.9693,-4.2699 14.8608,-6.8886c5.16,-3.4701 7.4175,-10.3587 9.804,-17.6558c4.4376,-13.5579 9.0257,-27.5802 31.304,-27.5802c13.2741,0 31.7813,6.1232 39.7707,16.3744l0.5246,0.6708l0.8428,0.129c17.3505,2.6918 32.5768,15.7681 32.5768,27.9758c0,43.0731 -57.233,62.35 -113.95,62.35z" fill="#ffc49c"></path><path d="M96.1351,25.8c14.3147,0 31.3943,6.9746 38.0722,15.5445l1.0492,1.3459l1.6856,0.2623c17.6042,2.7262 30.7579,15.8971 30.7579,25.8473c0,15.4972 -9.0386,29.8807 -25.4474,40.5017c-19.9219,12.8871 -49.7811,19.6983 -86.3526,19.6983c-25.3184,0 -43,-10.6081 -43,-25.8c0,-13.4676 11.6229,-19.0318 28.0446,-25.4259c5.7577,-2.2403 11.1929,-4.3559 15.2779,-7.1036c5.7749,-3.8829 8.1442,-11.1155 10.6468,-18.7738c4.3946,-13.4203 8.5441,-26.0967 29.2658,-26.0967M96.1351,21.5c-36.4726,0 -29.1798,36.7779 -42.3077,45.6015c-13.1322,8.8279 -45.2274,11.825 -45.2274,36.0985c0,16.2497 17.2,30.1 47.3,30.1c81.7,0 116.1,-32.8735 116.1,-64.5c0,-12.9 -15.4327,-27.1588 -34.4,-30.1c-8.0238,-10.2985 -26.875,-17.2 -41.4649,-17.2z" fill="#a16a4a"></path><path d="M135.2436,98.47c-12.4313,8.041 -36.2877,17.63 -79.3436,17.63c-20.5325,0 -30.1,-7.697 -30.1,-12.9c0,-4.8633 6.1146,-8.0668 19.8273,-13.4031c6.4414,-2.5069 12.5216,-4.8762 17.7977,-8.4194c9.46,-6.3597 12.7796,-16.512 15.7122,-25.4689c4.7042,-14.3878 6.5403,-17.2086 16.9979,-17.2086c11.0725,0 24.0886,5.6846 27.8984,10.5737l4.1925,5.3793l6.7381,1.0449c12.4055,1.9221 19.5994,10.5264 19.8359,13.1021c0,10.9736 -6.9445,21.5086 -19.5564,29.67z" fill="#f78f8f"></path><path d="M141.3797,73.3881c0,0 -7.8346,12.6119 -31.2911,22.1407c-27.2104,11.0553 -60.3849,9.2192 -60.3849,9.2192c-1.5738,-5.9254 28.1091,-6.45 37.7067,-11.2488c10.0534,-5.0267 3.1863,-16.9076 6.5618,-16.9076c1.5093,0 7.7357,8.6215 14.5684,7.7658c11.8293,-1.4749 26.9739,-14.8436 32.8391,-10.9693z" fill="#ffc7c7"></path><path d="M99.0935,47.8848c-4.85652,0 -8.7935,2.62594 -8.7935,5.8652c0,3.23926 3.93698,5.8652 8.7935,5.8652c4.85652,0 8.7935,-2.62594 8.7935,-5.8652c0,-3.23926 -3.93698,-5.8652 -8.7935,-5.8652z" fill="#ffffff"></path></g></g></svg>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <%--<div class="card border-primary mb-3 recipe" ng-repeat="recipe in recipes">
                    <div class="card-header">{{recipe.title}}</div>
                    <div class="card-body">
                        <h4 class="card-title">Time: {{recipe.timeToPrepare}} Minutes</h4>
                        <p class="card-text"><img src="{{recipe.pathToThumbnail}}" style="max-width: 17rem;" /></p>
                        <span ng-repeat="i in range(recipe.rate)"><img src="{{fullStarPath}}"/></span>
                        <span ng-repeat="i in rangeFromTo(recipe.rate,5)"><img src="{{emptyStarPath}}"/></span>
                        <svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="40" height="40" viewBox="0 0 172 172" style=" fill:#000000;"><g fill="none" fill-rule="nonzero" stroke="none" stroke-width="1" stroke-linecap="butt" stroke-linejoin="miter" stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0" font-family="none" font-weight="none" font-size="none" text-anchor="none" style="mix-blend-mode: normal"><path d="M0,172v-172h172v172z" fill="none"></path><g><path d="M55.9,148.35c-26.5826,0 -45.15,-11.4939 -45.15,-27.95v-15.8197c54.5025,-24.7078 136.2369,-33.0713 159.1,-33.6045v15.0242c0,43.0731 -57.233,62.35 -113.95,62.35z" fill="#e09a82"></path><path d="M167.7,73.1946v12.8054c0,15.4972 -9.0386,29.8807 -25.4474,40.5017c-19.9219,12.8871 -49.7811,19.6983 -86.3526,19.6983c-25.3184,0 -43,-10.6081 -43,-25.8v-14.4265c52.5718,-23.4135 129.6536,-31.8243 154.8,-32.7789M172,68.8c-21.5,0 -107.5,8.6 -163.4,34.4c0,2.9283 0,13.9191 0,17.2c0,16.2497 17.2,30.1 47.3,30.1c81.7,0 116.1,-32.8735 116.1,-64.5c0,-2.2016 0,-13.6826 0,-17.2z" fill="#a16a4a"></path><path d="M55.9,131.15c-26.5826,0 -45.15,-11.4939 -45.15,-27.95c0,-15.9745 15.6262,-22.059 29.4163,-27.4254c5.6416,-2.1973 10.9693,-4.2699 14.8608,-6.8886c5.16,-3.4701 7.4175,-10.3587 9.804,-17.6558c4.4376,-13.5579 9.0257,-27.5802 31.304,-27.5802c13.2741,0 31.7813,6.1232 39.7707,16.3744l0.5246,0.6708l0.8428,0.129c17.3505,2.6918 32.5768,15.7681 32.5768,27.9758c0,43.0731 -57.233,62.35 -113.95,62.35z" fill="#ffc49c"></path><path d="M96.1351,25.8c14.3147,0 31.3943,6.9746 38.0722,15.5445l1.0492,1.3459l1.6856,0.2623c17.6042,2.7262 30.7579,15.8971 30.7579,25.8473c0,15.4972 -9.0386,29.8807 -25.4474,40.5017c-19.9219,12.8871 -49.7811,19.6983 -86.3526,19.6983c-25.3184,0 -43,-10.6081 -43,-25.8c0,-13.4676 11.6229,-19.0318 28.0446,-25.4259c5.7577,-2.2403 11.1929,-4.3559 15.2779,-7.1036c5.7749,-3.8829 8.1442,-11.1155 10.6468,-18.7738c4.3946,-13.4203 8.5441,-26.0967 29.2658,-26.0967M96.1351,21.5c-36.4726,0 -29.1798,36.7779 -42.3077,45.6015c-13.1322,8.8279 -45.2274,11.825 -45.2274,36.0985c0,16.2497 17.2,30.1 47.3,30.1c81.7,0 116.1,-32.8735 116.1,-64.5c0,-12.9 -15.4327,-27.1588 -34.4,-30.1c-8.0238,-10.2985 -26.875,-17.2 -41.4649,-17.2z" fill="#a16a4a"></path><path d="M135.2436,98.47c-12.4313,8.041 -36.2877,17.63 -79.3436,17.63c-20.5325,0 -30.1,-7.697 -30.1,-12.9c0,-4.8633 6.1146,-8.0668 19.8273,-13.4031c6.4414,-2.5069 12.5216,-4.8762 17.7977,-8.4194c9.46,-6.3597 12.7796,-16.512 15.7122,-25.4689c4.7042,-14.3878 6.5403,-17.2086 16.9979,-17.2086c11.0725,0 24.0886,5.6846 27.8984,10.5737l4.1925,5.3793l6.7381,1.0449c12.4055,1.9221 19.5994,10.5264 19.8359,13.1021c0,10.9736 -6.9445,21.5086 -19.5564,29.67z" fill="#f78f8f"></path><path d="M141.3797,73.3881c0,0 -7.8346,12.6119 -31.2911,22.1407c-27.2104,11.0553 -60.3849,9.2192 -60.3849,9.2192c-1.5738,-5.9254 28.1091,-6.45 37.7067,-11.2488c10.0534,-5.0267 3.1863,-16.9076 6.5618,-16.9076c1.5093,0 7.7357,8.6215 14.5684,7.7658c11.8293,-1.4749 26.9739,-14.8436 32.8391,-10.9693z" fill="#ffc7c7"></path><path d="M99.0935,47.8848c-4.85652,0 -8.7935,2.62594 -8.7935,5.8652c0,3.23926 3.93698,5.8652 8.7935,5.8652c4.85652,0 8.7935,-2.62594 8.7935,-5.8652c0,-3.23926 -3.93698,-5.8652 -8.7935,-5.8652z" fill="#ffffff"></path></g></g></svg>
                    </div>
                </div>--%>
            </div>

            <!-- Home Page-->
            <div class="jumbotron home page_container">

            </div>

            <!-- Add new Recipe view -->
            <div class="jumbotron new_recipe_container">
                <div class="alert-info">
                    <asp:Literal runat="server" ID="ltLoginStatus" Text=""></asp:Literal>
                    <asp:HyperLink id="hlLoginLink" NavigateUrl="login_reg.aspx" Text="Click Here to Login" runat="server"/> 
                </div>                
                <a href="#" onclick="close_new_recipe()"><img class="close_window" src="https://img.icons8.com/color/50/000000/close-window.png"/></a>
                <asp:Panel runat="server" ID="pnlNewRecipeForm">
                    <div class="form-group">
                        <asp:TextBox ID="txtRecipeName" runat="server" cssClass="form-control"  placeholder="Recipe Name"/>
                        <small class="form-text text-muted">Try to keep it simple.</small>
                    </div>
                    <div class="form-group form-inline">
                        <table class="form_row">
                            <thead>
                                <tr>
                                    <td class="form_row_description">
                                        <label style="justify-content:flex-end;">Category:</label>
                                    </td>
                                    <td class="form_row_value">
                                        <!--TODO: make these options apear whend document is ready to get category list from database
                                         TODO: add functionality to add new category if needed-->
                                        <asp:DropDownList cssClass="form-control" runat="server" ID="ddlCategory">
                                            <asp:ListItem text="Meat" Value="Meat"/>
                                            <asp:ListItem text="Dairy" Value="Dairy"/>
                                            <asp:ListItem text="Vegan" Value="Vegan"/>
                                            <asp:ListItem text="Fish" Value="Fish"/>
                                            <asp:ListItem text="Add New" Value="Add New"/>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </thead>
                        </table>
                    </div>

                    <div class="form-group form-inline">
                        <!--TODO:add javascript here that will show time in HH:MM format or accept this special format as input-->
                        <table class="form_row">
                            <thead>
                                <tr>
                                    <td class="form_row_description">
                                        <label style="justify-content:flex-end;">Time To Prepare:</label>
                                    </td>
                                    <td class="form_row_value">
                                        <asp:TextBox runat="server" ID="txtTime" cssClass="form-control" text="90" />
                                        <small class="form-text text-muted">In Minutes</small>
                                    </td>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <!--dynamic ingediants table-->
                    <asp:TextBox runat="server" ID="txtIngrediants" ></asp:TextBox>
                    <div runat="server" id="divIngrediants">
                        <h1>Ingrediants</h1>
                        
                    </div>
                    <!--dynamic instructions / directions table-->
                    <div id="directions">
                        <h1>Directions</h1>
                        <div id="divDirections0" class="card text-white bg-primary mb-3">
                            <div class="card-header">Step by step directions</div>
                            <div class="card-body">
                                <p class="card-text">
                                    <%--onkeyup="arrange_directions(0)"--%>
                                    <asp:TextBox TextMode="MultiLine" runat="server" ID="txtDirections0" cssClass="directions_inputs" ></asp:TextBox>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="form-group form-inline">
                        <label>Recipe Image:</label>
                        <asp:FileUpload id="fileuploadRecipeThumb" runat="server" />
                    </div>
                    <asp:Button runat="server" OnClick="btnSubmit_Click" id="btnSubmit" cssClass="btn btn-primary" text="Submit" type="submit"/>
                 </asp:Panel>
                </div>

            <!--TODO: Ron.Y add a view recipe container-->

            <!-- Account Info Floaty -->
            <div class="floating-account-info card border-primary mb-3" hidden>
                <a href="#" onclick="close_account_floaty()"><img class="close_window" src="https://img.icons8.com/color/50/000000/close-window.png"/></a>
                <div class="card-header">
                    Hello <asp:Literal runat="server" ID="ltUserName" Text=''></asp:Literal>
                </div>
                <div class="card-body">
                    <h4 class="card-title">
                        <asp:HyperLink id="hlLoginLink2" NavigateUrl="login_reg.aspx" Text="Login/Register" runat="server"/> 
                    </h4>
                    <asp:Button ID="btnSignOut" Text="Sign Out" runat="server" onclick="signOut_Click"/> 
                </div>
            </div>
        </div>
        <!-- Footer -->
        <div class="footer">
            <a href="https://icons8.com/icon/45894/kitchenwares">icons by Icons8</a>
        </div>
    </form>
    <link href="include/style.css" rel="stylesheet" />
    <script src="include/jquery-2.0.0.min.js"></script>
    <link href="include/bootstrap_journal.min.css" rel="stylesheet" />
    <script src="include/angular.min.js"></script>
    <script src="include/classes.js"></script>
    <script src="include/app.js"></script>
</body>
</html>
