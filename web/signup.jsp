<%-- 
    Document   : signup
    Created on : Sep 11, 2023, 8:31:20 PM
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
                        <h1>ĐĂNG KÝ</h1>
                    </div>
                </div>
            </div>
            <!--End-header-->

            <div class="content">
                <div class="banner">
                    <img src="image/poster1.png" alt="">
                </div>
                <div style="width: 60%;margin-top: 10px;" class="form-info">
                    <h1 class="text">Tạo tài khoản</h1>
                    <form action="sign" method="post">
                        <input type="hidden" name="service" value="signup">
                        <div class="field">
                            <label class="label">
                                Họ và tên:
                            </label>
                            <input name="full-name" class="input" type="text" required>
                        </div>
                        <div style="width: 100%; margin-bottom: 18px; font-size: 18px;">
                            <div style="width: 70%; display: flex; align-items: center;">
                                <p style="width: 43%">Giới tính : </p> Nam <input name="gender" value="true" checked
                                                                                  style="margin-right: 24px; margin-left: 8px;" type="radio"> Nữ <input style="margin-left: 8px;" name="gender" value="false"
                                                                                  type="radio">
                            </div>
                        </div>
                        <div class="field">
                            <label class="label">
                                Gmail:
                            </label>
                            <input name="gmail" class="input" type="text" required>
                        </div>
                        <div class="field">
                            <label class="label">
                                Số điện thoại:
                            </label>
                            <input name="phone" class="input" type="text" required>
                        </div>
                        <div class="field">
                            <label class="label">
                                Địa chỉ:
                            </label>
                            <input name="address" class="input" type="text" required>
                        </div>
                        <div class="field">
                            <label class="label">
                                Tên đăng nhập:
                            </label>
                            <input name="username" class="input" type="text" required placeholder="">
                        </div>
                        <div class="field">
                            <label class="label">
                                Mật khẩu:
                            </label>
                            <input name="pass" class="input" type="password" required>
                        </div>
                        <div class="field">
                            <label class="label">
                                Nhập lại mật khẩu:
                            </label>
                            <input name="confirm" class="input" type="password" required>
                        </div>
                        <h3 style="color: red;font-size: 16px;">${requestScope.ms}</h3>
                        <input class="submit" type="submit" value="Đăng ký">
                        <div class="sign">
                            Bạn đã có tài khoản?
                            <a href="sign?service=login">Đăng nhập ngay</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
                            <%@include file="footer.jsp" %>

    </body>
</html>
