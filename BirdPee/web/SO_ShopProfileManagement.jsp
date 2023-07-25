<%-- 
    Document   : SO_ShopProfileManagement
    Created on : Jul 9, 2023, 8:22:16 PM
    Author     : Admin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="com.team1.BirdPee.DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <link
            href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
            integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />

        <link rel="stylesheet" href="css/SO_ShopProfileManagement.css" />
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />

        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <title>BirdPee - Shop Owner</title>
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("user");
            if (session.getAttribute("user") == null) {
                response.sendRedirect("Login.jsp");
            } else {
                Shop s = BirdPeeDAO.SHOPOWNER_findShopByOwnerId(ac.getId());
        %>
        <nav>
            <div class="logo">
                <i class="bx bx-menu menu-icon"></i>
                <span class="logo-name">SHOP PROFILE</span>
            </div>

            <div class="user-info">
                <img src="https://cdn-icons-png.flaticon.com/512/552/552721.png" alt="" />
                <h3><%= ac.getUsername()%></h3>
            </div>

            <div class="sidebar">
                <div class="logo">
                    <i class="bx bx-menu menu-icon overlay"></i>
                    <span class="logo-name">BIRDPEE</span>
                </div>

                <div class="sidebar-content">
                    <ul class="lists">
                        <li class="list">
                            <a href="SO_Dashboard.jsp" class="nav-link">
                                <i class="bx bxs-spreadsheet icon"></i>
                                <span class="link">PROFILE</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="SO_ProductManagement.jsp" class="nav-link">
                                <i class="icon bx bxs-package"></i>
                                <span class="link">PRODUCT MANAGEMENT</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="SO_CustomerManagement.jsp" class="nav-link">
                                <i class="icon bx bxs-package"></i>
                                <span class="link">CUSTOMER MANAGEMENT</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="SO_ShopProfileManagement.jsp" class="nav-link active">
                                <i class="bx bxs-store-alt icon"></i>
                                <span class="link">SHOP PROFILE</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="SO_FeedbackManagement.jsp" class="nav-link">
                                <i class="bx bxs-comment icon"></i>
                                <span class="link">FEEDBACK MANAGEMENT</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="SO_OrderManagement.jsp" class="nav-link">
                                <i class="bx bx-notepad icon"></i>
                                <span class="link">ORDER MANAGEMENT</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="Login.jsp" class="nav-link">
                                <i class="bx bx-log-out icon"></i>
                                <span class="link">LOGOUT</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <main>
            <form action="BirdPee" method="post">
                <%
                    Cookie cookie[] = request.getCookies();
                    String name = "";
                    if (cookie != null) {
                        for (Cookie c : cookie) {
                            if (c.getName().equalsIgnoreCase("name")) {
                                name = java.net.URLDecoder.decode(c.getValue(), "UTF-8");
                                break;
                            } else {
                                name = "";
                            }
                        }
                    }
                %>
                <div class="main__shop-info">
                    <div class="main__picture-profile">
                        <div class="title">
                            <p>Shop Avatar</p>
                        </div>
                        <div class="image-place">
                            <img src="<%= s.getImg()%>" alt="" id="chosen-image" />

                            <div class="button">
                                <input type="file" id="upload-button" name="img" value="<%= s.getImg()%>"/>
                                <label for="upload-button">Upload Image</label>
                            </div>
                        </div>
                    </div>
                    <div class="main__shop-profile">
                        <div class="title">
                            <p>Shop Information</p>
                        </div>
                        <div class="input-place">
                            <div class="input-row">
                                <input type="text" name="name" id="name" oninput="keepData()" value="<%= name.isEmpty() ? s.getName() : name%>" required />
                                <label>Shop Name</label>
                            </div>
                            <div class="input-row">
                                <div class="select">
                                    <div class="input-title">
                                        <p><%= BirdPeeDAO.SHIP_getProvinceNameByID(request.getParameter("provinceid"))%></p>
                                        <i class="fa-solid fa-angle-down" style="font-size: 12px; "></i>
                                    </div>
                                    <ul class="options">
                                        <%
                                            ArrayList<String> listProvince = BirdPeeDAO.SHIP_getAllProvince();
                                            for (String province : listProvince) {
                                        %>
                                        <li>
                                            <a href="SO_ShopProfileManagement.jsp?provinceid=<%= province.split("@")[1]%>"><%= province.split("@")[0]%></a>
                                        </li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                </div>
                            </div>
                            <div class="input-row">
                                <div class="select">
                                    <div class="input-title">
                                        <p><%= request.getParameter("districtid") != null ? BirdPeeDAO.SHIP_getDistrictNameByID(request.getParameter("districtid")) : "District"%></p>
                                        <i class="fa-solid fa-angle-down" style="font-size: 12px; "></i>
                                    </div>
                                    <ul class="options">
                                        <%
                                            ArrayList<String> listDistrict = BirdPeeDAO.SHIP_getDistrictByProvinceID(request.getParameter("provinceid"));
                                            for (String district : listDistrict) {
                                        %>
                                        <li>
                                            <a href="SO_ShopProfileManagement.jsp?provinceid=<%= request.getParameter("provinceid") %>&districtid=<%= district.split("@")[1] %>"><%= district.split("@")[0] %></a>
                                        </li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                </div>
                            </div>
                            <div class="button-place">
                                <input type="hidden" name="ownerid" value="<%= ac.getId() %>"/>
                                <input type="hidden" name="provinceid" value="<%= request.getParameter("provinceid") %>"/>
                                <input type="hidden" name="districtid" value="<%= request.getParameter("districtid") %>"/>
                                <button name="action" value="SOProfileUpdate" <%= (request.getParameter("provinceid") != null && request.getParameter("districtid") != null) ? "" : "disabled" %> style="<%= (request.getParameter("provinceid") != null && request.getParameter("districtid") != null) ? "" : "background-color: gray" %>">Update</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <div class="shadow"></div>
        </main>
        <%//
            }
        %>
        <script>
            function keepData() {
                let name = document.getElementById("name");
                let nameValue = name.value;

                document.cookie = "name=" + encodeURIComponent(nameValue);
            }
        </script>
        <script src="js/SO_ShopProfileManagement.js"></script>
    </body>
</html>
