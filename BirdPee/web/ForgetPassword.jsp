<%-- 
    Document   : ForgetPassword
    Created on : May 31, 2023, 5:19:46 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BirdPee</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/Login.css">
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
    </head>
    <body>
        <div class="limiter">
            <div class="container-login">
                <div class="wrap-login">
                    <div class="login-image" data-tilt >
                        <img src="images/img-01.png " alt="..">
                    </div>
                    <form class="login-form" action="BirdPee" method="post">
                        <span class="login-title" style="font-size: 45px;">
                            Forget Password
                        </span>
                        <div class="login-form-input">
                            <input class="input" type="text" name="mail" placeholder="Please enter your email" required>
                            <span class="symbol-input">
                                <i class="fa-solid fa-envelope"></i>
                            </span>
                        </div>
                        <%
                            String errorMsg = (String) request.getAttribute("errorMsg");
                            if (errorMsg != null) {
                        %>
                        <h3 style="color: red; text-align: center; margin-top: 5px; font-size: 18px"><%= errorMsg%></h3>
                        <%
                            }
                        %>
                        <div class="container-login-form-button">
                            <button class="login-form-button" name="action" value="Next">
                                Next
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/Login.js"></script>
    </body>
</html>
