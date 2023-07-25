<%-- 
    Document   : Success.jsp
    Created on : Jun 12, 2023, 11:43:14 AM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Product"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Item"%>
<%@page import="java.util.ArrayList"%>
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
        <link rel="stylesheet" href="css/Success.css">
        <title>BirdPee</title>
    </head>
    <body>
        <%
            Customer ac = (Customer) session.getAttribute("user");
            if (session.getAttribute("user") == null) {
                response.sendRedirect("Homepage.jsp");
            } else {
                ArrayList<Item> listI = BirdPeeDAO.CART_getAllItemInCart(ac.getId());
                String paymentMethod = (String) session.getAttribute("payment");
                if (paymentMethod == null) {
                    response.sendRedirect("Homepage.jsp");
                } else {
                    session.removeAttribute("payment");
                    String shipChoice = (String) session.getAttribute("shipchoice");
                    String shipAddress = BirdPeeDAO.ACCOUNT_getChosenAddress(ac.getId()).split("@")[6].trim();
                    long total = (long) session.getAttribute("total");
                    String status = "";

                    if (request.getParameter("vnp_Amount") != null && request.getParameter("vnp_Amount") != null) {
                        total = Long.parseLong(request.getParameter("vnp_Amount")) / 100;
                        status = request.getParameter("vnp_ResponseCode");
                    }
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
                    <a href = "<%= (ac == null) ? "Login.jsp" : "Profile.jsp"%>">
                        <li>
                            <div class="header__icon_circle">
                                <i class="fas fa-solid fa-user"></i>
                            </div>
                            <h4><%= (ac == null) ? "Account" : ac.getUsername()%></h4>
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
                    <a href = "<%= (ac == null) ? "Login.jsp" : "Cart.jsp"%>">
                        <li>
                            <div class="header__icon_circle shopping-bag" current-count="<%= (status.equalsIgnoreCase("00") || status.equalsIgnoreCase("")) ? 0 : BirdPeeDAO.CART_countNumberOfItemInCart(ac.getId())%>">
                                <i class="fas fa-solid fa-bag-shopping"></i>
                            </div>
                            <h4>Shopping Cart</h4>
                        </li>
                    </a>
                </ul>
            </div>
        </header>
        <main>
            <div class="main-container-1">
                <%
                    if (status.equalsIgnoreCase("00") || status.equalsIgnoreCase("")) {
                %>
                <div>
                    <h1 style="color: black;"><i class="fa-solid fa-clock" style="color: black;"></i> Thank you for your
                        purchase!</h1>
                </div>
                <h2><%= String.format("%,d", total)%> VND</h2>
                <%
                } else {
                %>
                <div>
                    <h1 style="color: red;"><i class="fa-solid fa-clock" style="color: red;"></i> Something is wrong, your purchase is failed!</h1>
                </div>
                <%
                    }
                    if (!paymentMethod.equalsIgnoreCase("vnpay") && status.isEmpty()) {
                %>
                <h4 style="color: red">Please prepare enough cash on the date packages shipped</h4>
                <%
                    }
                %>
            </div>
            <div class="main-container-2">
                <div class="box-container">

                    <div class="box-inner">
                        <%
                            for (Item item : listI) {
                                Product product = BirdPeeDAO.PRODUCT_getProductByID(item.getProductID());
                        %>
                        <div class="box-detail-top" style="margin-bottom: 10px">
                            <div class="image-container">
                                <img src="<%= BirdPeeDAO.PRODUCT_getImages(item.getProductID()).get(0)%>" alt="">
                            </div>
                            <div class="product-name">
                                <%= product.getName()%>
                            </div>
                            <div class="product-quantity">
                                Qty: <%= item.getQuantity()%>
                            </div>
                            <div class="product-price">
                                <%= String.format("%,.0f", BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(item.getProductID()) * item.getQuantity())%> VND
                            </div>
                            <div class="box-inner-detail">
                                Shipped by: <%= BirdPeeDAO.SHOP_getShopByProductID(item.getProductID()).getName()%>
                            </div>
                        </div>
                        <%
                            }
                        %>
                        <div class="box-detail-bottom">
                            <div>
                                <span style="color: gray;">For more details, track your delivery status under </span>
                                <span style="font-weight: bold;">Order History > Order Detail </span>
                            </div>
                            <a href="OrderHistory.jsp">View Order</a>
                        </div>
                    </div>

                </div>
            </div>
            <div class="main-container-3">
                <div class="noti-block">
                    <span> <i class="fa-regular fa-envelope" style="font-size: 20px; color: #195fd7;"></i> &nbsp; A notification about your Order Request received has been sent to <%= ac.getEmail()%> </span>
                </div>
            </div>
            <%
                if (status.equalsIgnoreCase("00") || status.equalsIgnoreCase("")) {
                    for (Item i : listI) {
                        BirdPeeDAO.PRODUCT_updateProductQuantityAfterCheckOut(i.getQuantity(), i.getProductID());
                    }
                    BirdPeeDAO.ORDER_addToOrderAfterCheckOut(listI, shipChoice, shipAddress, paymentMethod, ac.getId());

                    BirdPeeDAO.CART_removeCartByCustomerID(ac.getId());
                }
            %>
            <div class="main-container-1">
                <button><a href="Homepage.jsp">Shop More</a></button>
            </div>
        </main>
    </body>
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
        }
    %>
</body>
</html>
