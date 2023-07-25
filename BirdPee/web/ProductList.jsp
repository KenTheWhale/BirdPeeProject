<%-- 
    Document   : ProductList
    Created on : Jun 8, 2023, 10:10:59 AM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Discount"%>
<%@page import="com.team1.BirdPee.DTO.Category"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Customer"%>
<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="com.team1.BirdPee.DTO.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/ProductList.css" />
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
            if (session.getAttribute("id") != null) {
                session.removeAttribute("id");
            }
            if (session.getAttribute("shipchoice") != null) {// from Success,jsp
                session.removeAttribute("shipchoice");
            }
            if (session.getAttribute("total") != null) {// from Success,jsp
                session.removeAttribute("total");
            }
        %>
        <header>
            <div class="header__logo">
                <a href="Homepage.jsp"><img src="images/Logo.png" alt="" /></a>
            </div>

            <div class="header__search-bar">
                <form action="BirdPee" method="post">
                    <%
                        if (((String) session.getAttribute("productSort")) != null
                                && !(((String) session.getAttribute("productSort")).equalsIgnoreCase("Popular")
                                || ((String) session.getAttribute("productSort")).equalsIgnoreCase("Discount")
                                || ((String) session.getAttribute("productSort")).equalsIgnoreCase("Rating")
                                || ((String) session.getAttribute("productSort")).equalsIgnoreCase("Price Ascending")
                                || ((String) session.getAttribute("productSort")).equalsIgnoreCase("Price Descending"))) {
                    %>
                    <input class="search" name="txtSearch" type="text" value="<%= (String) session.getAttribute("productSort")%>" />
                    <%
                    } else {
                    %>
                    <input class="search" name="txtSearch" type="text" placeholder="Find something you need" />
                    <%
                        }
                    %>
                    <input type="hidden"  value="Search" name="action" class="button">
                    <i class="fas fa-solid fa-magnifying-glass"></i> 
                </form>
                <div class="nav">
                    <p><a href="Homepage.jsp">Home Page</a></p>
                    <p><a href="ProductList.jsp">Bird's product</a></p>
                    <p><a href="ShopList.jsp">Shop List</a></p>
                </div>
            </div>

            <div class="header__icon">
                <ul>
                    <a href="<%= (ac == null) ? "Login.jsp" : "Profile.jsp"%>">
                        <li>
                            <div class="header__icon_circle">
                                <i class="fas fa-solid fa-user"></i>
                            </div>
                            <h4><%= (ac == null) ? "Account" : ac.getUsername()%></h4>
                        </li>
                    </a>
                    <a href="Notification.html">
                        <li>
                            <div class="header__icon_circle noti" current-count="0">
                                <i class="fas fa-solid fa-bell"></i>
                            </div>
                            <h4>Notification</h4>
                        </li>
                    </a>
                    <a href = "<%= (ac == null) ? "Login.jsp" : "Cart.jsp"%>">
                        <li>
                            <div class="header__icon_circle shopping-bag" current-count="<%= (ac == null) ? 0 : BirdPeeDAO.CART_countNumberOfItemInCart(ac.getId())%>">
                                <i class="fas fa-solid fa-bag-shopping"></i>
                            </div>
                            <h4>Shopping Cart</h4>
                        </li>
                    </a>
                </ul>
            </div>
        </header>

        <main>
            <nav class="main__filter">
                <%
                    String subSort = (String) session.getAttribute("productSubSort");
                    if (subSort == null) {
                        subSort = "none";
                    }
                %>
                <h2>Filter Bar</h2>
                <div class="main__filter_category">
                    <h3>Categories</h3>
                    <%
                        ArrayList<Category> listC = BirdPeeDAO.CATEGORY_getAllCate();
                        for (Category c : listC) {
                    %>
                    <p><a href="BirdPee?action=PSort&subsort=<%= c.getCode()%>" style="<%= (subSort.equalsIgnoreCase(c.getCode())) ? "font-weight: bold" : ""%>"><%= c.getName()%></a></p>
                        <%
                            }
                        %>
                </div>

                <div class="main__filter_place">
                    <h3>Sold Place</h3>
                    <%
                        ArrayList<String> listShopLocation = BirdPeeDAO.SHOP_getLocationOfAllShop();
                        for (String location : listShopLocation) {
                            String lo[] = location.split("@");
                            String locationName = lo[0];
                            String locationCode = lo[1];
                    %>
                    <p><a href="BirdPee?action=PSort&subsort=<%= locationCode%>" style="<%= (subSort.equalsIgnoreCase(locationCode)) ? "font-weight: bold" : ""%>"><%= locationName%></a></p>
                        <%
                            }
                        %>
                </div>

                <div class="main__filter_price">
                    <h3>Price Range</h3>
                    <div class="price-input">
                        <input type="text" placeholder="$ From" />
                        <span style="color: grey">-</span>
                        <input type="text" placeholder="$ To" />
                        <button>
                            <span style="font-weight: bold; font-size: 16px; color: black"
                                  >Apply</span
                            >
                        </button>
                    </div>
                </div>
            </nav>
            <div class="main__container">
                <div class="main__container_sort">
                    <span style="font-weight: bold; font-size: 20px; color: grey">
                        Sort by:
                    </span>
                    <div class="sort-option">
                        <p style="font-size: 20px; font-weight: bold">
                            <%= (((String) session.getAttribute("productSort")) != null
                                    && (((String) session.getAttribute("productSort")).equalsIgnoreCase("Popular")
                                    || ((String) session.getAttribute("productSort")).equalsIgnoreCase("Discount")
                                    || ((String) session.getAttribute("productSort")).equalsIgnoreCase("Rating")
                                    || ((String) session.getAttribute("productSort")).equalsIgnoreCase("Price Ascending")
                                    || ((String) session.getAttribute("productSort")).equalsIgnoreCase("Price Descending"))) ? (String) session.getAttribute("productSort") : (request.getParameter("sort") != null ? request.getParameter("sort") : "Popular")%>

                            <%
                                String sort = (String) session.getAttribute("productSort");
                                if(request.getParameter("sort") != null){
                                    sort = request.getParameter("sort");
                                    subSort = "none";
                                }
                                if (sort == null) {
                                    sort = "Popular";
                                }
                            %>
                            <i class="fas fa-solid fa-sort-down"></i>
                        </p>
                        <ul class="options">
                            <li><a href="BirdPee?action=PSort&sort=Popular">Popular</a></li>
                            <li><a href="BirdPee?action=PSort&sort=Discount">Discount</a></li>
                            <li><a href="BirdPee?action=PSort&sort=Rating">Rating</a></li>
                            <li><a href="BirdPee?action=PSort&sort=Ascending">Price Ascending</a></li>
                            <li><a href="BirdPee?action=PSort&sort=Descending">Price Descending</a></li>
                        </ul>
                    </div>
                </div>
                <div class="main__container_product-list">
                    <%//
                        ArrayList<Product> listP = BirdPeeDAO.PRODUCT_getAllProductAfterSorted(sort, subSort);
                        if (listP != null && !listP.isEmpty()) {
                            for (Product p : listP) {
                                ArrayList<String> listI = BirdPeeDAO.PRODUCT_getImages(p.getId());
                                Shop s = BirdPeeDAO.SHOP_getShopByProductID(p.getId());
                                int rating = BirdPeeDAO.PRODUCT_getRatingByID(p.getId());
                    %>
                    <div class="column">
                        <a href="BirdPee?action=ViewProduct&id=<%= p.getId()%>">
                            <div class="item">
                                <img src="<%= listI.get(0)%>" alt="" /><!--product img -->
                                <h5><%= s.getName()%></h5>
                                <div class="name-text">
                                    <p><%= p.getName()%></p>
                                </div>
                                <div class="sold">
                                    <p style="margin-bottom: 5px"><%= p.getSoldQuantity()%> Has Been Sold</p>
                                </div>
                                <div class="rating-star">
                                    <%
                                        for (int i = 0; i < rating; i++) {
                                    %>
                                    <i class="fa-solid fa-star" style="color: #ffd43b"></i>
                                    <%
                                        }
                                        for (int i = 0; i < (5 - rating); i++) {
                                    %>
                                    <i class="fa-solid fa-star" style="color: whitesmoke"></i>
                                    <%
                                        }
                                    %>
                                </div>
                                <%
                                    float discountPrice = 0;
                                    if (p.getIsDiscount() == 1) {
                                        discountPrice = BirdPeeDAO.DISCOUNT_getDiscountPercentageByProductID(p.getId());
                                %>
                                <div class="discount-tag">
                                    <span class="discount-percent"><%= String.format("%.0f", discountPrice * 100)%>%</span>
                                    <span class="discount-label">DISCOUNT</span>
                                </div>
                                <div class="price">
                                    <span class="old-price" style="text-decoration: line-through; color: gray; font-size: 70%"><%= String.format("%,.0f", p.getPrice())%> VND</span>

                                    <span class="new-price" style="color: green"><%= String.format("%,.0f", BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(p.getId()))%> VND</span>
                                </div>
                                <%
                                } else {
                                %>
                                <div class="price">
                                    <span class="new-price" style="color: green"><%= String.format("%,.0f", p.getPrice())%> VND</span>
                                </div>
                                <%
                                    }
                                    Discount d = BirdPeeDAO.DISCOUNT_getDiscountInformationByProductID(p.getId());
                                    if (d.getIsFreeShip() == 1) {
                                %>
                                <img class="icon" src="images/free-delivery-free-svgrepo-com.svg" alt=""/>
                                <%
                                    }
                                %>
                            </div>
                        </a>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
                <ul class="listPage"></ul>
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

        <script src="js/ProductList.js"></script>
    </body>
</html>
