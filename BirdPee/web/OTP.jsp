<%-- 
    Document   : OTP
    Created on : May 31, 2023, 5:03:13 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/OTP.css">
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="icon" type="image/x-icon" href="images/logo2.png" />
        <title>BirdPee</title>
    </head>
    <body>
        <%
            if ((String) session.getAttribute("mail") == null) {
                request.getRequestDispatcher("ForgetPassword.jsp").forward(request, response);
            } else {
        %>
        <form action="BirdPee" method="post">
            <div class="limiter">
                <div class="container-login">
                    <div class="wrap-login" style="text-align: center">
                        <i class="fa fa-lock" style="font-size: 60px; margin-bottom: 10%;"></i>
                        <h1>Enter OTP</h1>
                        <p style="color: brown; margin-bottom: 5%; margin-top: 3%">OTP is sent to your email<br>If don't see then please check in spam mail</p>
                        <div class="login-form-input">
                            <input class="input" type="text" name="inputtedOTP" placeholder="Enter OTP" required>
                            <span class="symbol-input">
                                <i class="fa fa-envelope"></i>
                            </span>
                        </div>
                        <%
                            String errorMsg = (String) request.getAttribute("errorMsg");
                            if (errorMsg != null) {
                        %>
                        <h3 style="color: red"><%= errorMsg%></h3>
                        <%
                            }
                        %>
                        <div class="container-login-form-button">
                            <button class="login-form-button" name="action" value="CheckOTP">
                                Reset Password
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <%
            }
        %>
    </body>
</html>
