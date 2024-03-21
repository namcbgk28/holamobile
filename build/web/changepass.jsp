<%-- 
    Document   : myprofile
    Created on : Oct 3, 2023, 1:04:47 AM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Page</title>
        <link rel="stylesheet" href="fonts/fontawesome-free-6.4.0-web/css/all.css">
        <link href='https://fonts.googleapis.com/css?family=Anton' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css2?family=Ephesis&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/base.css">
        <link rel="stylesheet" href="css/myprofile.css"/>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <c:set var="u" value="${sessionScope.account}"/>

        <div id="app">
            <div class="container-user">
                <div class="user-info-left">
                    <div class="info-top">
                        <i class="fa-regular fa-circle-user icon-user"></i>
                        <div class="info-name">
                            <div class="info-username">${u.getUsername()}</div>
                            <a href="usertask?service=myprofile&uid=${u.getUserID()}">
                                <i class="fa-solid fa-pen"></i>
                                Sửa hồ sơ</a>
                        </div>
                    </div>
                    <div class="info-bot">
                        <ul class="list-info">
                            <li class="info-task">
                                <a href="usertask?service=myprofile&uid=${u.getUserID()}">
                                    <div>
                                        <i style="color: green;" class="fa-solid fa-user"></i>
                                    </div>
                                    Hồ sơ của tôi
                                </a>
                            </li>
                            <li class="info-task">
                                <a href="usertask?service=changepass">
                                    <div>
                                        <i style="color:#ee4d2d;" class="fa-solid fa-key"></i>
                                    </div>
                                    Đổi mật khẩu
                                </a>
                            </li>
                            <li class="info-task">
                                <a href="">
                                    <div>
                                        <img style="width: 25px;" src="https://down-vn.img.susercontent.com/file/f0049e9df4e536bc3e7f140d071e9078">
                                    </div>
                                    Đơn mua
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="user-info-right">
                    <div style="margin-left: 20px; padding-left: 0; margin-right: 20px;" class="info-top">
                        <div class="">
                            <h2 style="font-size: 33px; margin-bottom: 4px;" >Đổi mật khẩu</h2>
                        </div>
                    </div>
                    <div style="margin-left: 40px; margin-right: 40px;" class="info-bot">
                        <form action="usertask" method="post">
                            <input type="hidden" name="service" value="changepass">
                            <div style="margin-bottom: 30px;margin-top: 0;" class="field">
                                <label class="label">
                                    Mật khẩu cũ:
                                </label>
                                <input name="oldpass" class="input" type="password" required>
                            </div>
                            <div style="margin-bottom: 30px;margin-top: 0;" class="field">
                                <label class="label">
                                    Mật khẩu mới:
                                </label>
                                <input name="newpass" class="input" type="password" required>
                            </div>
                            <div style="margin-bottom: 30px;margin-top: 0;" class="field">
                                <label class="label">
                                    Nhập lại mật khẩu mới:
                                </label>
                                <input name="confirm" class="input" type="password" required>
                            </div>
                            <h3 style="font-family: sans-serif;
                                color: red;
                                font-size: 16px;
                                font-weight: 600;">${requestScope.ms}</h3>
                            <div style="width: 30%; margin: auto;">
                                <input  class="submit" type="submit" value="Đổi mật khẩu">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <%@include file="footer.jsp" %>
</html>
