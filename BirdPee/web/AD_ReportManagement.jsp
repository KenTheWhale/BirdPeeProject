<%-- 
    Document   : AD_ReportManagement
    Created on : Jul 27, 2023, 2:17:58 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Feedback"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <link rel="stylesheet" href="css/AD_ReportManagement.css">
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
            <div class="container-fluid">
                <div class="table-header">
                    <form action="BirdPee" method="post">
                        <div class="input-group">
                            <div class="form-outline">
                                <input type="search" name="searchkey" placeholder="Enter shop's name..." id="form1" class="form-control" />
                            </div>
                            <button name="action" value="ADSearchShop" class="btn btn-primary">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>
                </div>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col"class="text-center align-text-top" >Customer Name</th>
                            <th scope="col" class="text-center align-text-top">Product Name</th>
                            <th scope="col"class="text-center align-text-top">Shop Name</th>
                            <th scope="col" class="text-center align-text-top">Report Date</th>
                            <th scope="col"  class="text-center align-text-top">Content</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Feedback> listR = BirdPeeDAO.ADMIN_getAllReports();
                            if (session.getAttribute("list") != null) {
                                listR = (ArrayList<Feedback>) session.getAttribute("list");
                                session.removeAttribute("list");
                            }
                            for (Feedback r : listR) {
                        %>
                    <form action="BirdPee" method="post">
                        <tr>
                            <th scope="row" class="text-center" ><%= BirdPeeDAO.ACCOUNT_getCustomerNameByCustomerID(r.getCustomerID())%></th>
                            <td class="text-center" ><%= BirdPeeDAO.SHOPOWNER_getProductByID(r.getProductID()).getName() %></td>
                            <td class="text-center"  ><%= BirdPeeDAO.SHOP_getShopByProductID(r.getProductID()).getName()%></td>
                            <td class="text-center" ><%= BirdPeeDAO.DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(r.getCreateDate(), 0)%></td>
                            <td style="max-width: 400px;"  class="text-center"><%= r.getComment()%></td>
                        </tr>
                    </form>
                    <%
                        }
                    %>
                </table>
            </div>
        </main>
        <%
            }
        %>
    </body>
</html>
