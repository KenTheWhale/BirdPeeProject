<%-- 
    Document   : Checkout
    Created on : Jun 11, 2023, 4:02:52 PM
    Author     : Admin
--%>


<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="java.util.Date"%>
<%@page import="com.team1.BirdPee.DTO.Item"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
        <link rel="stylesheet" href="css/Checkout.css">

        <title>BirdPee</title>
    </head>
    <body>
        <%
            Customer ac = (Customer) session.getAttribute("user");
            if (session.getAttribute("user") == null) {
                response.sendRedirect("Login.jsp");
            } else {
                ArrayList<Item> listI = BirdPeeDAO.CART_getAllItemInCart(ac.getId());
                String address = BirdPeeDAO.ACCOUNT_getChosenAddress(ac.getId());
                if (address.isEmpty()) {
                    response.sendRedirect("Address.jsp");
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
            <div class="popup-success">
                <div class="popup-icon">
                    <i class="fa-solid fa-lock"></i>
                </div>
                <p>PLEASE ADD MISSED INFORMATION</p>
            </div>

            <div class="checkout-container row text-center">
                <div class="checkout-container-left col-md-8 order-md-1">
                    <div class="checkout-address">
                        <div class="title-wrapper">
                            <p class="address-hat" style="margin-left: 20px;">
                                Shipping Address
                            </p>
                            <a href="Profile.jsp" class="title-wrapper-edit"
                               style="margin-right: 10px; text-decoration: none; color: #76a463;">
                                Edit
                            </a>
                        </div>
                        <div class="checkout-address-inner">
                            <div class="checkout-address-title">
                                <p style="margin-left: 20px; <%= ((address.split("@")[4].equalsIgnoreCase("Not set")) ? "color: red; text-decoration: underline" : "")%>"><%= (address.equalsIgnoreCase("")) ? "No receiver" : address.split("@")[4]%></p>
                                <p style="font-weight: 500; <%= (address.split("@")[3].equalsIgnoreCase("Not set") ? "color: red; text-decoration: underline" : "")%>"><%= (ac.getTel().equalsIgnoreCase("Not set") ? "No phone number" : address.split("@")[3])%></p>
                            </div>
                            <div class="checkout-address-info" style="text-align: left;">
                                <p style="margin-left: 20px; <%= ((address.split("@")[2].equalsIgnoreCase("Not set")) ? "color: red; text-decoration: underline" : "")%>"><i class="fa-solid fa-location-dot"></i> &nbsp; <%= (address.equalsIgnoreCase("")) ? "No address was chosen" : (address.split("@")[2] + ", " + address.split("@")[5] + ", " + address.split("@")[6])%></p>
                            </div>
                        </div>
                    </div>
                    <div class="shipping method">
                        <div class="shipping-method-title">
                            <p>Choose your delivery option :</p>
                        </div>
                        <div class="shipping-card-container">
                            <%
                                float shipPrice = 0;// init ship price
                                float defaultShipPrice = 0;// init default ship price
                                String shipChoice = (String) request.getAttribute("shipchoice");// take ship choice
                                if (shipChoice == null) {// visit this page for 1st time will not have ship choice then init it as economy type
                                    shipChoice = "economy";
                                }
                                session.setAttribute("shipchoice", shipChoice);// set session to add to order
                            %>
                            <form action="BirdPee" method="post">
                                <%
                                    ArrayList<String> listShipType = BirdPeeDAO.SHIP_getAllShipType();
                                    for (String st : listShipType) {
                                        shipPrice = 0;// reset price for calculating every type of ship
                                        int shipDuration = 0;// The time to ship from depart to desti
                                        int shipID = Integer.parseInt(st.split("@")[1]); //each of "st" return type + id of each ship type
                                        String shipType = st.split("@")[0];//each of "st" return type + id of each ship type
                                        int shipDelay = BirdPeeDAO.SHIP_getShipDelay(shipID);//The time delay of each ship type
                                        int isFreeShip = 0;
                                        ArrayList<Integer> listShopID = new ArrayList<>();//Create a list contain all shop id of cart items

                                        for (Item i : listI) {// calculate the sum of ship price of all item in cart                                            
                                            int shopID = BirdPeeDAO.SHOP_getShopByProductID(i.getProductID()).getId();

                                            int initPrice = BirdPeeDAO.SHIP_getInitShipPrice(shipID);// get init ship type price by the id
                                            String customerAddress = BirdPeeDAO.ACCOUNT_getChosenAddress(ac.getId()).split("@")[6].trim();// take out the chosen address of customer
                                            String shopAddress = BirdPeeDAO.SHOP_getShopLocation(BirdPeeDAO.SHOP_getShopByProductID(i.getProductID()).getId()).trim();// take out shop address
                                            float distance = BirdPeeDAO.SHIP_getShipDistance(BirdPeeDAO.SHIP_checkLocation(customerAddress, shopAddress));// get the distance of shipping
                                            int duration = BirdPeeDAO.SHIP_getShipDuration(customerAddress, shopAddress);// get the duration of shipping
                                            if (duration > shipDuration) {// Take the lasrgest duration for the order
                                                shipDuration = duration;
                                            }
                                            isFreeShip += BirdPeeDAO.DISCOUNT_getDiscountInformationByProductID(i.getProductID()).getIsFreeShip();
                                            if (listShopID.isEmpty()) {
                                                shipPrice += initPrice * distance;// sum the ship price
                                            }
                                            if (listShopID.indexOf(shopID) == -1) {
                                                shipPrice += initPrice * distance;// sum the ship price
                                            }
                                            // Scan the list, if already have the item then delete it and re-add it, if not already then just add it
                                            if (listShopID.indexOf(shopID) >= 0) {
                                                int index = listShopID.indexOf(shopID);
                                                listShopID.remove(index);
                                            }
                                            listShopID.add(shopID);
                                            //
                                        }
                                        if (isFreeShip == listI.size()) {
                                            isFreeShip = 1;
                                        } else {
                                            isFreeShip = 0;
                                        }
                                %>
                                <button name="action" value="<%= shipType.toUpperCase().charAt(0)%>Delivery" style="<%= (shipChoice != null && shipChoice.equalsIgnoreCase(shipType)) ? "background-color: gray" : ""%>">
                                    <div class="shipping-detail-content">
                                        <div class="shipping-detail-content-1">
                                            <i class="fa-solid fa-truck" style="font-size: 20px; margin-right: 10px; margin-top: 3px;"></i>
                                            <div class="shipping-detail-1" style="text-align: left;">
                                                <span> <%= shipType%></span>
                                                <p style="margin-bottom: 5px; margin-top: 5px;"><%= (shipPrice != 0 && isFreeShip == 0) ? String.format("%,.0f", shipPrice) + " VND" : "Free ship"%></p>
                                                <p style="margin-top: 5px;">Get in : <%= BirdPeeDAO.DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(new java.util.Date(), shipDelay + shipDuration)%></p>
                                            </div>
                                        </div>
                                    </div>
                                </button>
                                <%
                                    }
                                %>
                            </form>
                            <%
                                for (String st1 : listShipType) {// get the 1st ship type as default
                                    int shipDuration1 = 0;// The time to ship from depart to desti
                                    int shipID1 = Integer.parseInt(st1.split("@")[1]); //each of "st" return type + id of each ship type
                                    int isFreeShip = 0;
                                    ArrayList<Integer> listShopID = new ArrayList<>();//Create a list contain all shop id of cart items

                                    for (Item i : listI) {// calculate the sum of ship price of all item in cart
                                        int shopID = BirdPeeDAO.SHOP_getShopByProductID(i.getProductID()).getId();

                                        int initPrice = BirdPeeDAO.SHIP_getInitShipPrice(shipID1);// get init ship type price by the id
                                        String customerAddress = BirdPeeDAO.ACCOUNT_getChosenAddress(ac.getId()).split("@")[6].trim();// take out the chosen address of customer
                                        String shopAddress = BirdPeeDAO.SHOP_getShopLocation(BirdPeeDAO.SHOP_getShopByProductID(i.getProductID()).getId()).trim();// take out shop address
                                        float distance = BirdPeeDAO.SHIP_getShipDistance(BirdPeeDAO.SHIP_checkLocation(customerAddress, shopAddress));// get the distance of shipping
                                        int duration = BirdPeeDAO.SHIP_getShipDuration(customerAddress, shopAddress);// get the duration of shipping
                                        if (duration > shipDuration1) {// Take the lasrgest duration for the order
                                            shipDuration1 = duration;
                                        }
                                        isFreeShip += BirdPeeDAO.DISCOUNT_getDiscountInformationByProductID(i.getProductID()).getIsFreeShip();
                                        if (listShopID.isEmpty()) {
                                            defaultShipPrice += initPrice * distance;// sum the ship price
                                        }
                                        if (listShopID.indexOf(shopID) == -1) {
                                            defaultShipPrice += initPrice * distance;// sum the ship price
                                        }
                                        // Scan the list, if already have the item then delete it and re-add it, if not already then just add it
                                        if (listShopID.indexOf(shopID) != -1) {
                                            int index = listShopID.indexOf(shopID);
                                            listShopID.remove(index);
                                        }
                                        listShopID.add(shopID);
                                        //
                                    }
                                    if (isFreeShip == listI.size()) {
                                        defaultShipPrice = 0;
                                    }
                                    break;
                                }
                            %>
                        </div>
                    </div>
                    <div class="package">

                        <div class="package-title" style="text-align: left;">
                            <p style="margin-left: 20px;">Your order include :</p>
                        </div>
                        <div class="cart-item-container">
                            <div class="cart-item-inner-container">
                                <%
                                    float total = 0;
                                    for (Item i : listI) {
                                        ArrayList<String> listImg = BirdPeeDAO.PRODUCT_getImages(i.getProductID());
                                        String name = BirdPeeDAO.PRODUCT_getProductByID(i.getProductID()).getName();
                                %>
                                <div class="cart-item-inner">
                                    <div class="cart-item-left">
                                        <div class="image-wrap">
                                            <img src="<%= listImg.get(0)%>" alt="...">
                                        </div>
                                        <div class="info">
                                            <p style="font-weight: bold; text-align: left;">
                                                <%= name%>
                                            </p>
                                            <p style="text-align: left;">
                                                <%= BirdPeeDAO.PRODUCT_getDescription("short", BirdPeeDAO.PRODUCT_getProductByID(i.getProductID()).getDescription())%>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="cart-item-middle">
                                        <%= String.format("%,.0f", BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(i.getProductID()))%> VND
                                    </div>
                                    <div class="cart-item-right">
                                        <p>Qty: <%= i.getQuantity()%></p>
                                    </div>
                                </div>
                                <%
                                        total += BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(i.getProductID()) * i.getQuantity();
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
                <form action="BirdPee" method="post">
                    <div class="checkout-container-right col-md-4 order-md-2 ">
                        <div class="payment-card-header-wrapper" >
                            <span class="payment-card-header-title" style="font-size: 25px; ">Select Payment Method</span>
                        </div>

                        <div class="payment-card-container" >
                            <div class="card-list-wrapper">
                                <input type="radio" id="cod" name="paymentmethod" value="cod" required>
                                <label for="cod">
                                    <div class="card-container">
                                        <div>
                                            <div class="card-main-content">
                                                <div class="card-main-content-left">
                                                    <img class="card-icon"
                                                         src="https://lzd-img-global.slatic.net/g/tps/tfs/TB1ZP8kM1T2gK0jSZFvXXXnFXXa-96-96.png_2200x2200q80.png_.webp">
                                                    <div class="card-main-content-text-container">
                                                        <p class="card-title">Cash On Delivery</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card-footer">
                                                <div class="card-footer-left" style="text-align: left;">
                                                    <p class="card-desc"
                                                       style="font-size: 13px; color: grey;  margin-left: 10px;">
                                                        Pay when you receive
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </label>
                            </div>
                        </div>
                        <div class="payment-card-container">
                            <div class="card-list-wrapper">
                                <input type="radio" id="vnpay" name="paymentmethod" value="vnpay" required>
                                <label for="vnpay">
                                    <div class="card-container">
                                        <div>
                                            <div class="card-main-content">
                                                <div class="card-main-content-left">
                                                    <img class="card-icon"
                                                         src="https://cdn.haitrieu.com/wp-content/uploads/2022/10/Icon-VNPAY-QR.png">
                                                    <div class="card-main-content-text-container">
                                                        <p class="card-title">VNPAY Wallet</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card-footer">
                                                <div class="card-footer-left" style="text-align: left;">
                                                    <p class="card-desc"
                                                       style="font-size: 13px; color: grey; margin-left: 10px;">
                                                        Scan QR code
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </label>
                            </div>
                        </div>
                        <div class="summary-section">
                            <div class="summary-section-heading"
                                 style="font-size: 25px; text-align: left; margin-top: 3%; margin-bottom: 2%;">
                                Order Summary
                            </div>
                            <div class="summary-section-content">
                                <div class="checkout-summary">
                                    <div class="checkout-summary-row">
                                        <div class="checkout-summary-main">
                                            <div class="checkout-summary-lable">
                                                <p>Subtotal
                                                <p>(<%= BirdPeeDAO.CART_countNumberOfItemInCart(ac.getId())%> items)</p>
                                                </p>
                                            </div>
                                            <div class="checkout-summary-value">
                                                <%= String.format("%,.0f", total)%> VND
                                            </div>
                                        </div>
                                        <div class="checkout-summary-main">
                                            <div class="checkout-summary-lable">
                                                <p>Shipping</p>
                                            </div>
                                            <div class="checkout-summary-value">
                                                <%
                                                    float sp = 0;
                                                    if (request.getAttribute("shipprice") != null) {
                                                        sp = (float) request.getAttribute("shipprice");
                                                    }
                                                %>
                                                <%= String.format("%,.0f", (request.getAttribute("shipprice") != null) ? sp : defaultShipPrice)%> VND
                                            </div>
                                        </div>
                                    </div>
                                    <div class="checkout-summary-main2">
                                        <div class="checkout-summary-lable">
                                            <p>Total</p>
                                        </div>
                                        <div class="checkout-summary-value">
                                            <%= String.format("%,.0f", total + ((request.getAttribute("shipprice") != null) ? sp : defaultShipPrice))%> VND
                                            <% session.setAttribute("total", (long)(total + ((request.getAttribute("shipprice") != null) ? sp : defaultShipPrice))); %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                if (address.split("@")[3].isEmpty() || address.split("@")[4].isEmpty() || address.split("@")[2].isEmpty()) {
                            %>
                            <div>
                                <div class="checkout-button" style="font-size: 20px; ">
                                    <button id="CheckOut" onclick="event.preventDefault();" name="action" value="Success">PROCEED PAYMENT</button>
                                </div>
                            </div>
                            <%
                            } else {
                            %>
                            <div>
                                <div class="checkout-button" style="font-size: 20px; ">
                                    <button name="action" value="Success">PROCEED PAYMENT</button>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </form>
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
            }
        %>
        <script src="js/CheckOut.js"></script>
    </body>
</html>
