<%-- 
    Document   : Login
    Created on : May 31, 2023, 2:10:24 PM
    Author     : Admin
--%>

<%@page import="com.team1.BirdPee.DTO.Account"%>
<%@page import="com.team1.BirdPee.DTO.Customer"%>
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
        <%
            if (session.getAttribute("user") != null) {
                session.invalidate();
            }
        %>
        <div class="limiter">
            <div class="container-login">
                <div class="wrap-login">
                    <div class="login-image" data-tilt >
                        <img src="images/img-01.png" alt="..">
                    </div>
                    <div class="login-form">
                        <form action="BirdPee" method="post">
                            <span class="login-title" style="font-size: 45px;">
                                Login
                            </span>
                            <div class="login-form-input">
                                <input class="input" type="text" name="email" placeholder="Email">
                                <span class="symbol-input">
                                    <i class="fa-solid fa-envelope"></i>
                                </span>
                            </div>
                            <div class="login-form-input">
                                <input class="input" type="password" name="pass" placeholder="Password">
                                <span class="symbol-input">
                                    <i class="fa fa-lock"></i>
                                </span>
                            </div>
                            <div class="container-login-form-button">
                                <button class="login-form-button" name="action" value="Login">
                                    Login
                                </button>
                            </div>
                            <%
                                String errorMsg = (String) request.getAttribute("errorMsg");
                                if (errorMsg != null) {
                            %>
                            <h3 style="color: red; text-align: center; margin-top: 5px; font-size: 18px"><%= errorMsg%></h3>
                            <%
                                }
                            %>
                            <div class="text">
                                <a class="txt2" href="ForgetPassword.jsp">
                                    Forget Password?
                                </a>
                            </div>
                            <div class="wrap">
                                <h4 class="centre-line"><span>OR</span></h4>
                            </div>
                        </form>
                        <div class="fast-login">
                            <div class="container-login-form-button-fast">
                                <a href="https://accounts.google.com/o/oauth2/auth?scope=profile email&redirect_uri=http://localhost:8080/BirdPee/GoogleLogin&response_type=code
                                   &client_id=996451174356-rv16r23al8pg6rpfk8oaihp0s5oli1gl.apps.googleusercontent.com&approval_prompt=force">
                                    <button class="login-form-button-fast"><i class="fa-brands fa-google" style="color: #ffffff; font-size: 20px;"></i>
                                        &nbsp;&nbsp;  Google
                                    </button>
                                </a>
                            </div>
                        </div>

                        <div class="Create-account-pointer">
                            <a class="create-account" href="Signup.jsp">
                                Create your Account
                                <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
                            </a>
                        </div>
                        <div class="Create-account-pointer">
                            <a class="create-account" href="Homepage.jsp">
                                Return homepage
                                <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="js/Login.js"></script>
    </body>
</html>
