<%-- 
    Document   : SO_FeedbackManagement
    Created on : Jul 24, 2023, 12:36:04 AM
    Author     : Admin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Feedback"%>
<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/SO_FeedbackManagement.css" />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
            integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link
            href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css"
            rel="stylesheet"
            />

        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
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
                <span class="logo-name">FEEDBACK MANAGEMENT</span>
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
                            <a href="SO_ShopProfileManagement.jsp?provinceid=<%= BirdPeeDAO.SHIP_getProvinceIDByShopID(s.getId()).trim()%>&districtid=<%= BirdPeeDAO.SHIP_getDistrictIDByShopID(s.getId()).trim()%>" class="nav-link">
                                <i class="bx bxs-store-alt icon"></i>
                                <span class="link">SHOP PROFILE</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="#" class="nav-link active">
                                <i class="bx bxs-comment icon"></i>
                                <span class="link">FEEDBACK MANAGEMENT</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="SO_OrderManagement.jsp" class="nav-link">
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
                <div class="title">
                    <h1>Shop's Feedback</h1>
                    <div class="rate">
                        <span class="score"><%= BirdPeeDAO.SHOPOWNER_getRating(s.getId())%></span>
                        <span class="total">/ 5</span>
                    </div>
                </div>

                <div class="content">
                    <div class="sort-reply">
                        <div><a href="SO_FeedbackManagement.jsp" class="<%= request.getParameter("sort") == null ? "active" : "" %>">All</a></div>
                        <div><a href="SO_FeedbackManagement.jsp?sort=replied" class="<%= request.getParameter("sort") != null && request.getParameter("sort").equalsIgnoreCase("replied") ? "active" : "" %>">Replied</a></div>
                        <div><a href="SO_FeedbackManagement.jsp?sort=notreply" class="<%= request.getParameter("sort") != null && request.getParameter("sort").equalsIgnoreCase("noreplied") ? "active" : "" %>">Not Reply</a></div>
                    </div>

                    <div class="sort-rating">
                        <div class="<%= request.getParameter("sort") == null ? "active" : "" %>"><a href="SO_FeedbackManagement.jsp">All</a></div>
                        <div class="<%= request.getParameter("sort") != null && request.getParameter("sort").equalsIgnoreCase("5") ? "active" : "" %>"><a href="SO_FeedbackManagement.jsp?sort=5">5 stars</a></div>
                        <div class="<%= request.getParameter("sort") != null && request.getParameter("sort").equalsIgnoreCase("4") ? "active" : "" %>"><a href="SO_FeedbackManagement.jsp?sort=4">4 Stars</a></div>
                        <div class="<%= request.getParameter("sort") != null && request.getParameter("sort").equalsIgnoreCase("3") ? "active" : "" %>"><a href="SO_FeedbackManagement.jsp?sort=3">3 Stars</a></div>
                        <div class="<%= request.getParameter("sort") != null && request.getParameter("sort").equalsIgnoreCase("2") ? "active" : "" %>"><a href="SO_FeedbackManagement.jsp?sort=2">2 Stars</a></div>
                        <div class="<%= request.getParameter("sort") != null && request.getParameter("sort").equalsIgnoreCase("1") ? "active" : "" %>"><a href="SO_FeedbackManagement.jsp?sort=1">1 Stars</a></div>
                    </div>

                    <div class="feedback-place">
                        <div class="table-section">
                            <table>
                                <thead>
                                    <tr>
                                        <td>Product ID</td>
                                        <td>Customer's email</td>
                                        <td>Create date</td>
                                        <td>Feedback</td>
                                        <td>Rating</td>
                                        <td>Shop's Reply</td>
                                        <td>Status</td>
                                        <td>Action</td>
                                    </tr>
                                </thead>
                                <tbody class="tbody">
                                    <%
                                        ArrayList<Feedback> listF = BirdPeeDAO.SHOPOWNER_getAllFeedbackByOwnerIDAndSort(ac.getId(), request.getParameter("sort"));
                                        for (Feedback feedback : listF) {
                                    %>
                                <form action="BirdPee" method="post">
                                    <tr class="tr">
                                        <td><a href="SO_ProductManagement.jsp?id=<%= feedback.getProductID() %>" style="text-decoration: underline"><%= feedback.getProductID()%></a></td>
                                        <td><%= BirdPeeDAO.ACCOUNT_getCustomerByID(feedback.getCustomerID()).getEmail()%></td>
                                        <td><%= BirdPeeDAO.DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(feedback.getCreateDate(), 0) %></td>
                                        <td>
                                            <textarea name="" id="" cols="30" rows="10" readonly><%= feedback.getComment()%></textarea>
                                        </td>
                                        <td><%= feedback.getRating()%></td>
                                        <td>
                                            <textarea name="reply" id="" cols="30" rows="10" <%= feedback.getStatus() == 0 ? "" : "readonly"%>><%= feedback.getStatus() == 0 ? "" : feedback.getReply()%></textarea>
                                        </td>
                                        <td><div class="<%= feedback.getStatus() == 0 ? "not-approve" : "approve"%>"><%= feedback.getStatus() == 0 ? "Not Reply" : "Replied"%></div></td>
                                        <td>    
                                            <%
                                                if (feedback.getStatus() == 0) {
                                            %>
                                            <input type="hidden" name="fid" value="<%= feedback.getId() %>"/>
                                            <button name="action" value="SOReplyFeedback">Send</button>
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
            </div>
            <div class="shadow"></div>
        </main>
        <%
            }
        %>
        <script src="js/SO_FeedbackManagement.js"></script>
    </body>
</html>
