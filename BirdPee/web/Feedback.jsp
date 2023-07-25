<%-- 
    Document   : Feedback
    Created on : Jul 25, 2023, 2:51:00 AM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Product"%>
<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="com.team1.BirdPee.DTO.Order"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
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
        <link rel="stylesheet" href="css/Feedback.css">
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
        <title>BirdPee</title>
    </head>
    <body>
        <%
            Customer ac = (Customer) session.getAttribute("user");
            if (session.getAttribute("user") == null) {
                response.sendRedirect("Login.jsp");
            } else {
                int orderID = Integer.parseInt(request.getParameter("oid"));
                Order o = BirdPeeDAO.ORDER_getOrderByID(orderID);
                Product p = BirdPeeDAO.PRODUCT_getProductByID(Integer.parseInt(request.getParameter("id")));
                Shop s = BirdPeeDAO.SHOP_getShopByProductID(p.getId());
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
                    <form action="BirdPee" method="post">
                        <div class="product-review">
                            <div class="delivered-date">
                                Delivered on : <%= BirdPeeDAO.DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(o.getShipDate(), 0)%>
                            </div>
                            <div class="shop-review-title">
                                Sold By 
                                <span><a href="#" style="color: #195fd7;"><%= s.getName()%></a></span>
                            </div>
                            <div class="instruction">
                                Rate and review purchased product
                            </div>
                            <div class="product-row">
                                <div class="product-img-wrapper">
                                    <img src="<%= BirdPeeDAO.PRODUCT_getImages(p.getId()).get(0)%>" alt="">
                                </div>
                                <div class="product-rating">
                                    <div class="product-name">
                                        <%= p.getName()%>
                                    </div>
                                    <div class="rating">
                                        <div class="star-widget">
                                            <input type="radio" name="rate" value="5" id="rate-5">
                                            <label for="rate-5"><i class="fa-solid fa-star"></i></label>
                                            <input type="radio" name="rate" value="4" id="rate-4">
                                            <label for="rate-4"><i class="fa-solid fa-star"></i></label>
                                            <input type="radio" name="rate" value="3" id="rate-3">
                                            <label for="rate-3"><i class="fa-solid fa-star"></i></label>
                                            <input type="radio" name="rate" value="2" id="rate-2">
                                            <label for="rate-2"><i class="fa-solid fa-star"></i></label>
                                            <input type="radio" name="rate" value="1" id="rate-1">
                                            <label for="rate-1"><i class="fa-solid fa-star"></i></label>
                                            <div class="abc" style="order: -1; width: 150px;  ">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="feedback-form">
                                        <div class="feedback-form-title">
                                            Feedback Detail
                                        </div>
                                        <div class="feedback-form-input">
                                            <textarea placeholder="What do you think of this product?" name="comment" id="" cols="60" rows="5"></textarea>
                                        </div>
                                    </div>
                                    <div class="submit">
                                        <input type="hidden" name="pid" value="<%= request.getParameter("id")%>"/>
                                        <input type="hidden" name="oid" value="<%= request.getParameter("oid")%>"/>
                                        <button type="submit" name="action" value="SendFeedback">Submit</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
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

                    <div class="image-footer-wrapper">
                        <img src="https://cdn.haitrieu.com/wp-content/uploads/2022/10/Icon-VNPAY-QR-1024x800.png" alt="">
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
    </body>
</html>
