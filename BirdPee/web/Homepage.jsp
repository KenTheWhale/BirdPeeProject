
<%@page import="com.team1.BirdPee.DTO.Discount"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Customer"%>
<%@page import="java.util.Formatter"%>
<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="com.team1.BirdPee.DTO.Product"%>
<%@page import="com.team1.BirdPee.DTO.Category"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/Homepage.css" />
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
            if (session.getAttribute("id") != null) {// from servlet sendIDToProductDetail
                session.removeAttribute("id");
            }
            if (session.getAttribute("productSubSort") != null) {// from ProductList.jsp
                session.removeAttribute("productSubSort");
            }
            if (session.getAttribute("productSort") != null) {// from ProductList.jsp
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
                <div class="close-sidebar">&times;</div>
            </div>
        </header>
        <main>
            <div class="main__cover"></div>
            <div class="slider">
                <div class="list">
                    <div class="item">
                        <img src="https://www.allaboutbirds.org/news/wp-content/uploads/2020/07/STanager-Shapiro-ML.jpg" alt="" />
                    </div>
                    <div class="item">
                        <img src="https://static.scientificamerican.com/sciam/cache/file/7A715AD8-449D-4B5A-ABA2C5D92D9B5A21_source.png" alt="" />
                    </div>
                    <div class="item">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/3/32/House_sparrow04.jpg" alt="" />
                    </div>
                    <div class="item">
                        <img src="https://cdn.birdwatchingdaily.com/2020/02/Tufted_Titmouse_62126_Jenny_Burdette_GA2019_Overall1-e1573593877167.jpeg" alt="" />
                    </div>
                    <div class="item">
                        <img src="https://community.rspb.org.uk/resized-image/__size/960x720/__key/communityserver-blogs-components-weblogfiles/00-00-01-57-64/1256.2480.1263.2210.0474.2104990_2D00_w.jpg" alt="" />
                    </div>
                </div>
                <div class="buttons">
                    <button id="prev"><</button>
                    <button id="next">></button>
                </div>
                <ul class="dots">
                    <li class="active"></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                </ul>
            </div>
            <div class="main__category main">
                <h2>Category</h2>
                <div class="main__category_container container">
                    <!-- loop  -->
                    <%
                        ArrayList<Category> listC = BirdPeeDAO.CATEGORY_getAllCate();
                        for (Category c : listC) {
                    %>
                    <div class="column">
                        <a href="BirdPee?action=PSort&subsort=<%= c.getCode()%>"><!-- product detail link-->
                            <div class="item">
                                <img src="<%= c.getImg()%>" alt="" />  <!--category img -->
                                <h4><%= c.getName()%></h4> <!--category name -->
                            </div>
                        </a>
                    </div>
                    <%
                        }
                    %>
                    <!-- end loop  -->
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
                            Shop s = BirdPeeDAO.SHOP_getShopByProductID(p.getId());
                            float discountPrice = 1 - BirdPeeDAO.DISCOUNT_getDiscountPercentageByProductID(p.getId());
                            ArrayList<String> listI = BirdPeeDAO.PRODUCT_getImages(p.getId());
                            String name = p.getName();
                    %>
                    <div class="column">
                        <a href="BirdPee?action=ViewProduct&id=<%= p.getId()%>"><!-- product detail link-->
                            <div class="item">

                                <img src="<%= listI.get(0)%>" alt="" /> <!--Product img -->
                                <h5 style="color: grey"><%= s.getName()%></h5> <!--shop name-->
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
                            Shop s = BirdPeeDAO.SHOP_getShopByProductID(p.getId());
                            ArrayList<String> listI = BirdPeeDAO.PRODUCT_getImages(p.getId());
                            String name = p.getName();
                    %>
                    <div class="column">
                        <a href="BirdPee?action=ViewProduct&id=<%= p.getId()%>"><!-- product detail link-->
                            <div class="item">
                                <img src="<%= listI.get(0)%>" alt="" /><!--product img -->
                                <h5><%= s.getName()%></h5><!--Shop name-->
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
        <script src="js/homepage.js"></script>
    </body>

</html>

