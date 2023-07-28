<%-- 
    Document   : ShopProfile
    Created on : Jul 26, 2023, 4:56:29 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Category"%>
<%@page import="com.team1.BirdPee.DTO.Discount"%>
<%@page import="com.team1.BirdPee.DTO.Product"%>
<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="" />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
            integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />

        <link rel="stylesheet" href="css/ShopProfile.css" />
        <title>BirdPee</title>
    </head>
    <body>
        <%
            Customer ac = (Customer) session.getAttribute("user");
            if (session.getAttribute("id") == null) {
                response.sendRedirect("Homepage.jsp");
            } else {
                ArrayList<String> listN = new ArrayList<>();
                Shop s = BirdPeeDAO.SHOP_getShopByID((int) session.getAttribute("id"));
                if (ac != null) {
                    listN = BirdPeeDAO.ACCOUNT_getNotification(ac.getId());
                }
        %>
        <header>
            <div class="header__logo">
                <a href="Homepage.jsp"><img src="images/Logo.png" alt="" /></a>
            </div>

            <div class="header__search-bar">
                <form action="MainControllerServlet">
                    <input
                        class="search"
                        name="txtSearch"
                        type="text"
                        placeholder="Find something you need"
                        />
                    <input type="hidden" value="search" name="action" class="button" />
                    <i class="fas fa-solid fa-magnifying-glass"></i>
                </form>
                <div class="nav">
                    <p><a href="Homepage.jsp">Home Page</a></p>
                    <p><a href="ProductList.jsp">Bird's Products</a></p>
                    <p><a href="ShopList.jsp">Shop List</a></p>
                </div>


            </div>   
            <div id="mobile">
                <i class="fa-solid fa-bars"></i>
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
                    <a href="<%= (ac == null) ? "Login.jsp" : "Notification.jsp"%>">
                        <li>
                            <div class="header__icon_circle noti" current-count="<%= listN.size()%>">
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
            <div class="main__container">
                <div class="main__container_shop-info">
                    <div class="column-1" style="background-color: rgba(103, 103, 101, 0.7)">
                        <div class="shop-info">
                            <img src="<%= s.getImg()%>" alt="" />
                            <span><%= s.getName()%></span>
                        </div>
                        <form style="width: 100%" action="BirdPee" method="post">
                            <div class="column-1__button">
                                <%
                                    if (ac != null) {
                                %>
                                <input type="hidden" name="sid" value="<%= s.getId()%>"/>
                                <input type="hidden" name="cid" value="<%= ac.getId()%>"/>
                                <%
                                    if (!BirdPeeDAO.ACCOUNT_checkIfFollowed(s.getId(), ac.getId())) {
                                %>
                                <button name="action" value="FollowShop">Follow</button>
                                <%
                                } else {
                                %>
                                <button name="action" value="UnfollowShop">Unfollow</button>
                                <%
                                    }
                                } else {
                                %>
                                <button name="action" style="background-color: gray; color: white" disabled value="UnfollowShop">Login required to follow</button>
                                <%
                                    }
                                %>
                            </div>
                        </form>
                    </div>
                    <div class="column-23">
                        <div class="column-2">
                            <ul class="row-info">
                                <li>
                                    <i class="fas fa-solid fa-crow"></i>
                                    <span>Product:<span class="details" style="color: green"><%= BirdPeeDAO.SHOP_countNumberOfProduct(s.getId())%></span></span>
                                </li>
                                <li>
                                    <i class="fa-solid fa-users"></i>
                                    <span>Follower:<span class="details" style="color: green"><%= BirdPeeDAO.SHOP_countFollowerOfShop(s.getId())%></span></span
                                    >
                                </li>
                                <li>
                                    <i class="fas fa-solid fa-star" style="color: #ffd43b"></i>
                                    <span>Rating:<span class="details" style="color: green" class="details"><%= BirdPeeDAO.SHOPOWNER_getRating(s.getId())%></span></span>
                                </li>
                            </ul>
                        </div>
                        <div class="column-3">
                            <ul class="row-info">
                                <li>
                                    <i class="fa-solid fa-user"></i>
                                    <span>Shop owner:<span class="details" style="color: green"><%= BirdPeeDAO.SHOPOWNER_getOwnerName(s.getOwnerid()).split("#")[1] %></span></span>
                                </li>
                                <li>
                                    <i class="fa-solid fa-business-time"></i>
                                    <span>Founding Date:<span class="details" style="color: green"><%= BirdPeeDAO.DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(s.getCreatedate(), 0)%></span></span>
                                </li>
                                <li>
                                    <i class="fa-sharp fa-solid fa-location-dot"></i>
                                    <span>Location:<span class="details" style="color: green"><%= BirdPeeDAO.SHOP_getShopLocation(s.getId())%></span></span
                                    >
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="main__discount main">
                    <div class="title">
                        <div class="title-left">
                            <h2 style="color: red">
                                <i class="fa-solid fa-fire"></i> Hot Deals
                            </h2>
                        </div>
                        <h3><a href="ProductList.jsp?sort=Discount">View More</a></h3>
                    </div>
                    <div class="main__discount_container container">
                        <%
                            ArrayList<Product> listP = BirdPeeDAO.PRODUCT_getAllDiscountProduct();
                            for (Product p : listP) {
                                Shop shop = BirdPeeDAO.SHOP_getShopByProductID(p.getId());
                                float discountPrice = 1 - BirdPeeDAO.DISCOUNT_getDiscountPercentageByProductID(p.getId());
                                ArrayList<String> listI = BirdPeeDAO.PRODUCT_getImages(p.getId());
                                String name = p.getName();
                        %>
                        <div class="column">
                            <a href="BirdPee?action=ViewProduct&id=<%= p.getId()%>"><!-- product detail link-->
                                <div class="item">

                                    <img src="<%= listI.get(0)%>" alt="" /> <!--Product img -->
                                    <h5 style="color: grey"><%= shop.getName()%></h5> <!--shop name-->
                                    <div class="name-text"> 
                                        <p><%= name%></p> <!-- product name -->
                                    </div>
                                    <div class="rating-star">
                                        <i class="fa-solid fa-star" style="color: #ffd43b"></i>
                                        <i class="fa-solid fa-star" style="color: #ffd43b"></i>
                                        <i class="fa-solid fa-star" style="color: #ffd43b"></i>
                                        <i class="fa-solid fa-star" style="color: #ffd43b"></i>
                                        <i class="fa-solid fa-star" style="color: #ffd43b"></i>
                                    </div>
                                    <div class="discount-tag">
                                        <span class="discount-percent"><%= String.format("%.0f", (1 - discountPrice) * 100)%>%</span>
                                        <span class="discount-label">DISCOUNT</span>
                                    </div>
                                    <div class="price">
                                        <span class="old-price" style="text-decoration: line-through; color: gray"><%= String.format("%,.0f", p.getPrice())%> VND</span>
                                        <br>
                                        <span class="new-price" style="color: green"> <%= String.format("%,.0f", p.getPrice() * discountPrice)%> VND</span><!--Product price discount-->
                                    </div>
                                    <%
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
                        %>
                    </div>
                </div>
                <div class="main__hot-seller main">
                    <div class="title">
                        <h2 style="color: green">TOP SELLING</h2>
                        <h3><a href="ProductList.jsp?sort=Popular">View More</a></h3>
                    </div>
                    <div class="main__hot-seller_container container">
                        <%
                            listP = BirdPeeDAO.PRODUCT_getAllHotProduct();
                            for (Product p : listP) {
                                Shop shop = BirdPeeDAO.SHOP_getShopByProductID(p.getId());
                                ArrayList<String> listI = BirdPeeDAO.PRODUCT_getImages(p.getId());
                                String name = p.getName();
                        %>
                        <div class="column">
                            <a href="BirdPee?action=ViewProduct&id=<%= p.getId()%>"><!-- product detail link-->
                                <div class="item">
                                    <img src="<%= listI.get(0)%>" alt="" /><!--product img -->
                                    <h5><%= shop.getName()%></h5><!--Shop name-->
                                    <div class="name-text"> 
                                        <p><%= name%></p><!--Product name-->
                                    </div>
                                    <div class="rating-star">
                                        <i class="fa-solid fa-star" style="color: #ffd43b"></i>
                                        <i class="fa-solid fa-star" style="color: #ffd43b"></i>
                                        <i class="fa-solid fa-star" style="color: #ffd43b"></i>
                                        <i class="fa-solid fa-star" style="color: #ffd43b"></i>
                                        <i class="fa-solid fa-star" style="color: #ffd43b"></i>
                                    </div>
                                    <div class="sold-place">
                                        <p
                                            class="sold"
                                            style=" color: gray"
                                            ><%= p.getSoldQuantity()%> Has Been Sold</p><!--Product sold quantity-->
                                    </div>
                                    <div class="price">
                                        <span class="new-price" style="color: green"><%= String.format("%,.0f", p.getPrice())%> VND</span><!--Product base price-->
                                    </div>
                                    <img
                                        class="icon"
                                        src="images/free-delivery-free-svgrepo-com.svg"
                                        alt=""
                                        />
                                </div>
                            </a>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="main__container_product">
                    <nav class="main__filter">
                        <%
                            String subSort = (String) session.getAttribute("productShopSubSort");
                            if (subSort == null) {
                                subSort = "none";
                            }
                        %>
                        <div class="filter-close">&times;</div>

                        <h2>
                            <i class="fa-solid fa-list" style="font-size: 18px"></i> Filter
                            Bar
                        </h2>
                        <div class="main__filter_category">
                            <h3>Categories</h3>
                            <%
                                ArrayList<Category> listC = BirdPeeDAO.CATEGORY_getAllCate();
                                for (Category c : listC) {
                            %>
                            <p><a href="BirdPee?action=PSSort&subsort=<%= c.getCode()%>" style="<%= (subSort.equalsIgnoreCase(c.getCode())) ? "font-weight: bold" : ""%>"><%= c.getName()%></a></p>
                                <%
                                    }
                                %>
                        </div>
                    </nav>
                    <div class="product-container">
                        <div class="product__container_sort">
                            <span style="font-weight: bold; font-size: 20px; color: grey"
                                  >Sort by:</span
                            >
                            <div class="sort-option">
                                <p style="font-size: 20px; font-weight: bold">
                                    <%= (((String) session.getAttribute("productShopSort")) != null
                                            && (((String) session.getAttribute("productShopSort")).equalsIgnoreCase("Popular")
                                            || ((String) session.getAttribute("productShopSort")).equalsIgnoreCase("Discount")
                                            || ((String) session.getAttribute("productShopSort")).equalsIgnoreCase("Rating")
                                            || ((String) session.getAttribute("productShopSort")).equalsIgnoreCase("Price Ascending")
                                            || ((String) session.getAttribute("productShopSort")).equalsIgnoreCase("Price Descending"))) ? (String) session.getAttribute("productShopSort") : (request.getParameter("sort") != null ? request.getParameter("sort") : "Popular")%>

                                    <%
                                        String sort = (String) session.getAttribute("productShopSort");
                                        if (request.getParameter("sort") != null) {
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
                                    <li><a href="BirdPee?action=PSSort&sort=Popular">Popular</a></li>
                                    <li><a href="BirdPee?action=PSSort&sort=Discount">Discount</a></li>
                                    <li><a href="BirdPee?action=PSSort&sort=Rating">Rating</a></li>
                                    <li><a href="BirdPee?action=PSSort&sort=Ascending">Price Ascending</a></li>
                                    <li><a href="BirdPee?action=PSSort&sort=Descending">Price Descending</a></li>
                                </ul>
                            </div>
                            <div class="filter-mobile">
                                <i id="filter-button" class="fa-solid fa-filter"></i>
                            </div>
                        </div>
                        <div class="product-container_product-list">
                            <%//
                                listP = BirdPeeDAO.SHOP_getAllShopProductAfterSorted(sort, subSort, s.getId());
                                if (listP != null && !listP.isEmpty()) {
                                    for (Product p : listP) {
                                        ArrayList<String> listI = BirdPeeDAO.PRODUCT_getImages(p.getId());
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
                            <%//
                                    }
                                }
                            %>
                        </div>
                        <ul class="listPage"></ul>
                    </div>
                </div>
            </div>
            <div class="shadow"></div>
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
        <script src="js/ShopProfile.js"></script>
    </body>
</html>
