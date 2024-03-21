<%-- 
    Document   : adminpage
    Created on : Sep 11, 2023, 10:34:42 PM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="stylesheet" href="css/adminheader.css"/>
    </head>
    <body>
        <!--Header-->
        <div class="header">
            <div id="header-section">

                <a href="home" id="left-section">
                    <div class="header-logo">
                        <img src="image/logo-hola.png" alt="">
                    </div>
                    <div class="header-name">
                        <div class="name-shop">Hola Mobile</div>
                        <div class="slogan">__Kết nối mọi người__</div>
                    </div>
                </a>

                <div id="right-section">
                    <h1><a style="text-decoration: none; color: var(--main-color-2)" href="adminpage">TRANG ADMIN</a></h1>
                </div>
                <c:if test="${sessionScope.account!=null}">
                    <div class="user-task user-info">Xin chào <a style="text-decoration: underline;color: #00e1ff;font-weight: 700;" href="url">${sessionScope.account.getUsername()}</a>
                        <div id="user-drop-bar">
                            <a class="user-drop-bar-task" href="adminpage">Đến trang admin</a>
                            <a class="user-drop-bar-task" href="home">Đến trang chủ</a>
                            <a class="user-drop-bar-task" href="usertask?service=myprofile&uid=${account.getUserID()}">Thông tin cá nhân</a>
                            <a class="user-drop-bar-task" href="usertask?service=logout">Đăng xuất</a>
                        </div>
                    </div>
                </c:if>
                <c:if test="${sessionScope.account==null}">
                    <div class="user-task"><a href="sign?service=login">Đăng nhập</a></div>
                </c:if>
            </div>
        </div>
        <!--End-Header-->

    </body>
</html>
