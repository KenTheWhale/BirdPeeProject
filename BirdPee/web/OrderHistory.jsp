<%-- 
    Document   : OrderHistory
    Created on : Jun 17, 2023, 12:31:12 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="com.team1.BirdPee.DTO.OrderDetails"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Order"%>
<%@page import="com.team1.BirdPee.DTO.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/OrderHistory.css" />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
            integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
        <title>BirdPee</title>
    </head>
    <body>
        <%
            Customer ac = (Customer) session.getAttribute("user");
            if (session.getAttribute("user") == null) {
                response.sendRedirect("Login.jsp");
            } else {
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
                <div class="main-right-container">
                    <div class="main__container_sort">
                        <span style="font-weight: bold; font-size: 20px; color: grey">
                            Show:
                        </span>
                        <div class="sort-option">
                            <%
                                String sort = (String) session.getAttribute("ordersort");
                                if (sort != null) {
                                    session.removeAttribute("ordersort");
                                }
                                if (sort == null) {
                                    sort = "Last 5 days";
                                }
                            %>
                            <p style="font-size: 20px; font-weight: bold">
                                <%= sort%>
                                <i class="fas fa-solid fa-sort-down"></i>
                            </p>
                            <ul class="options">
                                <li><a href="BirdPee?action=OSort&sort=5">Last 5 days</a></li>
                                <li><a href="BirdPee?action=OSort&sort=15">Last 15 days</a></li>
                                <li><a href="BirdPee?action=OSort&sort=30">Last 30 days</a></li>
                                <li><a href="BirdPee?action=OSort&sort=0">All Orders</a></li>
                            </ul>
                        </div>
                    </div>
                    <%
                        ArrayList<Order> listO = BirdPeeDAO.ORDER_getAllOrderItem(ac.getId(), sort);
                        for (Order o : listO) {
                            Shop s = BirdPeeDAO.SHOP_getShopByProductID(o.getListOD().get(0).getProductID());
                    %>
                    <a href="OrderDetail.jsp?id=<%= o.getId()%>">
                        <div class="order-detail">
                            <div class="order-2">
                                <div class="shop-name">
                                    <div class="shop-name-title">
                                        <div class="shop-name-wrapper">
                                            <img src="<%=  s.getImg()%>" alt="">
                                        </div>                                  
                                        <span><%= s.getName()%></span>
                                    </div>
                                    <div class="order-status">
                                        <%= BirdPeeDAO.ORDER_getOrderStatus(o.getId())%>
                                    </div>
                                </div>
                                <div class="order-create">
                                    <div>
                                        Order ID : <%= o.getId() %>
                                    </div>
                                    <div>
                                        <%= BirdPeeDAO.DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(o.getCreateDate(), 0) %>
                                    </div>
                                </div>
                            </div>
                            <%
                                for (OrderDetails item : o.getListOD()) {
                            %>
                            <div class="order-detail-main">
                                <div class="product-container">
                                    <div class="item-img-warpper">
                                        <img src="<%= BirdPeeDAO.PRODUCT_getImages(item.getProductID()).get(0)%>" alt="">
                                    </div>
                                    <div class="item-product-name"><%= item.getProductName()%> </div>
                                </div>
                                <div class="product-price"><%= String.format("%,.0f", item.getInitPrice() + item.getShipPrice())%> VND</div>
                                <div>Qty: <%= item.getQuantity()%></div>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </a>
                </div>
            </div>
        </main>

        <footer style="margin-top: 50px">
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
                    <p>Address:Site E2a-7, Road D1, ?. D1,Long Thanh My district, Thu Duc city, Ho Chi Minh city,Viet Nam. </p>
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
    </body>
</html>
