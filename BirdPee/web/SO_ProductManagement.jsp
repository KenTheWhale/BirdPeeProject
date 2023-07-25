<%-- 
    Document   : SO_ProductManagement
    Created on : Jul 9, 2023, 8:52:35 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DAO.BirdPeeDAO"%>
<%@page import="com.team1.BirdPee.DTO.Category"%>
<%@page import="com.team1.BirdPee.DTO.Product"%>
<%@page import="com.team1.BirdPee.DTO.Shop"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.team1.BirdPee.DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

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

        <link rel="stylesheet" href="css/SO_ProductManagement.css" />
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
                <span class="logo-name">PRODUCT MANAGEMENT</span>
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
                            <a href="SO_ProductManagement.jsp" class="nav-link active">
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
                            <a href="SO_FeedbackManagement.jsp" class="nav-link">
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
            <h1>PRODUCT MANAGEMENT</h1>
            <div class="product-place">
                <div class="table-section">
                    <table>
                        <thead>
                            <tr>
                                <td>Product ID</td>
                                <td>Product Name</td>
                                <td>Category ID</td>
                                <td>Status</td>
                                <td>Details</td>
                            </tr>
                        </thead>
                        <tbody class="tbody">
                            <%//
                                ArrayList<Integer> listProductID = BirdPeeDAO.SHOP_getAllProductIDInShop(s.getId());
                                for (Integer id : listProductID) {
                                    Product p = BirdPeeDAO.SHOPOWNER_getProductByID(id);
                            %>
                            <tr class="tr">
                                <td><%= p.getId()%></td>
                                <td>
                                    <div class="text-place">
                                        <p style="width: 80%">
                                            <%= p.getName()%>
                                        </p>
                                    </div>
                                </td>
                                <td><%= p.getCateid()%>: <%= BirdPeeDAO.CATEGORY_getNameByID(p.getCateid())%></td>
                                <td class="not-approve"><%= BirdPeeDAO.SHOPOWNER_getProductStatusByID(p.getId())%></td>
                                <td><a href="SO_ProductManagement.jsp?id=<%= p.getId()%>"><i class="icon fa-solid fa-eye"></i></a></td>
                            </tr>
                            <%
                                }
                            %>

                        </tbody>
                    </table>
                </div>
            </div>
            <%//
                if (request.getParameter("id") != null) {
                    Product p = BirdPeeDAO.SHOPOWNER_getProductByID(Integer.parseInt(request.getParameter("id")));
                    ArrayList<Category> listC = BirdPeeDAO.CATEGORY_getAllCate();
            %>
            <form action="BirdPee" method="post">
                <div id="popup-product" class="show">
                    <div class="image-place">
                        <img src="<%= (BirdPeeDAO.PRODUCT_getImages(p.getId()).size() > 0) ? BirdPeeDAO.PRODUCT_getImages(p.getId()).get(0) : "images/upload.png"%>" alt="" />
                    </div>
                    <div class="content">
                        <div>Product ID: <%= p.getId()%></div>
                        <input type="hidden" name="id" value="<%= p.getId()%>"/>
                        <div>
                            Product Name: <input type="text" name="name" value="<%= p.getName()%>" required />
                        </div>
                        <div>Unit Price (VND): <input type="text" name="price" value="<%= String.format("%.0f", p.getPrice())%>" required /></div>
                        <div>
                            Category ID: 
                            <select name="category">
                                <%//
                                    for (Category c : listC) {
                                %>
                                <option value="<%= c.getId()%>" <%= c.getId() == p.getCateid() ? "selected" : ""%>><%= c.getName()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div>Quantity: <input type="number" name="qty" value="<%= p.getQuantity()%>" required /></div>
                        <div>
                            Discount: 
                            <select name="discount">
                                <option value="0" <%= p.getIsDiscount() == 0 ? "selected" : ""%>>No discount</option>
                                <%
                                    for (int i = 10; i <= 100;) {
                                %>
                                <option value="<%= i%>" <%= (p.getIsDiscount() == 1 && i == BirdPeeDAO.DISCOUNT_getDiscountPercentageByProductID(p.getId()) * 100) ? "selected" : ""%>><%= i%>%</option>
                                <%
                                        i += 10;
                                    }
                                %>
                            </select>
                        </div>
                        <div>
                            Short description:
                            <br><textarea name="shortdes" id="" cols="30" rows="10" style="color: black"><%= BirdPeeDAO.PRODUCT_getDescription("short", p.getDescription())%></textarea>
                        </div>
                        <div>
                            Description:
                            <br><textarea name="fulldes" id="" cols="30" rows="10" style="color: black"><%= BirdPeeDAO.PRODUCT_getDescription("full", p.getDescription())%></textarea>
                        </div>
                        <div>
                            Status: 
                            <select name="status">
                                <option value="Available" <%= BirdPeeDAO.SHOPOWNER_getProductStatusByID(p.getId()).equalsIgnoreCase("Available") ? "selected" : ""%>>Available</option>
                                <option value="Unavailable" <%= BirdPeeDAO.SHOPOWNER_getProductStatusByID(p.getId()).equalsIgnoreCase("Unavailable") ? "selected" : ""%>>Unavailable</option>
                            </select>
                        </div>
                        <button name="action" value="SOUpdateProduct">Update</button>
                    </div>
                    <div id="close"><a href="SO_ProductManagement.jsp"> &times;</a></div>
                </div>
            </form>
            <%//
                }
            %>
            <h1>CREATE PRODUCT</h1>
            <form action="BirdPee" method="post">
                <div class="main__product-info">
                    <div class="left-column">
                        <div class="main__picture-profile">
                            <div class="title">
                                <p>Product Image</p>
                            </div>
                            <div class="image-place">
                                <label for="img1">
                                    <div class="imgContainer">
                                        <img id="image1" src="images/upload.png" alt=""/>
                                        <i class="" id="icon1"></i>
                                    </div>
                                </label>
                                <input type="file" name="img1" id="img1" style="display: none" accept="image/*"/>

                                <label for="img2">
                                    <div class="imgContainer">
                                        <img id="image2" src="images/upload.png" alt=""/>
                                        <i class="" id="icon2"></i>
                                    </div>
                                </label>
                                <input type="file" name="img2" id="img2" style="display: none" accept="image/*"/>

                                <label for="img3">
                                    <div class="imgContainer">
                                        <img id="image3" src="images/upload.png" alt=""/>
                                        <i class="" id="icon3"></i>
                                    </div>
                                </label>
                                <input type="file" name="img3" id="img3" style="display: none" accept="image/*"/>

                                <label for="img4">
                                    <div class="imgContainer">
                                        <img  id="image4" src="images/upload.png" alt=""/>
                                        <i class="" id="icon4"></i>
                                    </div>
                                </label>
                                <input type="file" name="img4" id="img4" style="display: none" accept="image/*"/>
                            </div>
                        </div>
                    </div>
                    <div class="main__product-profile">
                        <div class="title">
                            <p>Product Information</p>
                        </div>
                        <div class="input-place">
                            <div class="input-row">
                                <input type="text" name="name" required />
                                <label>Product Name</label>
                            </div>
                            <div class="input-row">
                                <input type="number" name="price" min="0" value="0" required />
                                <label>Unit Price</label>
                            </div>
                            <div class="input-row">
                                <select name="category" id="discount">
                                    <%
                                        ArrayList<Category> listC = BirdPeeDAO.CATEGORY_getAllCate();
                                        for (Category c : listC) {
                                    %>
                                    <option value="<%= c.getId()%>"><%= c.getName()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="input-row">
                                <input type="number" name="qty" min="0" value="0" required />
                                <label>Quantity</label>
                            </div>
                            <div class="input-row">
                                <select name="discount" id="discount">
                                    <option value="0" >No Discount</option>
                                    <%
                                        for (int i = 10; i <= 100;) {
                                    %>
                                    <option value="<%= i%>"><%= i%>%</option>
                                    <%
                                            i += 10;
                                        }
                                    %>
                                </select>
                            </div>

                                <div class="input-row">
                                    <textarea name="shortdesc" id="" cols="10"
                                              rows="2"
                                              style="width: 100%; padding: 10px"
                                              placeholder="Product Short Desciption"
                                              ></textarea>
                                </div>

                                <div class="input-row">
                                    <textarea
                                        name="fulldesc"
                                        id=""
                                        cols="40"
                                        rows="8"
                                        style="width: 100%; padding: 10px"
                                        placeholder="Product Desciption"
                                        ></textarea>
                                </div>
                            </div>


                            <div class="button-place">
                                <input type="hidden" name="shopid" value="<%= s.getId()%>"/>
                                <button name="action" value="SOCreateProduct">Create</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <div class="shadow"></div>
        </main>
        <%//
            }
        %>
        <script src="js/SO_ProductManagement.js"></script>
    </body>
</html>
