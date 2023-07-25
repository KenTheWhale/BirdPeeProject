<%-- 
    Document   : SO_CustomerManagement
    Created on : Jul 12, 2023, 9:05:32 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/SO_CustomerManagement.css" />
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
                <span class="logo-name">CUSTOMER MANAGEMENT</span>
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
                                <span class="link">DASHBOARD</span>
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
                            <a href="SO_ShopProfileManagement.jsp?provinceid=<%= BirdPeeDAO.SHIP_getProvinceIDByShopID(s.getId()).trim()%>&districtid=<%= BirdPeeDAO.SHIP_getDistrictIDByShopID(s.getId()).trim()%>" class="nav-link active">
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
            <div style="padding-top: 40px">
                <form action="BirdPee" method="post">
                    <div class="filter-place">
                        <div class="search-bar">
                            <input type="text" name="keyword" placeholder="Find something you need" />
                            <i class="fas fa-solid fa-magnifying-glass"></i>
                        </div>
                        <select name="selection" id="">
                            <option <%= ((String)request.getAttribute("type")) != null && ((String)request.getAttribute("type")).equalsIgnoreCase("mail") ? "selected" : "" %> value="mail">Email</option>
                            <option <%= ((String)request.getAttribute("type")) != null && ((String)request.getAttribute("type")).equalsIgnoreCase("phone") ? "selected" : "" %> value="phone">Phone number</option>
                        </select>
                        <button type="submit" name="action" value="SOFindCustomer">Find</button>
                    </div>
                </form>
                <div class="table-section">
                    <table>
                        <thead>
                            <tr>
                                <td>Image</td>
                                <td>Email</td>
                                <td>Address</td>
                                <td>Gender</td>
                                <td>Phone Number</td>
                            </tr>
                        </thead>
                        <tbody class="tbody">
                            <%
                                String key = (request.getAttribute("key") != null && request.getAttribute("type") != null) ? (String) request.getAttribute("key") : "";
                                String type = (request.getAttribute("key") != null && request.getAttribute("type") != null) ? (String) request.getAttribute("type") : "";
                                ArrayList<Customer> listC = BirdPeeDAO.SHOPOWNER_getAllCusOfShop(s.getId(), key, type);
                                for (Customer customer : listC) {
                            %>
                            <tr class="tr">
                                <td><img src="<%= customer.getImg() %>" alt="" /></td>
                                <td><%= customer.getEmail() %></td>
                                <td><%= BirdPeeDAO.ACCOUNT_getChosenAddress(customer.getId()).split("@")[5] + " - " + BirdPeeDAO.ACCOUNT_getChosenAddress(customer.getId()).split("@")[6] %></td>
                                <td><%= customer.getGender() %></td>
                                <td><%= customer.getTel() %></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="shadow"></div>
        </main>
        <%
            }
        %>
        <script src="js/SO_CustomerManagement.js"></script>
    </body>
</html>
