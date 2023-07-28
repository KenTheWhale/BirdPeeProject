<%-- 
    Document   : AD_CustomerManagement
    Created on : Jul 27, 2023, 2:14:57 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <link rel="stylesheet" href="css/AD_CustomerManagement.css">
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
                            <div style="font-size: 20px"><%= request.getParameter("sort") != null ? request.getParameter("sort") : "All" %></div>
                            <i class="fa-solid fa-angle-down" style="font-size: 20px; "></i>
                        </div>
                        <ul class="options">
                            <li><a style="text-decoration: none; color: black" href="AD_CustomerManagement.jsp">All</a></li>
                            <li><a style="text-decoration: none; color: black" href="AD_CustomerManagement.jsp?sort=Active">Active</a></li>
                            <li><a style="text-decoration: none; color: black" href="AD_CustomerManagement.jsp?sort=Banned">Banned</a></li>
                        </ul>
                    </div>
                    <form class="form-search" action="BirdPee" method="post">
                        <div class="input-group">
                            <div class="form-outline">
                                <input type="search" name="searchkey" placeholder="Enter customer's name..." id="form1" class="form-control" />
                            </div>
                            <button name="action" value="ADSearchCS" class="btn btn-primary">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>
                </div>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Customer's name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Date of birth</th>
                            <th scope="col">Status</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Customer> listC = BirdPeeDAO.ADMIN_getAllCustomers();
                            if(session.getAttribute("list") != null){
                                listC = (ArrayList<Customer>) session.getAttribute("list");
                                session.removeAttribute("list");
                            }
                            if(request.getParameter("sort") != null){
                                listC = BirdPeeDAO.ADMIN_getAllCustomersSort(request.getParameter("sort"));
                            }
                            for (Customer c : listC) {
                        %>
                    <form action="BirdPee" method="post">
                        <tr>
                            <th scope="row"><%= c.getId()%></th>
                            <td><%= c.getFullname()%></td>
                            <td><%= c.getEmail() %></td>
                            <td><%= c.getIsDobSetup() == 1 ? BirdPeeDAO.DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(c.getDoB(), 0) : "Not set" %></td>
                            <td><%= c.getStatus() == 1 ? "Active" : "Banned" %></td>
                        <input type="hidden" name="status" value="<%= c.getStatus()%>"/>
                        <input type="hidden" name="id" value="<%= c.getId() %>"/>
                        <td><button name="action" value="ADBanCus"><%= c.getStatus() == 1 ? "Ban" : "Unban"%></button></td>
                        </tr>
                    </form>
                    <%
                        }
                    %>

                </table>       
            </div>
        </main>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <%
            }
        %>
    </body>
</html>
