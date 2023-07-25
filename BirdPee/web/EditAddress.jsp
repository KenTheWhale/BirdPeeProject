<%-- 
    Document   : EditAddress
    Created on : Jul 6, 2023, 5:20:20 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BirdPee</title>
        <link rel="stylesheet" href="css/AddAdress.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
              integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
    </head>
    <body>
        <%
            Customer ac = (Customer) session.getAttribute("user");
            if (session.getAttribute("user") == null) {
                response.sendRedirect("Login.jsp");
            } else {
                String editedAddress = "";
                if(request.getParameter("id") != null){
                    editedAddress = BirdPeeDAO.ACCOUNT_getAddressByIDReturnDisProName(Integer.parseInt(request.getParameter("id")));
                    session.setAttribute("addressid", Integer.parseInt(request.getParameter("id")));
                }else{
                    editedAddress = BirdPeeDAO.ACCOUNT_getAddressByIDReturnDisProName((int) session.getAttribute("addressid"));
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
                    <div class="add-address-title">
                        <form action="BirdPee" method="post">
                        <div> Edit Receive Address</div>
                        <input type="hidden" name="addressid" value="<%= request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : (int) session.getAttribute("addressid") %>"/>
                        <div><button class="hidden-button" name="action" value="DeleteAddress">Delete</button></div>
                        </form>
                    </div>
                    <div class="main-right-container-inner">
                        <form class="add-address-container" action="BirdPee" method="post">
                            <%
                                Cookie cookie[] = request.getCookies();
                                String name = "";
                                String phone = "";
                                String address = "";
                                if (cookie != null) {
                                    for (Cookie c : cookie) {
                                        if (c.getName().equalsIgnoreCase("name")) {
                                            name = java.net.URLDecoder.decode(c.getValue(), "UTF-8");
                                            break;
                                        } else {
                                            name = "";
                                        }
                                    }

                                    for (Cookie c : cookie) {
                                        if (c.getName().equalsIgnoreCase("phone")) {
                                            phone = java.net.URLDecoder.decode(c.getValue(), "UTF-8");
                                            break;
                                        } else {
                                            phone = "";
                                        }
                                    }

                                    for (Cookie c : cookie) {
                                        if (c.getName().equalsIgnoreCase("address")) {
                                            address = java.net.URLDecoder.decode(c.getValue(), "UTF-8");
                                            break;
                                        } else {
                                            address = "";
                                        }
                                    }
                                }
                            %>
                            <div class="add-address-left">
                                <div class="input">
                                    <div>Full Name</div>
                                    <input type="text" name="name" placeholder="Please enter your receiver's name" id="name" oninput="keepData()" value="<%= (name.equalsIgnoreCase("") ? editedAddress.split("@")[4] : name)%>">
                                </div>
                                <div class="input">
                                    <div>Phone Number</div>
                                    <input type="text" name="phone" placeholder="Please enter your receiver's phone number" id="phone" oninput="keepData()" value="<%= (phone.equalsIgnoreCase("") ? editedAddress.split("@")[3] : phone)%>">
                                </div>
                            </div>
                            <div class="add-address-right">
                                <div class="input">
                                    <div>Address</div>
                                    <input type="text" name="address" placeholder="Please enter your address" id="address" oninput="keepData()" value="<%= (address.equalsIgnoreCase("") ? editedAddress.split("@")[2] : address)%>">
                                </div>
                                <div class="input-district" >
                                    <div class="input-title">
                                        <p><%= request.getParameter("provinceid") != null ? BirdPeeDAO.SHIP_getProvinceNameByID(request.getParameter("provinceid")) : editedAddress.split("@")[6]%></p>
                                        <i class="fa-solid fa-angle-down" style="font-size: 12px; "></i>
                                    </div>
                                    <ul class="options">
                                        <%
                                            ArrayList<String> listProvince = BirdPeeDAO.SHIP_getAllProvince();
                                            for (String p : listProvince) {
                                        %>
                                        <li>
                                            <a href="EditAddress.jsp?provinceid=<%= p.split("@")[1]%>"> <%= p.split("@")[0]%> </a>
                                        </li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                </div>
                                <div class="input-district">
                                    <div class="input-title">
                                        <p><%= request.getParameter("districtid") != null ? BirdPeeDAO.SHIP_getDistrictNameByID(request.getParameter("districtid")) : (request.getParameter("id") != null ? editedAddress.split("@")[5] : "District") %></p>
                                        <i class="fa-solid fa-angle-down" style="font-size: 12px; "></i>
                                    </div>
                                    <ul class="options">
                                        <%
                                            if (request.getParameter("provinceid") != null) {
                                                ArrayList<String> listDistrict = BirdPeeDAO.SHIP_getDistrictByProvinceID(request.getParameter("provinceid"));
                                                for (String district : listDistrict) {
                                                    String districtName = district.split("@")[0];
                                                    int districtID = Integer.parseInt(district.split("@")[1]);
                                        %>
                                        <li><a href="EditAddress.jsp?provinceid=<%= request.getParameter("provinceid") != null ? request.getParameter("provinceid") : BirdPeeDAO.ACCOUNT_getAddressByIDReturnDisProID(Integer.parseInt(request.getParameter("id"))).split("@")[6] %>&districtid=<%= districtID%>"><%= districtName%></a></li>
                                            <%
                                                }
                                            } else {
                                                ArrayList<String> listDistrict = BirdPeeDAO.SHIP_getDistrictByProvinceID(BirdPeeDAO.ACCOUNT_getAddressByIDReturnDisProID(Integer.parseInt(request.getParameter("id"))).split("@")[6]);
                                                for (String district : listDistrict) {
                                                    String districtName = district.split("@")[0];
                                                    int districtID = Integer.parseInt(district.split("@")[1]);
                                            %>
                                        <li><a href="EditAddress.jsp?provinceid=<%= request.getParameter("provinceid") != null ? request.getParameter("provinceid") : BirdPeeDAO.ACCOUNT_getAddressByIDReturnDisProID(Integer.parseInt(request.getParameter("id"))).split("@")[6] %>&districtid=<%= districtID%>"><%= districtName%></a></li>
                                            <%
                                                    }
                                                }
                                            %>
                                    </ul>
                                </div>
                                <span class="input-button">
                                    <input type="hidden" name="districtid" value="<%= request.getParameter("districtid") != null ? request.getParameter("districtid") : (request.getParameter("id") != null ? BirdPeeDAO.ACCOUNT_getAddressByIDReturnDisProID(Integer.parseInt(request.getParameter("id"))).split("@")[5] : "") %>"/>
                                    <button style="padding: 8px 50px 8px 50px;" name="action" value="EditAddress">SAVE</button>
                                    <button style="padding: 8px 38px 8px 38px;" name="action" value="ReturnAddress">CANCEL</button>
                                </span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
        <script>
            function keepData() {
                let name = document.getElementById("name");
                let phone = document.getElementById("phone");
                let address = document.getElementById("address");

                let nameValue = name.value;
                let phoneValue = phone.value;
                let addressValue = address.value;

                document.cookie = "name=" + encodeURIComponent(nameValue);
                document.cookie = "phone=" + encodeURIComponent(phoneValue);
                document.cookie = "address=" + encodeURIComponent(addressValue);
            }
        </script>
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
