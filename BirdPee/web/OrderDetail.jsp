<%-- 
    Document   : OrderDetail
    Created on : Jun 18, 2023, 1:44:52 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.OrderDetails"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Product"%>
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
        <link rel="stylesheet" href="css/OrderDetail.css">
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
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
                <div class="cancel-box-container" id="formContainer" style="display: none;">
                    <div class="cancel-box-header">
                        <div class="">
                            Explain your reason
                        </div>
                        <div class="">
                            <label for="x" onclick="closeForm()" style="cursor: pointer;">
                                <i class="fa-solid fa-x"></i>
                            </label>

                            <button id="x"  style="display: none;"></button>
                        </div>
                    </div>
                    <form action="BirdPee" method="post">
                        <input type="hidden" name="orderid" value="<%= o.getId()%>"/>
                        <div class="cancel-box-main">
                            <div> <textarea name="reason" id="" cols="61" rows="5"
                                            placeholder="Please tell us the reason why you cancel this order"></textarea></div>
                            <button name="action" value="CancelOrder">Submit</button>
                        </div>
                    </form>
                </div>
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
                    <div class="main-right-title">
                        Orders Details
                        <div class="order-status1" style="float: right;">
                            <a href="OrderStatus.jsp?id=<%= o.getId()%>" style="color: #005eff; font-size: 18px;">View Order Status</a>
                        </div>
                    </div>

                    <div class="order-detail">
                        <div class="shop-name">
                            <div class="shop-name-title">
                                <div class="shop-name-wrapper">
                                    <img src="<%= s.getImg()%>" alt="">
                                </div>
                                <span><%= s.getName()%></span>

                            </div>
                            <div class="order-status-container">
                                <div class="order-status">
                                    <%= BirdPeeDAO.ORDER_getOrderStatus(o.getId())%>
                                </div>
                                <div>
                                    <%
                                        if (o.getStatus() == 2) {
                                    %>
                                    <button class="link" onclick="showForm()"
                                            style="color: #ce2121; position: fixed; margin-left: 2.5%;">Cancel
                                    </button>
                                    <%
                                        }
                                    %>

                                </div>
                            </div>
                        </div>
                        <%
                            for (OrderDetails od : o.getListOD()) {
                                Product p = BirdPeeDAO.PRODUCT_getProductByID(od.getProductID());
                        %>
                        <div class="order-detail-main">
                            <div class="product-container">
                                <div class="item-img-warpper" style="flex: 2;">
                                    <img src="<%= BirdPeeDAO.PRODUCT_getImages(p.getId()).get(0)%>" alt="">
                                </div>
                                <div style="flex: 6 ;"> 
                                    <%= BirdPeeDAO.PRODUCT_getDescription("short", p.getDescription())%>
                                </div>
                            </div>

                            <div style="flex: 7;"><%= String.format("%,.0f", BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(od.getProductID()))%> VND</div>
                            <div style="flex: 2;">
                                Qty: <%= od.getQuantity()%>
                                <%
                                    if (o.getStatus() == 5 && !BirdPeeDAO.PRODUCT_checkExistedFeedback(orderID, p.getId())) {
                                %>
                                <a href="Feedback.jsp?id=<%= p.getId() %>&oid=<%= orderID %>" style="color: #005eff; float: right; position: relative">Write feedback</a>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <div class="order-detail-inner">
                        <div class="order-detail-inner-wrapper">
                            <div class="order-id" style="margin-left: 10px;">
                                OrderID: <%= o.getId()%>
                            </div>
                            <div class="order-create-date" style="margin-left: 10px;">
                                Placed on: <%= o.getStatus() != 1 ? BirdPeeDAO.DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(o.getShipDate(), 0) : "Cancelled"%>
                            </div>
                            <div class="payment-method" style="margin-left: 10px;">
                                Paid by: <%= BirdPeeDAO.ORDER_getPaymentMethod(o.getPaymentMethodID())%>
                            </div>

                        </div>
                    </div>
                    <div class="order-bottom">
                        <div class="order-address">
                            <div style="margin-left: 10px;">Customer: <%= BirdPeeDAO.ACCOUNT_getChosenAddress(ac.getId()).split("@")[4]%></div>
                            <div style="margin-left: 10px;"> 
                                Address: <%= BirdPeeDAO.ACCOUNT_getChosenAddress(ac.getId()).split("@")[2] + ", " + BirdPeeDAO.ACCOUNT_getChosenAddress(ac.getId()).split("@")[5] + ", " + BirdPeeDAO.ACCOUNT_getChosenAddress(ac.getId()).split("@")[6]%>
                            </div>
                            <div style="margin-left: 10px;">Phone number: <%= BirdPeeDAO.ACCOUNT_getChosenAddress(ac.getId()).split("@")[3]%></div>
                        </div>
                        <div class="order-checkout">
                            <div class="order-checkout-title"> Total Summary</div>
                            <span>
                                <div>Subtotal</div>
                                <div><%= String.format("%,d", BirdPeeDAO.ORDER_getSubTotal(o.getId()))%> VND</div>
                            </span>
                            <span>
                                <div>Shipping Fee</div>
                                <div><%= String.format("%,d", BirdPeeDAO.ORDER_getShipPrice(o.getId()))%> VND</div>
                            </span>
                            <hr>
                            <span>
                                <div>Total</div>
                                <div><%= String.format("%,d", BirdPeeDAO.ORDER_getSubTotal(o.getId()) + BirdPeeDAO.ORDER_getShipPrice(o.getId()))%> VND</div>
                            </span>
                            <span >
                                Shipping type: <%= BirdPeeDAO.SHIP_getShipType(o.getShipID())%>
                            </span>
                        </div>
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
                    <p>Address:Site E2a-7, Road D1, Đ. D1,Long Thanh My district, Thu Duc city, Ho Chi Minh city,Viet Nam.
                    </p>
                    <p>Contact: 028 7300 5588 - Email: daihoc.hcm@fpt.edu.vn</p>
                    <p>Business code: 0102100740 powered by Department of Planning & Investment Ho Chi Minh city for the
                        first
                        time in 23/09/2006</p>
                    <p>© 2023 - Copyright belongs to Birdpee</p>
                </div>
            </div>
        </footer>
        <%
            }
        %>
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
    </body>
</html>
