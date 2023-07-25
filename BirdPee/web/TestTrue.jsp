<%-- 
    Document   : TestTrue
    Created on : May 31, 2023, 2:21:40 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BirdPee Test Room</title>
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("user");
        %>
        <h1>Test Success</h1>
        <h1>Welcome <%= (ac.getRole().equalsIgnoreCase("SO") ? "Shop owner" : "Admin") %> <%= ac.getUsername() %></h1>
    </body>
</html>
