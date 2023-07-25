<%-- 
    Document   : SO_OrderManagement
    Created on : Jul 9, 2023, 4:41:30 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="com.team1.BirdPee.DTO.OrderDetails"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Product"%>
<%@page import="com.team1.BirdPee.DTO.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/SO_OrderManagement.css" />
        <link
            href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
            integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />

        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <title>BirdPee - Shop Owner</title>
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("user");
            if (session.getAttribute("user") == null) {
                response.sendRedirect("Login.jsp");
            } else {
                Shop s = BirdPeeDAO.SHOPOWNER_findShopByOwnerId(ac.getId());
        %>
        <nav>
            <div class="logo">
                <i class="bx bx-menu menu-icon"></i>
                <span class="logo-name">ORDER MANAGEMENT</span>
            </div>

            <div class="user-info">
                <img src="https://cdn-icons-png.flaticon.com/512/552/552721.png" alt="" />
                <h3><%= ac.getUsername()%></h3>
            </div>

            <div class="sidebar">
                <div class="logo">
                    <i class="bx bx-menu menu-icon overlay"></i>
                    <span class="logo-name">BIRDPEE</span>
                </div>

                <div class="sidebar-content">
                    <ul class="lists">
                        <li class="list">
                            <a href="SO_Dashboard.jsp" class="nav-link">
                                <i class="bx bxs-spreadsheet icon"></i>
                                <span class="link">DASHBOARD</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="SO_ProductManagement.jsp" class="nav-link">
                                <i class="icon bx bxs-package"></i>
                                <span class="link">PRODUCT MANAGEMENT</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="SO_CustomerManagement.jsp" class="nav-link">
                                <i class="icon bx bxs-package"></i>
                                <span class="link">CUSTOMER MANAGEMENT</span>
                            </a>
                        </li>
                        <li class="list">
                             <a href="SO_ShopProfileManagement.jsp?provinceid=<%= BirdPeeDAO.SHIP_getProvinceIDByShopID(s.getId()).trim() %>&districtid=<%= BirdPeeDAO.SHIP_getDistrictIDByShopID(s.getId()).trim() %>" class="nav-link">
                                <i class="bx bxs-store-alt icon"></i>
                                <span class="link">SHOP PROFILE</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="SO_FeedbackManagement.jsp" class="nav-link">
                                <i class="bx bxs-comment icon"></i>
                                <span class="link">FEEDBACK MANAGEMENT</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="SO_OrderManagement.jsp" class="nav-link active">
                                <i class="bx bx-notepad icon"></i>
                                <span class="link">ORDER MANAGEMENT</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="Login.jsp" class="nav-link">
                                <i class="bx bx-log-out icon"></i>
                                <span class="link">LOGOUT</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <main>
            <div class="main-container">
                <div class="sort">
                    <div><a href="SO_OrderManagement.jsp">All Orders</a></div>
                    <div><a href="SO_OrderManagement.jsp?sort=Successful">Successful</a></div>
                    <div><a href="SO_OrderManagement.jsp?sort=Processing">In Progress</a></div>
                    <div><a href="SO_OrderManagement.jsp?sort=Packed">Packed</a></div>
                    <div><a href="SO_OrderManagement.jsp?sort=InDelivery">In Delivery</a></div>
                    <div><a href="SO_OrderManagement.jsp?sort=Cancel">Canceled</a></div>
                </div>
                <form action="BirdPee" method="post">
                    <div class="search">
                        <input type="text" placeholder="Enter order ID for searching..." name="keyword" required />
                        <button name="action" value="SOOderSearch">Find</button>
                    </div>
                </form>


                <div class="order-status">
                    <h1>Order Status</h1>
                    <div class="table-section">
                        <table>
                            <thead>
                                <tr>
                                    <td>Order ID</td>
                                    <td>Customer Name</td>
                                    <td>Total Price</td>
                                    <td>Order Date</td>
                                    <td>Payment Method</td>
                                    <td>Status</td>
                                    <td>Action</td>
                                </tr>
                            </thead>
                            <tbody class="tbody">
                                <%
                                    String sort = "";
                                    if (request.getParameter("sort") != null) {
                                        sort = request.getParameter("sort");
                                    }
                                    ArrayList<Order> listO = BirdPeeDAO.SHOPOWNER_getAllOrderItemBySort(sort);
                                    for (Order o : listO) {
                                %>
                            <form action="BirdPee" method="post">
                                <tr class="tr">
                                    <td>
                                        <%= o.getId()%>
                                        <span class="icon"><a href="SO_OrderManagement.jsp?id=<%= o.getId()%>"><i class="fa-solid fa-eye"></i></a></span>
                                    </td>
                                    <td><%= BirdPeeDAO.ACCOUNT_getCustomerNameByCustomerID(o.getCustomerID())%></td>
                                    <td><%= String.format("%,d", BirdPeeDAO.ORDER_getSubTotal(o.getId()))%> VND</td>
                                    <td><%= BirdPeeDAO.DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(o.getCreateDate(), 0)%></td>
                                    <td><%= BirdPeeDAO.ORDER_getPaymentMethod(o.getPaymentMethodID())%></td>
                                    <td>
                                        <p class="<%= o.getStatus() == 1 ? "cancel" : (o.getStatus() == 5 ? "success" : "in-progress")%>"><%= BirdPeeDAO.ORDER_getOrderStatus(o.getId())%></p>
                                    </td>
                                    <td>
                                        <%
                                            if (o.getStatus() != 1 && o.getStatus() != 5) {
                                        %>
                                        <div class="button-place">
                                            <input type="hidden" name="status" value="<%= o.getStatus()%>"/>
                                            <input type="hidden" name="id" value="<%= o.getId()%>"/>
                                            <button class="approve-btn" name="action" value="SOOrderApprove"><%= o.getStatus() == 2 ? "Approve" : (o.getStatus() == 3 ? "Delivery" : "Success")%></button>
                                            <button class="cancel-btn" name="action" value="SOOrderCancel">Cancel</button>
                                        </div>
                                        <%
                                            }
                                        %>
                                    </td>
                                </tr>
                            </form>
                            <%
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <%
                if (request.getParameter("id") != null) {
                    int oid = Integer.parseInt(request.getParameter("id"));
                    Order o = BirdPeeDAO.ORDER_getOrderByID(oid);
                    ArrayList<OrderDetails> listOD = o.getListOD();

            %>
            <div id="popup" class="show">
                <% //
                    for (OrderDetails item : listOD) {
                %>
                <div class="image-place">
                    <img src="<%= BirdPeeDAO.PRODUCT_getImages(item.getProductID()).get(0)%>" alt="" />
                </div>
                <div class="content">
                    <div>Product ID: <span><%= item.getProductID() %></span></div>
                    <div>Order date: <span><%= BirdPeeDAO.DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(o.getCreateDate(), 0)%></span></div>
                    <div>Ship date: <span><%= BirdPeeDAO.DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(o.getShipDate(), 0)%></span></div>
                    <div>Product Name: <span><%= item.getProductName() %></span></div>
                    <div>Customer Name: <span><%= BirdPeeDAO.ACCOUNT_getCustomerNameByCustomerID(o.getCustomerID())%></span></div>
                    <div>Unit Price: <span><%= String.format("%,d", item.getInitPrice())%> VND</span></div>
                    <div>Total Price: <span><%= String.format("%,d", item.getInitPrice() + item.getShipPrice())%> VND</span></div>
                    <div>Quantity: <span><%= item.getQuantity()%></span></div>
                    <div>Discount: <span><%= BirdPeeDAO.DISCOUNT_getDiscountPercentageByProductID(item.getProductID()) == 0 ? "No discount" : String.format("%,d", BirdPeeDAO.DISCOUNT_getDiscountPercentageByProductID(item.getProductID()) * 100)%><%= BirdPeeDAO.DISCOUNT_getDiscountPercentageByProductID(item.getProductID()) == 0 ? "" : "%"%></span></div>
                    <div>Ship type: <span><%= BirdPeeDAO.SHIP_getShipType(o.getPaymentTypeID())%></span></div>
                    <div>Payment method: <span><%= BirdPeeDAO.ORDER_getPaymentMethod(o.getPaymentMethodID())%></span></div>
                    <div>Status: <span><%= BirdPeeDAO.ORDER_getOrderStatus(o.getId())%></span></div>
                </div>
                <div id="close"><a href="SO_OrderManagement.jsp"> &times;</a></div>
                <%//
                    }
                %>
            </div>
            <%//
                }
            %>
            <div class="shadow"></div>
        </main>
        <%//
            }
        %>
        <script src="js/SO_OrderManagement.js"></script>
    </body>
</html>
