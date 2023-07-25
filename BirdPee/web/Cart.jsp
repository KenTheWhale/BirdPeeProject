<%-- 
    Document   : Cart
    Created on : Jun 11, 2023, 11:39:01 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Product"%>
<%@page import="com.team1.BirdPee.DTO.Discount"%>
<%@page import="javax.script.ScriptEngine"%>
<%@page import="javax.script.ScriptEngineManager"%>
<%@page import="com.team1.BirdPee.DTO.Customer"%>
<%@page import="com.team1.BirdPee.DTO.Item"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
            integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link rel="stylesheet" href="css/Cart.css" />
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
        <title>BirdPee</title>
    </head>
    <body>
        <%
            Customer ac = (Customer) session.getAttribute("user");
            if (session.getAttribute("user") == null) {
                response.sendRedirect("Login.jsp");
            } else {
                if (session.getAttribute("productSubSort") != null) {
                    session.removeAttribute("productSubSort");
                }
                if (session.getAttribute("productSort") != null) {
                    session.removeAttribute("productSort");
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
            <div class="main">
                <div class="main__container">
                    <div class="main__container_cart">
                        <div class="title">
                            <h2 style="color: green; font-size: 32px">Your Shopping Cart</h2>
                        </div>
                        <div class="table-place">
                            <table class="cart-tbl">
                                <thead>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        ArrayList<Item> listI = BirdPeeDAO.CART_getAllItemInCart(ac.getId());
                                        float total = 0;
                                        for (Item i : listI) {
                                            ArrayList<String> listImg = BirdPeeDAO.PRODUCT_getImages(i.getProductID());
                                            String name = BirdPeeDAO.PRODUCT_getProductByID(i.getProductID()).getName();
                                    %>
                                    <tr>
                                        <td><img src="<%= listImg.get(0)%>" alt="" /></td>
                                        <td> <div>
                                                <p>   <%= name%></p>
                                                <p><%= BirdPeeDAO.PRODUCT_getDescription("short", BirdPeeDAO.PRODUCT_getProductByID(i.getProductID()).getDescription())%></p>
                                            </div>
                                        </td>


                                        <td>
                                            <form action="BirdPee" method="post">
                                                <button class="button" name="action" value="minus">
                                                    <i class="fa-solid fa-minus"></i>
                                                </button>

                                                <input type="text" name="quantity" value="<%= i.getQuantity()%>" min="1" max="<%= BirdPeeDAO.PRODUCT_getProductByID(i.getProductID()).getQuantity()%>" readonly/>
                                                <input type="hidden" name="id" value="<%= i.getProductID()%>"/>

                                                <button class="button" name="action" value="plus">
                                                    <i class="fa-solid fa-plus"></i>
                                                </button>

                                            </form>
                                        </td>
                                        <td><%= String.format("%,.0f", BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(i.getProductID()) * i.getQuantity())%> VND</td>
                                        <td>
                                            <form action="BirdPee" method="post">
                                                <input type="hidden" name="productid" value="<%= i.getProductID()%>"/>
                                                <label for ="delete-button-<%= i.getProductID()%>">
                                                    <i class="fa-solid fa-trash"></i>
                                                    <button class="delete-button" id="delete-button-<%= i.getProductID()%>" name="action" value="DeleteCart"></button>
                                                </label>
                                            </form>
                                        </td>
                                    </tr>
                                    <%
                                            total += BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(i.getProductID()) * i.getQuantity();
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="main__container_summary">
                        <div class="title">
                            <h2 style="font-size: 30px">SUMMARY</h2>
                        </div>
                        <form action="BirdPee" method="post">
                            <div class="summary-detail">
                                <div class="price">
                                    <h2>Items: <%= BirdPeeDAO.CART_countNumberOfItemInCart(ac.getId())%></h2>
                                </div>

                                <div class="give-code">
                                    <div class="column-title">
                                        <p style="font-size: 24px; margin-bottom: 10px">VOUCHER CODE</p>
                                    </div>
                                    <div class="input-data">
                                        <input class="text-input" type="text" name="code" />
                                        <div class="underline"></div>
                                        <label>Enter Your Code</label>
                                    </div>
                                </div>
                                <div class="total">
                                    <div class="column-title">
                                        <p style="font-size: 24px; margin-bottom: 10px">
                                            TOTAL PRICE: <%= String.format("%,.0f", total)%> VND
                                        </p>
                                    </div>
                                    <div class="button-place">
                                        <input type="hidden" name="totalprice" value="<%= total%>"/>
                                        <button name="action" value="checkout" style="background-color: <%= BirdPeeDAO.CART_countNumberOfItemInCart(ac.getId()) == 0 ? "gray" : "#54b435"%>" <%= BirdPeeDAO.CART_countNumberOfItemInCart(ac.getId()) == 0 ? "disabled" : ""%>>CHECKOUT</button>
                                        <button name="action" value="continueShopping">Continue Shopping</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="related-product">
                <div class="title">
                    <h2>YOU MAY ALSO LIKE</h2>
                    <h3><a href="#">View More</a></h3>
                </div>
                <div class="product-container">
                    <%//
                        ArrayList<Product> listP = new ArrayList<>();
                        if (listI.size() == 0) {
                            listP = BirdPeeDAO.PRODUCT_getAllHotProduct();
                        } else {
                            listP = BirdPeeDAO.PRODUCT_getRelatedProduct(BirdPeeDAO.PRODUCT_getProductByID(listI.get(0).getProductID()).getCateid());
                        }

                        for (Product product : listP) {
                            ArrayList<String> listImg = BirdPeeDAO.PRODUCT_getImages(product.getId());
                            Shop s = BirdPeeDAO.SHOP_getShopByProductID(product.getId());
                            int rating = BirdPeeDAO.PRODUCT_getRatingByID(product.getId());
                    %>
                    <div class="column">
                        <a href="BirdPee?action=ViewProduct&id=<%= product.getId()%>">
                            <div class="item">
                                <img src="<%= listImg.get(0)%>" alt="" /><!--product img -->
                                <h5><%= s.getName()%></h5>
                                <div class="name-text">
                                    <p><%= product.getName()%></p>
                                </div>
                                <div class="sold">
                                    <p style="margin-bottom: 5px"><%= product.getSoldQuantity()%> Has Been Sold</p>
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
                                    if (product.getIsDiscount() == 1) {
                                        discountPrice = BirdPeeDAO.DISCOUNT_getDiscountPercentageByProductID(product.getId());
                                %>
                                <div class="discount-tag">
                                    <span class="discount-percent"><%= String.format("%.0f", discountPrice * 100)%>%</span>
                                    <span class="discount-label">DISCOUNT</span>
                                </div>
                                <div class="price">
                                    <span class="old-price" style="text-decoration: line-through; color: gray; font-size: 70%"><%= String.format("%,.0f", product.getPrice())%> VND</span>

                                    <span class="new-price" style="color: green"><%= String.format("%,.0f", BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(product.getId()))%> VND</span>
                                </div>
                                <%
                                } else {
                                %>
                                <div class="price">
                                    <span class="new-price" style="color: green"><%= String.format("%,.0f", product.getPrice())%> VND</span>
                                </div>
                                <%
                                    }
                                    Discount d = BirdPeeDAO.DISCOUNT_getDiscountInformationByProductID(product.getId());
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
        <script src="js/Cart.js"></script>
    </body>
</html>
