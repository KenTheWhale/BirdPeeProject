<%-- 
    Document   : Signup
    Created on : Jun 4, 2023, 2:23:36 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/SignUp.css">
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
        <title>BirdPee</title>
    </head>
    <body>
        <div class="limiter">
            <div class="container-login">
                <div class="wrap-login">
                    <div class="login-image" data-tilt >
                        <img src="images/img-01.png " alt="..">
                    </div>
                    <form class="login-form" action="BirdPee" method="post">
                        <strong class="login-title"style="font-size: 45px;">
                            Register
                        </strong>
                        <div class="login-input">
                            <div class="login-form-input">
                                <input class="input" type="text" name="email" placeholder="Email*"required>
                                <span class="symbol-input">
                                    <i class="fa-solid fa-envelope"></i>
                                </span>
                            </div>
                            <div class="login-form-input">
                                <input class="input" type="text" name="name" placeholder="Username*"required>
                                <span class="symbol-input">
                                    <i class="fa-solid fa-person"></i>
                                </span>
                            </div>
                            <div class="login-form-input">
                                <input class="input" type="password" name="pass" placeholder="Password*"required>
                                <span class="symbol-input">
                                    <i class="fa fa-lock"></i>
                                </span>
                            </div>
                            <div class="login-form-input">
                                <input class="input" type="password" name="cpass" placeholder="Confirmed Password*"required>
                                <span class="symbol-input">
                                    <i class="fa fa-lock"></i>
                                </span>
                            </div>
                            <div class="login-form-input">
                                <input class="input" type="tel" name="phone" placeholder="Phone number*" required>
                                <span class="symbol-input">
                                    <i class="fa-solid fa-phone"></i>
                                </span>
                            </div>
                            <div class="login-form-input">
                                <input class="input" type="text" name="address" placeholder="Address*" required>
                                <span class="symbol-input">
                                    <i class="fa-solid fa-location-dot"></i>
                                </span>
                            </div>
                        </div>
                        <%
                            String errorMsg = (String) request.getAttribute("errorMsg");
                            if (errorMsg != null) {
                        %>
                        <h3 style="color: red; text-align: center; margin-top: 15px; font-size: 20px"><%= errorMsg%></h3>
                        <%
                            }
                        %>
                        <div class="container-login-form-button">
                            <button class="login-form-button" name="action" value="Register">
                                Register
                            </button>
                        </div>

                        <div class="Create-account-pointer">
                            <a class="create-account" href="Login.jsp">
                                You already have an account ?
                                <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/Login.js"></script>
    </body>
</html>
