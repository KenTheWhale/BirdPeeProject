<%-- 
    Document   : ChangePassword
    Created on : May 31, 2023, 3:54:34 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/Login.css">
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
        <title>BirdPee</title>
    </head>
    <body>
        <%
            if (session.getAttribute("mail") == null) {
                response.sendRedirect("Login.jsp");
            } else {
        %>
        <div class="limiter">
            <div class="container-login">
                <div class="wrap-login">
                    <div class="login-image" data-tilt >
                        <img src="images/img-01.png " alt="..">
                    </div>
                    <form class="login-form" action="BirdPee" method="post">
                        <span class="login-title" style="font-size: 30px;">
                            Change 
                            <br/>
                            account's password
                        </span>
                        <div class="login-form-input">
                            <input class="input" type="password" name="pass" placeholder="Password"required>
                            <span class="symbol-input">
                                <i class="fa fa-lock"></i>
                            </span>
                        </div>
                        <div class="login-form-input">
                            <input class="input" type="password" name="cpass" placeholder="Confirm password"required>
                            <span class="symbol-input">
                                <i class="fa fa-lock"></i>
                            </span>
                        </div>
                        <div class="container-login-form-button">
                            <button class="login-form-button" name="action" value="ResetPass">
                                Confirm 
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            }
        %>

        <script src="js/Login.js"></script>
    </body>
</html>
