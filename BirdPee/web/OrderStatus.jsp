<%-- 
    Document   : OrderStatus
    Created on : Jun 19, 2023, 10:11:45 AM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.OrderDetails"%>
<%@page import="com.team1.BirdPee.DTO.Product"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="com.team1.BirdPee.DTO.Order"%>
<%@page import="com.team1.BirdPee.DTO.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
              integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
        <link rel="stylesheet" href="css/OrderStatus.css">
        <title>BirdPee</title>
    </head>
    <body>
        <%
            Customer ac = (Customer) session.getAttribute("user");
            if (session.getAttribute("user") == null) {
                response.sendRedirect("Login.jsp");
            } else {
                int orderID = Integer.parseInt(request.getParameter("id"));
                Order o = BirdPeeDAO.ORDER_getOrderByID(orderID);
                Shop s = BirdPeeDAO.SHOP_getShopByProductID(o.getListOD().get(0).getProductID());
        %>
        <header>
            <div class="header__logo">
                <a href="Homepage.jsp"><img src="images/Logo.png" alt="" /></a>
            </div>

            <div class="header__search-bar">
                <form action="BirdPee" method="post">
                    <input class="search" name="txtSearch" type="text" placeholder="Find something you need" />
                    <input type="hidden"  value="Search" name="action" class="button">
                    <i class="fas fa-solid fa-magnifying-glass"></i> 
                </form>
                <div class="nav">
                    <p><a href="Homepage.jsp">Home Page</a></p>
                    <p><a href="ProductList.jsp">Bird's Products</a></p>
                    <p><a href="ShopList.jsp">Shop List</a></p>
                </div>
            </div>

            <div class="header__icon">
                <ul>
                    <a href = "Profile.jsp">
                        <li>
                            <div class="header__icon_circle">
                                <i class="fas fa-solid fa-user"></i>
                            </div>
                            <h4><%= ac.getUsername()%></h4>
                        </li>
                    </a>
                    <a href="#">
                        <li>
                            <div class="header__icon_circle noti" current-count="0">
                                <i class="fas fa-solid fa-bell"></i>
                            </div>
                            <h4>Notification</h4>
                        </li>
                    </a>
                    <a href = "Cart.jsp">
                        <li>
                            <div class="header__icon_circle shopping-bag" current-count="<%= BirdPeeDAO.CART_countNumberOfItemInCart(ac.getId())%>">
                                <i class="fas fa-solid fa-bag-shopping"></i>
                            </div>
                            <h4>Shopping Cart</h4>
                        </li>
                    </a>
                </ul>
            </div>
        </header>
        <main>
            <div class="main-container">
                <div class="main-nav">
                    <div class="nav-header">
                        <div class="nav-header-avatar">
                            <div class="nav-header-image-wrapper">
                                <img src="<%= ac.getImg()%>" alt="avatar">
                            </div>
                        </div>
                        <div class="nav-header-right">
                            <div class="nav-header-username">
                                <%= ac.getUsername()%>
                            </div>
                        </div>
                    </div>
                    <div class="nav-main">
                        <div class="nav-main-link">
                            <a href="Profile.jsp" class="nav-main-link-inner">
                                <div class="nav-main-link-logo">
                                    <i class="fa-sharp fa-regular fa-user" style="color: blue;"></i>
                                </div>
                                <span style="margin-left: 10px;">My Profile</span>
                            </a>
                        </div>
                        <div class="nav-main-link">
                            <a href="Address.jsp" class="nav-main-link-inner">
                                <div class="nav-main-link-logo">
                                    <i class="fa-solid fa-location-dot"></i>
                                </div>
                                <span style="margin-left: 10px;">My Address</span>
                            </a>
                        </div>
                        <div class="nav-main-link">
                            <a href="#" class="nav-main-link-inner">
                                <div class="nav-main-link-logo">
                                    <i class="fa-solid fa-bell" style="color: #1d9f26;"></i>
                                </div>
                                <span style="margin-left: 10px;">Notification</span>
                            </a>
                        </div>
                        <div class="nav-main-link">
                            <a href="OrderHistory.jsp" class="nav-main-link-inner">
                                <div class="nav-main-link-logo">
                                    <i class="fa-regular fa-clipboard" style="color: #005eff;"></i>
                                </div>
                                <span style="margin-left: 10px;">Order History</span>
                            </a>
                        </div>
                        <div class="nav-main-link">
                            <a href="BirdPee?action=Signout" class="nav-main-link-inner">
                                <div class="nav-main-link-logo">
                                    <i class="fa-solid fa-arrow-right-from-bracket"  style="color: #4502ff;"></i>
                                </div>
                                <span style="margin-left: 10px;">Log Out</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="main-right">
                    <div class="main-right-header">
                        <h1>My Order Status</h1>
                        <span>View your order status</span>
                    </div>
                    <div class="main-right-content">
                        <div class="order-id" style="margin-left: 5%; margin-bottom: 2%;margin-top: 10px;">
                            <span>Order ID: <%= o.getId()%></span>
                        </div>
                        <div class="tracking-detail-container">
                            <div class="a1">
                                Estimated Delivery time : <%= o.getStatus() != 1 ? BirdPeeDAO.DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(o.getShipDate(), 0) : "Cancelled" %>
                            </div>

                        </div>
                        <div class="status-list">
                            <div class="status-item-container" style="<%= (o.getStatus() == 2) ? "color: rgb(56, 124, 56)" : ""%>">
                                <div class="status-item ">
                                    <i class="fa-solid fa-gear"></i>
                                    <span class="status-label">Processing</span>
                                </div>
                            </div>

                            <div class="line"></div>
                            <div class="status-item-container" style="<%= (o.getStatus() == 3) ? "color: rgb(56, 124, 56)" : ""%>">
                                <div class="status-item active">
                                    <i class="fa-sharp fa-solid fa-box-archive"></i>
                                    <span class="status-label">Packed</span>
                                </div>
                            </div>
                            <div class="line"></div>
                            <div class="status-item-container" style="<%= (o.getStatus() == 4) ? "color: rgb(56, 124, 56)" : ""%>">
                                <div class="status-item ">
                                    <i class="fa-solid fa-truck"></i>
                                    <span class="status-label">In Delivery</span>
                                </div>
                            </div>
                            <div class="line"></div>
                            <div class="status-item-container" style="<%= (o.getStatus() == 5) ? "color: rgb(56, 124, 56)" : (o.getStatus() == 1 ? "color: red" : "")%>">
                                <div class="status-item ">
                                    <i class="fa-sharp fa-solid fa-circle-check"></i>
                                    <span class="status-label"><%= o.getStatus() == 1 ? "Cancelled" : "Successfully"%></span>
                                </div>
                            </div>
                        </div>
                        <%
                            for (OrderDetails item : o.getListOD()) {
                        %>
                        <div class="cart-item-inner">
                            <div class="cart-item-left">
                                <div class="image-wrap">
                                    <img src="<%= BirdPeeDAO.PRODUCT_getImages(item.getProductID()).get(0)%>" alt="...">
                                </div>
                                <div class="info">
                                    <p style="font-weight: 500; width: 200px;">
                                        <%= item.getProductName()%>
                                    </p>
                                </div>
                            </div>
                            <div class="cart-item-middle">
                                <%= String.format("%,.0f", item.getInitPrice())%> VND
                            </div>
                            <div class="cart-item-right">
                                <p>Qty: <%= item.getQuantity()%></p>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </main>
        <footer>

            <div class="left-footer">
                <span style="font-size: 20px; margin-bottom: 10px;">FOLLOW US ON :</span>
                <span style="margin-bottom: 5px;"><i class="fa-brands fa-facebook" style="color: #0f53c7;"></i>
                    &nbsp;Facebook</span>
                <span style="margin-bottom: 5px;"><i class="fa-brands fa-instagram"></i> &nbsp;Instagram</span>
                <span style="margin-bottom: 5px;"><i class="fa-brands fa-linkedin" style="color: #195fd7;"></i> &nbsp;
                    Linkedlin</span>
                <span style="margin-bottom: 5px;">Payment Method:</span>
                <div class="payment-method-logo">
                    <span><i class="fa-brands fa-cc-visa"></i> &nbsp; </span>
                    <div class="image-footer-wrapper">
                        <img src="https://cdn.haitrieu.com/wp-content/uploads/2022/10/Icon-VNPAY-QR-1024x800.png" alt="">
                    </div>
                    <div class="image-footer-wrapper">
                        <img src="https://th.bing.com/th?id=ODLS.b8df17ca-816a-439c-af59-43b1ae16d6d6&w=32&h=32&qlt=92&pcl=fffffa&o=6&pid=1.2"
                             alt="">
                    </div>
                </div>
            </div>
            <div class="right-footer">
                <div class="footer-link">
                    <a href="">Privacy Notice</a>
                    <a href="">Conditions of Use</a>
                    <a href="">Your Ads Privacy Choices</a>
                    <a href="">Payments Terms of Use</a>
                    <a href="">Cookies</a>
                    <a href="">User Agreement</a>
                </div>
                <div class="footer-details">
                    <p>Address:Site E2a-7, Road D1, Đ. D1,Long Thanh My district, Thu Duc city, Ho Chi Minh city,Viet Nam. </p>
                    <p>Contact: 028 7300 5588 - Email: daihoc.hcm@fpt.edu.vn</p>
                    <p>Business code: 0102100740 powered by Department of Planning & Investment Ho Chi Minh city for the first
                        time in 23/09/2006</p>
                    <p>© 2023 - Copyright belongs to Birdpee</p>
                </div>
            </div>
        </footer>
        <%
            }
        %>
        <script src="js/Profile.js"></script>
    </body>
</html>
