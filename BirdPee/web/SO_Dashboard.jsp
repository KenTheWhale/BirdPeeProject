<%-- 
    Document   : SO_Dashboard
    Created on : Jul 8, 2023, 4:28:20 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/SO_Dashboard.css" />
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
                <span class="logo-name">DASHBOARD</span>
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
                            <a href="SO_Dashboard.jsp" class="nav-link active">
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
                            <a href="SO_ShopProfileManagement.jsp?provinceid=<%= BirdPeeDAO.SHIP_getProvinceIDByShopID(s.getId()).trim() %>&districtid=<%= BirdPeeDAO.SHIP_getDistrictIDByShopID(s.getId()).trim() %>" class="nav-link">
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
            <div class="cards">
                <div class="card-single">
                    <div>
                        <h1><%= BirdPeeDAO.SHOPOWNER_getAllFeedbackByOwnerID(ac.getId()).size()%></h1>
                        <span>Feedback</span>
                    </div>
                    <div>
                        <i class="fas fa-solid fa-message" style="color: green"></i>
                    </div>
                </div>
                <div class="card-single">
                    <div>
                        <h1><%= BirdPeeDAO.SHOPOWNER_getAllFollowerByOwnerID(ac.getId()).size()%></h1>
                        <span>Follower</span>
                    </div>
                    <div>
                        <i class="fas fa-solid fa-user" style="color: green"></i>
                    </div>
                </div>
                <div class="card-single">
                    <div>
                        <h1><%= BirdPeeDAO.SHOPOWNER_getAllOrderSoldCurrentTimeTypeByOwnerID(ac.getId(), "MONTH").size()%></h1>
                        <span>Orders</span>
                        <p class="<%= BirdPeeDAO.SHOPOWNER_getGrowingOrderPercentage(ac.getId(), "MONTH") > 0 ? "plus" : "minus"%>"><%= BirdPeeDAO.SHOPOWNER_getGrowingOrderPercentage(ac.getId(), "MONTH") > 0 ? "+" : ""%><%= String.format("%.2f", BirdPeeDAO.SHOPOWNER_getGrowingOrderPercentage(ac.getId(), "MONTH"))%>% <span style="color: gray; font-size: 10px">of last month</span></p>
                    </div>
                    <div>
                        <i class="fas fa-solid fa-bag-shopping" style="color: green"></i>
                    </div>
                </div>
                <div class="card-single">
                    <div>
                        <h3><%= String.format("%,.0f", BirdPeeDAO.SHOPOWNER_getAmountPricePresent(ac.getId(), "MONTH"))%> VND</h3>
                        <span>Income</span>
                        <p class="<%= BirdPeeDAO.SHOPOWNER_getGrowingPricePercentage(ac.getId(), "MONTH") > 0 ? "plus" : "minus"%>"><%= BirdPeeDAO.SHOPOWNER_getGrowingPricePercentage(ac.getId(), "MONTH") > 0 ? "+" : ""%><%= String.format("%.2f", BirdPeeDAO.SHOPOWNER_getGrowingPricePercentage(ac.getId(), "MONTH"))%>%</p>
                    </div>
                    <div>
                        <i class="fas fa-solid fa-money-bill-1-wave" style="color: green"></i>
                    </div>
                </div>
            </div>
            <div class="chart-place">
                <div class="chart-container">
                    <h2 class="title">Order Quantity (Order quantity / Month)</h2>
                    <div class="chart-1">
                        <canvas id="soldproduct" width="800" height="600"></canvas>
                    </div>
                </div>
                <div class="chart-container">
                    <h2>Revenue (Revenue / Month)</h2>
                    <div class="chart-2">
                        <canvas id="revenuechart" width="800" height="600"></canvas>
                    </div>
                </div>
                <div class="chart-container">
                    <h2>Top 10 Hot Products (Sold quantity / Product ID)</h2>
                    <div class="chart-3">
                        <canvas id="topproducts" width="800" height="600"></canvas>
                    </div>
                </div>
                <div class="chart-container">
                    <h2>Order Status (In current month)</h2>
                    <div class="chart-4">
                        <canvas id="order-status" width="100" height="200"></canvas>
                    </div>
                </div>
            </div>
            <div class="shadow"></div>
        </main>


        <!--        Sold product chart       -->
        <%//
            ArrayList<String> productSoldBC = BirdPeeDAO.SHOPOWNER_productSoldBarChart(ac.getId(), 5, "MONTH", "YEAR");
            for (int i = 0; i < productSoldBC.size(); i++) {
                String date = BirdPeeDAO.SHOPOWNER_changeToMonth(Integer.parseInt(productSoldBC.get(i).split("@")[0])) + ", " + productSoldBC.get(i).split("@")[1];
                String data = productSoldBC.get(i).split("@")[2];
        %>
        <input type="hidden" id="PSBCdate_<%= i + 1%>" value="<%= date%>"/>
        <input type="hidden" id="PSBCdata_<%= i + 1%>" value="<%= data%>"/>
        <%
            }
        %>
        <!--        Sold product chart       -->


        <!--        Revenue chart       -->
        <%
            ArrayList<String> revenueBC = BirdPeeDAO.SHOPOWNER_revenueBarChart(ac.getId(), 5, "MONTH", "YEAR");
            for (int i = 0; i < revenueBC.size(); i++) {
                String date = BirdPeeDAO.SHOPOWNER_changeToMonth(Integer.parseInt(revenueBC.get(i).split("@")[0])) + ", " + revenueBC.get(i).split("@")[1];
                String data = revenueBC.get(i).split("@")[2];
        %>
        <input type="hidden" id="RBCdate_<%= i + 1%>" value="<%= date%>"/>
        <input type="hidden" id="RBCdata_<%= i + 1%>" value="<%= data%>"/>
        <%
            }
        %>
        <!--        Revenue chart       -->


        <!--      Hot product chart    -->
        <%
            ArrayList<String> hotProductBC = BirdPeeDAO.SHOPOWNER_hotProductBarChart(ac.getId());
            for (int i = 0; i < hotProductBC.size(); i++) {
                String productName = hotProductBC.get(i).split("@")[0];
                String data = hotProductBC.get(i).split("@")[1];
        %>
        <input type="hidden" id="HPBCname_<%= i + 1%>" value="<%= productName%>"/>
        <input type="hidden" id="HPBCdata_<%= i + 1%>" value="<%= data%>"/>
        <%
            }
        %>
        <!--      Hot product chart    -->


        <!--      Order status chart    -->
        <%
            ArrayList<String> orderStatusBC = BirdPeeDAO.SHOPOWNER_orderStatusBarChart(s.getId());
            for (int i = 0; i < orderStatusBC.size(); i++) {
                String data = orderStatusBC.get(i).split("@")[0];
                String status = orderStatusBC.get(i).split("@")[1];
        %>
        <input type="hidden" id="OSBCstatus_<%= i + 1%>" value="<%= status %>"/>
        <input type="hidden" id="OSBCdata_<%= i + 1%>" value="<%= data %>"/>
        <%//
            }
        %>
        <!--      Order status chart    -->

        <%//
            }
        %>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="js/BC_ProductSold.js"></script>
        <script src="js/BC_Revenue.js"></script>
        <script src="js/BC_HotProduct.js"></script>
        <script src="js/BC_OrderStatus.js"></script>
        <script src="js/SO_Dashboard.js"></script>
    </body>
</html>
