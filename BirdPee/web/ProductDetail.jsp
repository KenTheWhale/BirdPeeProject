<%-- 
    Document   : ProductDetail
    Created on : Jun 11, 2023, 8:30:23 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Item"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Discount"%>
<%@page import="com.team1.BirdPee.DTO.Customer"%>
<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Product"%>
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

        <link rel="stylesheet" href="css/ProductDetail.css" />
        <title>BirdPee</title>
    </head>
    <body>
        <%
            Customer ac = (Customer) session.getAttribute("user");
            if (session.getAttribute("id") == null) {
                response.sendRedirect("Homepage.jsp");
            } else {
                Product product = BirdPeeDAO.PRODUCT_getProductByID((int) session.getAttribute("id"));
                ArrayList<String> listI = BirdPeeDAO.PRODUCT_getImages(product.getId());
                Shop shop = BirdPeeDAO.SHOP_getShopByProductID(product.getId());
                ArrayList<String> listN = new ArrayList<>();
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
                <div class="img-column">
                    <img id="main-img" src="<%= listI.get(0)%>" alt="" />
                    <div class="small-img-group">
                        <%
                            for (int i = 0; i < listI.size(); i++) {
                        %>
                        <div class="small-img-col">
                            <img src="<%= listI.get(i)%>" alt="" class="small-img" />
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="detail-column">
                    <h5 style="font-size: 20px; color: grey"><%= shop.getName()%></h5>
                    <h3 style="font-size: 24px"><%= product.getName()%></h3>
                    <div class="feedback-place">
                        <ul>
                            <li>
                                <u><%= BirdPeeDAO.PRODUCT_getRatingByID(product.getId())%></u
                                ><i
                                    class="fas fa-solid fa-star"
                                    style="color: green; padding-left: 5px"
                                    ></i>
                            </li>
                            <li><u><%= BirdPeeDAO.SHOP_countFeedbackPerProduct(product.getId())%></u> Feedback</li>
                            <li><u id="maxqty"><%= product.getQuantity()%></u> available</li>
                            <li><u><%= product.getSoldQuantity()%></u> Has Been Sold</li>
                        </ul>
                        <%
                            if (ac != null) {
                        %>
                        <div class="report">
                            <p id="report-button">Report Product</p>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <form action="BirdPee" method="post">
                        <%
                            Item it = new Item();
                            if (ac != null) {
                                ArrayList<Item> listItem = BirdPeeDAO.CART_getAllItemInCart(ac.getId());
                                for (Item item : listItem) {
                                    if (item.getProductID() == product.getId()) {
                                        it = item;
                                        break;
                                    }
                                }
                            }
                        %>
                        <h2 style="font-size: 40px; color: green; margin: 20px 0"><%= String.format("%,.0f", BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(product.getId()))%> VND</h2>
                        <input type="number" id="quantity"  value="1" name="quantity" min="1" oninput="updateInput()" />
                        <input type="hidden" id="cartquantity"  value="<%= it.getQuantity()%>" name="cartquantity" oninput="updateInput()" />
                        <button id="addToCart" name="action" value="AddToCart">Add To Cart</button>
                        <button name="action" value="AddToCartC">Buy Now</button>
                    </form>
                    <div class="shadow"></div>

                    <div id="popup-report">
                        <div class="title"><h2>Explain your reason</h2></div>
                        <div id="close">&times;</div>
                        <form action="BirdPee" method="post">
                            <div class="content">
                                <textarea
                                    required
                                    name="report"
                                    id=""
                                    cols="30"
                                    rows="10"
                                    placeholder="Your Report Description"
                                    ></textarea>
                            </div>
                            <input type="hidden" name="pid" value="<%= product.getId()%>"/>
                            <button name="action" value="SendReport">Send Report</button>
                        </form>
                    </div>
                    <div class="short-des">
                        <h2>Short Desciption:</h2>
                        <span>
                            <%= BirdPeeDAO.PRODUCT_getDescription("short", product.getDescription())%>
                        </span>
                    </div>
                </div>
            </div>
            <div class="preview-box">
                <div class="details">
                    <span class="title"
                          >Image
                        <p class="current-img"></p>
                        of
                        <p class="total-img"></p
                        ></span>
                    <span class="icon fas fa-times"></span>
                </div>
                <div class="image-box">
                    <div class="slide prev"><i class="fas fa-angle-left"></i></div>
                    <div class="slide next"><i class="fas fa-angle-right"></i></div>
                    <img src="#" alt="" />
                </div>
            </div>

            <div class="popup-success">
                <div class="popup-icon">
                    <i class="fa-solid fa-check"></i>
                </div>
                <p>ADD TO CART SUCCESSFULLY</p>
            </div>
            <div class="popup-fail">
                <div class="popup-icon">
                    <i class="fa-solid fa-x"></i>
                </div>
                <p>CART EXCEEDS MAXIMUM QUANTITY</p>
            </div>

            <div class="shadow"></div>

            <div class="main__shop">
                <div class="item">
                    <div class="shop-left">
                        <img src="<%= shop.getImg()%>" alt="" />
                        <span><%= shop.getName()%></span>
                    </div>
                    <div class="shop-right">
                        <div class="product-section">
                            <div><i class="fa-solid fa-crow" style="color: green"></i><%= BirdPeeDAO.SHOP_countNumberOfProduct(shop.getId())%></div>
                            <p>Product</p>
                        </div>

                        <div class="product-section">
                            <div>
                                <i class="fa-solid fa-message" style="color: green"></i> <%= BirdPeeDAO.SHOP_countNumberOfFeedback(shop.getId())%>
                            </div>
                            <p>Feedback</p>
                        </div>

                        <div class="product-section">
                            <div><i class="fa-solid fa-star" style="color: green"></i> <%= BirdPeeDAO.SHOPOWNER_getRating(shop.getId())%></div>
                            <p>Rating</p>
                        </div>
                        <div class="button-place">
                            <a href="BirdPee?action=ViewShop&id=<%=shop.getId()%>"><button>View Shop</button></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="main__description">
                <h2 style="color: grey">Product's Desciption</h2>
                <div class="des">
                    <p class="des-detail">
                        <%= BirdPeeDAO.PRODUCT_getDescription("full", product.getDescription())%>
                    </p>
                    <span id="span"></span>
                </div>
            </div>

            <div class="main__feedback">
                <h2>Product's Feedback</h2>
                <div class="rating-sort">
                    <div class="star-column">
                        <p style="font-size: 32px; color: green">
                            <span style="font-size: 36px"><%= BirdPeeDAO.PRODUCT_getRatingByID(product.getId())%></span> on 5
                        </p>
                        <%
                            for (int i = 0; i < BirdPeeDAO.PRODUCT_getRatingByID(product.getId()); i++) {
                        %>
                        <i class="fas fa-solid fa-star" style="color: green"></i>
                        <%
                            }
                            for (int i = 0; i < (5 - BirdPeeDAO.PRODUCT_getRatingByID(product.getId())); i++) {
                        %>
                        <i class="fas fa-solid fa-star" style="color: gray"></i>
                        <%
                            }
                        %>
                    </div>

                    <div class="sort-column">
                        <a href="ProductDetail.jsp"><button class="<%= request.getParameter("star") == null ? "active" : ""%>">All</button></a>
                        <a href="ProductDetail.jsp?star=5"><button class="<%= request.getParameter("star") != null && request.getParameter("star").equalsIgnoreCase("5") ? "active" : ""%>">5 stars</button></a>
                        <a href="ProductDetail.jsp?star=4"><button class="<%= request.getParameter("star") != null && request.getParameter("star").equalsIgnoreCase("4") ? "active" : ""%>">4 stars</button></a>
                        <a href="ProductDetail.jsp?star=3"><button class="<%= request.getParameter("star") != null && request.getParameter("star").equalsIgnoreCase("3") ? "active" : ""%>">3 stars</button></a>
                        <a href="ProductDetail.jsp?star=2"><button class="<%= request.getParameter("star") != null && request.getParameter("star").equalsIgnoreCase("2") ? "active" : ""%>">2 stars</button></a>
                        <a href="ProductDetail.jsp?star=1"><button class="<%= request.getParameter("star") != null && request.getParameter("star").equalsIgnoreCase("1") ? "active" : ""%>">1 stars</button></a>
                    </div>
                </div>

                <div class="comment-section">
                    <%
                        ArrayList<String> listF = BirdPeeDAO.PRODUCT_getProductFeedback(product.getId(), request.getParameter("star"));
                        for (String item : listF) {
                            String img = item.split("@")[0].trim();
                            String username = item.split("@")[1].trim();
                            String createDate = item.split("@")[2].trim();
                            int rating = Integer.parseInt(item.split("@")[3].trim());
                            String comment = item.split("@")[4].trim();
                    %>
                    <div class="row">
                        <div class="user-info-column">
                            <img src="<%= img%>" alt="" />
                            <h3><%= username%></h3>
                        </div>
                        <div class="feedback-column">
                            <ul>
                                <li style="font-weight: bold; color: green"><%= createDate%></li>
                                <li style="padding: 8px 0">
                                    <%
                                        for (int i = 0; i < rating; i++) {
                                    %>
                                    <i class="fas fa-solid fa-star" style="color: green"></i>
                                    <%
                                        }
                                        for (int i = 0; i < (5 - rating); i++) {
                                    %>
                                    <i class="fas fa-solid fa-star" style="color: gray"></i>
                                    <%
                                        }
                                    %>
                                </li>
                                <li>
                                    <p>
                                        <%= comment%>
                                    </p>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <%
                        }
                    %>
                    <ul class="listPage"></ul>
                </div>
            </div>

            <div class="related-product">
                <div class="title">
                    <h2>YOU MAY ALSO LIKE</h2>
                    <h3><a href="#">View More</a></h3>
                </div>
                <div class="product-container">
                    <%
                        ArrayList<Product> listP = BirdPeeDAO.PRODUCT_getRelatedProduct(product.getCateid());
                        for (Product related_product : listP) {
                            ArrayList<String> listImg = BirdPeeDAO.PRODUCT_getImages(related_product.getId());
                            Shop related_shop = BirdPeeDAO.SHOP_getShopByProductID(related_product.getId());
                            int rating = BirdPeeDAO.PRODUCT_getRatingByID(related_product.getId());
                    %>
                    <div class="column">
                        <a href="BirdPee?action=ViewProduct&id=<%= related_product.getId()%>">
                            <div class="item">
                                <img src="<%= listImg.get(0)%>" alt="" /><!--product img -->
                                <h5><%= related_shop.getName()%></h5>
                                <div class="name-text">
                                    <p><%= related_product.getName()%></p>
                                </div>
                                <div class="sold">
                                    <p style="margin-bottom: 5px"><%= related_product.getSoldQuantity()%> Has Been Sold</p>
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
                                    if (related_product.getIsDiscount() == 1) {
                                        discountPrice = BirdPeeDAO.DISCOUNT_getDiscountPercentageByProductID(related_product.getId());
                                %>
                                <div class="discount-tag">
                                    <span class="discount-percent"><%= String.format("%.0f", discountPrice * 100)%>%</span>
                                    <span class="discount-label">DISCOUNT</span>
                                </div>
                                <div class="price">
                                    <span class="old-price" style="text-decoration: line-through; color: gray; font-size: 70%"><%= String.format("%,.0f", related_product.getPrice())%> VND</span>

                                    <span class="new-price" style="color: green"><%= String.format("%,.0f", BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(related_product.getId()))%> VND</span>
                                </div>
                                <%
                                } else {
                                %>
                                <div class="price">
                                    <span class="new-price" style="color: green"><%= String.format("%,.0f", related_product.getPrice())%> VND</span>
                                </div>
                                <%
                                    }
                                    Discount d = BirdPeeDAO.DISCOUNT_getDiscountInformationByProductID(related_product.getId());
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

        <script src="js/ProductDetail.js"></script>
    </body>
</html>
