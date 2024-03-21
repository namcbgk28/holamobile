<%-- 
    Document   : login.jsp
    Created on : Sep 11, 2023, 5:33:21 PM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="fonts/fontawesome-free-6.4.0-web/css/all.css">
        <link href='https://fonts.googleapis.com/css?family=Anton' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css2?family=Ephesis&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/base.css">
        <link rel="stylesheet" href="css/form.css"/>
    </head>

    <body>
        <div class="container">

            <!--Header-->
            <div class="header">
                <div id="header-section">
                    <a href="home" id="left-section">
                        <div class="header-logo">
                            <img src="image/logo-hola.png" alt="">
                        </div>
                        <div class="header-name">
                            <h1 class="name-shop">Hola Mobile</h1>
                            <h6 class="slogan">__Kết nối mọi người__</h6>
                        </div>
                    </a>

                    <div id="right-section">
                        <h1>ĐĂNG NHẬP</h1>
                    </div>
                </div>
            </div>
            <!--End-Header-->


            <!--Content-->
            <div style="align-items: center" class="content">
                <div class="banner">
                    <img src="image/poster.png" alt="">
                </div>
                <div style="width: 50%;"  class="form-info">
                    <h1 class="text">Đăng nhập</h1>
                    <form action="sign" method="post">
                        <input type="hidden" name="service" value="login">
                        <div style="position: relative;" class="field">
                            <span>
                                <i class="fa-solid fa-user"></i>
                            </span>
                            <input style="padding: 12px 8px 12px 40px;" class="input" name="user-name" type="text" required placeholder="Email/Số điện thoại/Tên đăng nhập">
                        </div>
                        <div style="position: relative;" class="field">
                            <span><i class="fa-solid fa-lock"></i></span>
                            <input style="padding: 12px 8px 12px 40px;" class="input" name="password" type="password" required placeholder="Mật khẩu">
                        </div>
                        <h3 style="color: red; margin-bottom: 4px;font-size: 16px;">${requestScope.ms}</h3>
                        <a class="forgot" href="">Quên mật khẩu?</a>
                        <input class="submit" type="submit" value="Đăng nhập">
                        <div class="sign">
                            Bạn chưa có tài khoản?
                            <a href="sign?service=signup">Đăng ký ngay</a>
                        </div>
                    </form>
                </div>
            </div>
            <!--End-content-->
        </div>
                        <%@include file="footer.jsp" %>
    </body>
</html>
