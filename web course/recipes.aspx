<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="recipes.aspx.cs" Inherits="web_course.recipes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Kitchen Web App</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.7.8/angular.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/x2js/1.2.0/xml2json.min.js"></script>
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="50" data-ng-app="app" data-ng-controller="ctrl">
    <form id="form1" runat="server">
        <asp:Panel runat="server" cssClass="main_container">
            <!-- Navigation bar -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-primary navbar-fixed-top">
                <a class="navbar-brand" href="#" onclick="change_content_to('Home')">
                    <img src="/images/home.png"/>
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
                        <asp:TextBox runat="server" CssClass="form-control mr-sm-2" ID="txtSearch" Placeholder="Search" />
                        </li>
                        <li class="nav-item">
                        <asp:ImageButton cssClass="btn btn-primary my-2 my-sm-0" ID="ibtnSearch" runat="server" AlternateText="" ImageAlign="right" ImageUrl="/images/search.png" OnClick="ibtnSearch_Click"/>
                        </li>
                        <li class="nav-item">
                            <img alt="Account info" class="nav-link" src="/images/user.png" onclick="change_content_to('Account')"/>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- sidebar -->
            <div class="sidenav">
                <a href="#" data-toggle="tooltip" title="Add New Recipe" onclick="show_new_recipe_form()">
                    <img src="/images/add-property.png">
                </a>
                <!--<a href="#">Services</a>
                <a href="#">Clients</a>
                <a href="#">Contact</a>-->
            </div>
        
            <!-- Recipes view  -->
            <div class="jumbotron page_container recipes_container" hidden>
                <h1 class="display-3">Recipes</h1>

                <!--<p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.</p>-->
                <hr class="my-4" />
                <!-- TODO: add onclick functionality to show recipe on same page-->
                <asp:Repeater runat="server" ID="myRecipes">
                    <ItemTemplate>
                        <div class="card border-primary mb-3 recipe">
                            <div class="card-header">
                                <asp:Literal runat="server" Text='<%#((String)Eval("title")).Trim() %>'></asp:Literal>
                                <asp:ImageButton runat="server" ID="imgbtnRecipeEdit" ImageUrl="images/icons8-edit-32.png" CssClass="edit_image" OnClientClick="editImage_Click" ></asp:ImageButton>
                            </div>
                            <div class="card-body">
                                <h4 class="card-title">
                                    Time: <asp:Literal runat="server" Text='<%#Eval("time") %>' ></asp:Literal> Minutes
                                </h4>
                                <p class="card-text">
                                    <asp:Image ID="img" runat="server" src='<%#Eval("img_path").ToString().Trim() %>' style="max-width: 17rem; max-height: 12rem"></asp:Image>
                                </p>
                                <img src="<%# RateToImagePath(Eval("rate"),1) %>"/>
                                <img src="<%# RateToImagePath(Eval("rate"),2) %>"/>
                                <img src="<%# RateToImagePath(Eval("rate"),3) %>"/>
                                <img src="<%# RateToImagePath(Eval("rate"),4) %>"/>
                                <img src="<%# RateToImagePath(Eval("rate"),5) %>"/>
                                <br />
                                <img src="<%# RecipeIsVegan(Eval("id")) %>" />
                                <img src="<%# RecipeContainsDairy(Eval("id")) %>" />
                                <img src="<%# RecipeContainsMeat(Eval("id")) %>" />
                                <img src="<%# RecipeContainsFish(Eval("id")) %>" />
                                <span style="font-size:11px;float:right;">by <%# getOwnerName(Eval("owner")) %></span>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- Home Page-->
            <div class="jumbotron home page_container">
                <!-- TODO: add welcome page -->
                <h1 class="display-3">Welcome to Our Kitchen App!</h1>
                <p class="lead">This is Daniel Tibi's and Ron Yalensky's final web course project.</p>
                <hr class="my-4" />
                <p>Feel free to navigate, add, search, sign in, register or do anything you like in our web site!</p>
                <p class="lead">
                <a class="btn btn-primary btn-lg" onclick="change_content_to('Browse')" href="#" role="button">Enjoy!</a>
                </p>
            </div>

            <!-- Categories Page-->
            <div class="jumbotron home categories_page">
                <asp:Panel ID="pnlCategoriesPage" runat="server" >
                    <h1 class="display-3">Categories</h1>
                    <hr />
                    <div onclick="category_click('vegan')" class="card text-white bg-success mb-3 category-k">
                      <div class="card-header">Vegan Recipes</div>
                      <div class="card-body">
                        <h4 class="card-title"><img src="/images/icons8-vegan-food-96.png" /></h4>
                        <p class="card-text">This categorie contains Vegan food recipes.</p>
                      </div>
                    </div>
                    <div class="card text-white bg-danger mb-3 category-k" onclick="category_click('meat')">
                      <div class="card-header">Meaty Recipes</div>
                      <div class="card-body">
                        <h4 class="card-title"><img src="/images/icons8-thanksgiving-96.png" /></h4>
                        <p class="card-text">This category contains recipes that have any kind of animals in them... Cow, Chicken, Sheep etc... Yumm!!!</p>
                      </div>
                    </div>
                    <div class="card text-white bg-warning mb-3 category-k" onclick="category_click('dairy')">
                      <div class="card-header">Dairy Recipes</div>
                      <div class="card-body">
                        <h4 class="card-title"><img src="/images/icons8-cheese-96.png" /></h4>
                        <p class="card-text">This category contains recipes with dairy products in its ingrediants.</p>
                      </div>
                    </div>
                    <div class="card text-white bg-info mb-3 category-k" onclick="category_click('fish')">
                      <div class="card-header">Fish Recipes</div>
                      <div class="card-body">
                        <h4 class="card-title"><img src="/images/icons8-fish-food-96.png" /></h4>
                        <p class="card-text">Fish food recipes of any kind. shrimps sea food and more! amazing!</p>
                      </div>
                    </div>
                </asp:Panel>
                <asp:Panel runat="server" ID="pnlCategoryView" >
                    <h1 class="display-3"> <asp:Literal runat="server" ID="ltrCategoryName">
                    </asp:Literal></h1>
                    <hr />
                    <div class="breadcrumb">
                        <asp:ImageButton runat="server" ID="btnBackToCategorySelectionView" OnClick="ShowCategories_Click" ImageUrl="/images/icons8-back-arrow-24.png" /> Select Category
                    </div>
                    <asp:Repeater runat="server" ID="rptCategory">
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
                                        <asp:Image ID="img" runat="server" src='<%#Eval("img_path").ToString().Trim() %>' style="max-width: 17rem; max-height: 12rem"></asp:Image>
                                    </p>
                                    <img src="<%# RateToImagePath(Eval("rate"),1) %>"/>
                                    <img src="<%# RateToImagePath(Eval("rate"),2) %>"/>
                                    <img src="<%# RateToImagePath(Eval("rate"),3) %>"/>
                                    <img src="<%# RateToImagePath(Eval("rate"),4) %>"/>
                                    <img src="<%# RateToImagePath(Eval("rate"),5) %>"/>
                                    <br />
                                    <img src="<%# RecipeIsVegan(Eval("id")) %>" />
                                    <img src="<%# RecipeContainsDairy(Eval("id")) %>" />
                                    <img src="<%# RecipeContainsMeat(Eval("id")) %>" />
                                    <img src="<%# RecipeContainsFish(Eval("id")) %>" />
                                    <span style="font-size:11px;float:right;">by <%# getOwnerName(Eval("owner")) %></span>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Panel runat="server" ID="pnlNoRecipes" CssClass="alert alert-dismissible alert-warning">
                        <h4 class="alert-heading">Ops!</h4>
                        <p class="mb-0"><asp:Literal runat="server" ID="ltrNoRecipes">
                        </asp:Literal></p>
                    </asp:Panel>
                    
                </asp:Panel>
            </div>
           
            <!-- Add new Recipe view -->
            <div class="jumbotron new_recipe_container" hidden="hidden">
                <div class="alert-info">
                    <asp:Literal runat="server" ID="ltLoginStatus" Text=""></asp:Literal>
                    <asp:HyperLink id="hlLoginLink" NavigateUrl="login_reg.aspx" Text="Click Here to Login" runat="server"/> 
                </div>                
                <a href="#" onclick="close_new_recipe()"><img class="close_window" src="/images/close-window.png"/></a>
                <asp:Panel runat="server" ID="pnlNewRecipeForm">
                    <div class="form-group">
                        <asp:TextBox ID="txtRecipeName" runat="server" cssClass="form-control"  placeholder="Recipe Name"/>
                        <p class="text-danger">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtRecipeName" ErrorMessage="Recipe title is required!">
                            </asp:RequiredFieldValidator>
                        </p>
                        <small class="form-text text-muted">Try to keep it simple.</small>
                    </div>
                    <div class="form-group form-inline">
                        <%--<table class="form_row">
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
                        </table>--%>
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
                                    </td>
                                    </tr>
                                <tr><td></td>
                                    <td>
                                        <small class="form-text text-muted">In Minutes</small>
                                        <span class="text-danger">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtTime" ErrorMessage="Time is Required">
                                            </asp:RequiredFieldValidator>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form_row_description">
                                        <label style="justify-content:flex-end;">Rate:</label>
                                    </td>
                                    <asp:TextBox runat="server" ID="txtRate" ></asp:TextBox>

                                    <td class="form_row_value">
                                        <img id="star-1" class="rate-stars" src="/images/emptyStar.png" />
                                        <img id="star-2" class="rate-stars" src="/images/emptyStar.png" />
                                        <img id="star-3" class="rate-stars" src="/images/emptyStar.png" />
                                        <img id="star-4" class="rate-stars" src="/images/emptyStar.png" />
                                        <img id="star-5" class="rate-stars" src="/images/emptyStar.png" />
                                        <p class="text-danger">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtRate" ErrorMessage="Rate is Required (minimum 1 star)">
                                            </asp:RequiredFieldValidator>
                                        </p>
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
                                    <p class="text-danger">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="fileuploadRecipeThumb" ErrorMessage="File Required!">
                                        </asp:RequiredFieldValidator>
                                    </p>
                                </p>
                            </div>
                        </div>
                    </div>
                    <p class="text-danger">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtIngrediants" ErrorMessage="Must use at least 1 ingredient!">
                        </asp:RequiredFieldValidator>
                    </p>
                    <div class="form-group form-inline">
                        <label>Recipe Image:</label>
                        <asp:FileUpload id="fileuploadRecipeThumb" runat="server" />
                        <p class="text-danger"><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                            ControlToValidate="fileuploadRecipeThumb" ErrorMessage="File Required!">
                        </asp:RequiredFieldValidator></p>
                    </div>
                    <asp:Button runat="server" OnClick="btnSubmit_Click" id="btnSubmit" cssClass="btn btn-primary" text="Submit" type="submit"/>
                 </asp:Panel>
                </div>

            <!--TODO: Ron.Y add a view recipe container-->

            <!-- Search Results -->
            <div class="jumbotron page_container search_results">
                <h1 class="display-3"> Search Results: <asp:Literal runat="server" ID="ltSearchTerm">
                    </asp:Literal></h1>
                <hr class="my-4" />
                <asp:Repeater runat="server" ID="rptSearchResults">
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
                                    <asp:Image ID="img" runat="server" src='<%#Eval("img_path").ToString().Trim() %>' style="max-width: 17rem; max-height: 12rem"></asp:Image>
                                </p>
                                <img src="<%# RateToImagePath(Eval("rate"),1) %>"/>
                                <img src="<%# RateToImagePath(Eval("rate"),2) %>"/>
                                <img src="<%# RateToImagePath(Eval("rate"),3) %>"/>
                                <img src="<%# RateToImagePath(Eval("rate"),4) %>"/>
                                <img src="<%# RateToImagePath(Eval("rate"),5) %>"/>
                                <br />
                                <img src="<%# RecipeIsVegan(Eval("id")) %>" />
                                <img src="<%# RecipeContainsDairy(Eval("id")) %>" />
                                <img src="<%# RecipeContainsMeat(Eval("id")) %>" />
                                <img src="<%# RecipeContainsFish(Eval("id")) %>" />
                                <span style="font-size:11px;float:right;">by <%# getOwnerName(Eval("owner")) %></span>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- Account Info Floaty -->
            <div class="floating-account-info card border-primary mb-3" hidden>
                <a href="#" onclick="close_account_floaty()"><img class="close_window" src="/images/close-window.png"/></a>
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
            
            <!-- User Recipes Edit page -->
            <div class="jumbotron page_container edit_my_recipes">
            
            </div>
        </asp:Panel>
        <!-- Footer -->
        <div class="footer">
            <a href="https://icons8.com/icon/45894/kitchenwares">icons by Icons8</a>
        </div>
    </form>
    <link href="include/style.css" rel="stylesheet" />
    <script src="include/jquery-2.0.0.min.js"></script>
    <link href="include/bootstrap_journal.min.css" rel="stylesheet" />
    <script src="include/bootstrap.min.js"></script>
    <script src="include/classes.js"></script>
    <script src="include/app.js"></script>
</body>
</html>
