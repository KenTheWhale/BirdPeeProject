<%-- 
    Document   : AD_ShopManagement
    Created on : Jul 27, 2023, 2:17:21 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <link rel="stylesheet" href="css/AD_ShopManagement.css">
        <link rel="stylesheet" type="text/css"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
        <title>BirdPee - Admin</title>
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("user");
            if (ac == null) {
                response.sendRedirect("Login.jsp");
            } else {
        %>
        <nav class="navbar navbar-expand-lg navbar-light " style="background-color: #76a463; width: 100vw;">
            <nav class="navbar navbar-light" style="background-color: #76a463;">
                <a class=" navbar-brand d-flex align-items-center" href="AD_Dashboard.jsp">
                    <img src="images/Logo.png" width="75" height="75" class="d-inline-block align-top" alt="">

                </a>
            </nav>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" style="font-size: larger;" href="AD_ShopManagement.jsp">Manage Shop <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" style="font-size: larger;" href="AD_CustomerManagement.jsp">Manage Customer <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" style="font-size: larger;" href="AD_ReportManagement.jsp">Manage Report <span class="sr-only">(current)</span></a>
                    </li>


                </ul>
                <form class="form-inline my-2 my-lg-0" style="margin-right: 2%;">

                    <a class="nav-link" href="Login.jsp"
                       style="color: black; font-size: 20px; display: flex; align-items: center;gap: 5%;"> <i
                            class="fa-solid fa-right-from-bracket"></i> Logout <span class="sr-only">(current)</span></a>

                </form>
            </div>
        </nav>
        <main>
            <div class="container-fluid" >
                <div class="table-header">
                    <div class="filter">
                        <div class="input-title">
                            <div style="font-size: 20px"><%= request.getParameter("sort") != null ? request.getParameter("sort") : "All"%></div>
                            <i class="fa-solid fa-angle-down" style="font-size: 20px; "></i>
                        </div>
                        <ul class="options">
                            <li><a style="text-decoration: none; color: black" href="AD_ShopManagement.jsp">All</a></li>
                            <li><a style="text-decoration: none; color: black" href="AD_ShopManagement.jsp?sort=Revenue">Revenue</a></li>
                            <li><a style="text-decoration: none; color: black" href="AD_ShopManagement.jsp?sort=Rating">Rating</a></li>
                            <li><a style="text-decoration: none; color: black" href="AD_ShopManagement.jsp?sort=Active">Active</a></li>
                            <li><a style="text-decoration: none; color: black" href="AD_ShopManagement.jsp?sort=Banned">Banned</a></li>
                        </ul>
                    </div>
                    <form class="form-search" action="BirdPee" method="post">
                        <div class="input-group">
                            <div class="form-outline">
                                <input type="search" name="searchkey" placeholder="Enter shop's name..." id="form1" class="form-control" />
                            </div>
                            <button name="action" value="ADSearch" class="btn btn-primary">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>
                </div>

                <div class="add-pop-up" id="formContainer" style="display: none;">

                    <div class="pop-up-title">
                        <p> Create new SO account</p>
                        <label for="x" onclick="closeForm()" style="cursor: pointer;">
                            <i class="fa-solid fa-x"></i>
                        </label>
                    </div>
                    <div class="popup-input">
                        <form action="BirdPee" method="post">
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="basic-addon1">SO#</span>
                                <input type="text" class="form-control" name="username" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">
                                <input type="hidden" name="ca" value="Add">
                            </div>
                            <div>
                                <span class="input-group-text" id="basic-addon1">Default Password: 12345</span>
                            </div>
                            <div class="create-button">
                                <button type="submit" name="action" value="ADCreateSOAccount">Create</button>
                            </div>
                        </form>
                    </div>
                </div>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Shop's name</th>
                            <th scope="col">Owner's name</th>
                            <th scope="col">Revenue</th>
                            <th scope="col">Rating</th>
                            <th scope="col">Status</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Shop> listS = BirdPeeDAO.ADMIN_getAllShops();
                            if (session.getAttribute("list") != null) {
                                listS = (ArrayList<Shop>) session.getAttribute("list");
                                session.removeAttribute("list");
                            }
                            if (request.getParameter("sort") != null) {
                                listS = BirdPeeDAO.ADMIN_getAllShopsSort(request.getParameter("sort"));
                            }
                            for (Shop s : listS) {
                        %>
                    <form action="BirdPee" method="post">
                        <tr>
                            <th scope="row"><%= s.getId()%></th>
                            <td><%= s.getName()%></td>
                            <td><%= BirdPeeDAO.SHOPOWNER_getOwnerName(s.getOwnerid()).split("#")[1] %></td>
                            <td><%= String.format("%,.0f", BirdPeeDAO.SHOP_getShopRevenue(s.getId()))%> VND</td>
                            <td><%= BirdPeeDAO.SHOPOWNER_getRating(s.getId())%> &nbsp;<i class="fa-solid fa-star" style="color: gold;"></i></td>
                            <td><%= BirdPeeDAO.ADMIN_getShopOwnerAccount(s.getOwnerid()).getStatus() == 1 ? "Active" : "Banned"%></td>
                        <input type="hidden" name="status" value="<%= BirdPeeDAO.ADMIN_getShopOwnerAccount(s.getOwnerid()).getStatus()%>"/>
                        <input type="hidden" name="owid" value="<%= s.getOwnerid()%>"/>
                        <td><button style="border-radius: 5px;" name="action" value="ADBanShop"><%= BirdPeeDAO.ADMIN_getShopOwnerAccount(s.getOwnerid()).getStatus() == 1 ? "Ban" : "Unban"%></button></td>
                        </tr>
                    </form>
                    <%
                        }
                    %>
                </table>       
                <div class="add" style="float: right; margin-right: 5%">
                    <button onclick="showForm()">Add</button>
                </div>
            </div>
        </main>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script>
                        function showForm() {
                            var formContainer = document.getElementById("formContainer");
                            formContainer.style.display = "block";
                        }
                        function closeForm() {
                            var formContainer = document.getElementById("formContainer");
                            formContainer.style.display = "none";
                        }
        </script>
        <%// 
            }
        %>
    </body>
</html>
