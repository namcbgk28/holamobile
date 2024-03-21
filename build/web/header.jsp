<%-- 
    Document   : header.jsp
    Created on : Sep 11, 2023, 5:32:09 PM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.Vector"%>
<%@page import="entity.Category"%>
<%@page import="entity.User"%>
<%@page import="entity.Cart"%>
<%@page import="model.CategoryDAO"%>
<%@page import="model.ProductDAO"%>
<%@page import="java.util.Collections"%>
<%@page import="java.text.DecimalFormat" %>
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
        <link rel="stylesheet" href="css/header.css">
    </head>

    <body>
        <%
         java.util.Enumeration em = session.getAttributeNames();
            int totalInCart = Collections.list(em).size();
            User user = (User)session.getAttribute("account");
            DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);
        %>
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
                <form id="mid-section" action="home">
                    <input type="hidden" name="service" value="searchhome">
                    <input name="key" class="search" type="text" placeholder="Tìm kiếm">
                    <input style="font-size: 14px" type="submit" value="Search" class="button">
                </form>
                <ul id="right-section">
                    <li class="user-task"><a href="">Giới thiệu</a></li>
                    <li class="user-task"><a href="">Liên hệ</a></li>
                    <li style="position: relative;" id="cart" class="user-task">
                        <a href="cartcontroller?service=gotocart">
                            <i class="fa-solid fa-cart-arrow-down"></i>
                            Giỏ hàng</a>
                            <%if(user!=null){%>
                        <div id="numberItems" style="position: absolute;
                             padding: 3px 6px;
                             color: #fff;
                             border: none;
                             border-radius: 15px;
                             background-color: var(--main-color-2);
                             top: -3px;
                             left: 19px;
                             font-size: 8px;"><%=totalInCart-1%>
                        </div>
                        <%}%>
                        <div id="cart-show">
                            <%if(user==null || totalInCart-1 ==0){%>
                            <div style="color: #111" >Chưa có sản phẩm nào</div>
                            <style>
                                #cart-show{
                                    position: absolute;
                                    z-index: 200;
                                    background: white;
                                    display: none;
                                    flex-direction: column;
                                    width: 400px;
                                    font-family: arial;
                                    padding: 10px;
                                    box-shadow: 0.5px 0.5px 2px;
                                    top: 30px;
                                    right: 0;
                                    box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75);
                                    transition: all ease-in 1s;
                                }
                                #cart:hover #cart-show{
                                    display: flex;
                                    flex-direction: column;
                                    transition: .5s;
                                }
                            </style>
                            <%}else if(totalInCart !=0){%>
                            <p style="color: #111;
                               font-size: 16px;
                               font-weight: 600;
                               margin: 8px 16px;
                               ">Sản phẩm mới thêm</p>
                            <%
                            em = session.getAttributeNames();
                            while (em.hasMoreElements()) {
                                    String id = em.nextElement().toString(); //get key
//                                    System.out.println(id);
                                if (!id.equals("account") && !id.equals("jakarta.servlet.jsp.jstl.fmt.request.charset")&&!id.equals("admin")) {
                                    Cart newcart = (Cart) session.getAttribute(id);
                            %>
                            <a href="home?service=displayproduct&pid=<%=newcart.getProduct().getProductID()%>" class="cart-product">
                                <div style="display: flex; align-items: center">
                                    <img class="cart-product-image" src="image/product/<%=newcart.getProduct().getProductID()%>/1.png">
                                    <p style="padding-left:20px;font-size: 14px;"><%=newcart.getProduct().getProductName()%>  (<%=newcart.getQuantity()%>)</p>
                                </div>
                                <div>
                                    <p style="padding-left:20px; color: var(--main-color-2);font-weight: 600;">₫<%=df.format(newcart.getProduct().getUnitPrice()*(1-newcart.getProduct().getDiscount()/100))%></p>

                                </div>
                            </a>
                            <%
                                }
                            }                       
                            %>
                            <a id="viewcart" href="cartcontroller">Xem giỏ hàng (<%=totalInCart-1%>)</a>
                            <style>
                                #viewcart{
                                    text-align: center;
                                    text-decoration: none;
                                    color: white;
                                    background-color:#c32424;
                                    display: flex;
                                    justify-content: center;
                                    align-items: center;
                                    padding: 10px 0px;
                                    width: 40%;
                                    transition: .5s;
                                    border-radius: 8px;
                                    margin: 20px;
                                }
                                #viewcart:hover{
                                    background-color: var(--main-color-2);
                                }
                                #cart-show{
                                    position: absolute;
                                    z-index: 100000;
                                    background: white;
                                    display: flex;
                                    flex-direction: column;
                                    width: 400px;
                                    font-family: arial;
                                    top: 30px;
                                    right: 0;
                                    box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75);
                                    transition: 0.2s;
                                    height: 0;
                                    overflow-y: scroll;
                                }
                                #cart:hover #cart-show{
                                    transition: 0.2s;
                                    height: 400px;
                                }
                                .cart-product:hover{
                                    box-shadow: 0 0 2px 0 rgba(0, 0, 0, .75);
                                    transition: .4s;
                                }
                                .cart-product{
                                    display: flex;
                                    align-items: center;
                                    height: 56px;
                                    text-decoration: none;
                                    color: #111;
                                    padding: 4px;
                                    transition: .4s;
                                    margin: 0 8px 8px 8px;
                                    justify-content: space-between;
                                }
                                .cart-product-image{
                                    height: 46px;
                                }
                            </style>
                            <%}%>
                        </div>
                    </li>

                    <c:if test="${sessionScope.account!=null}">
                        <li style="font-family: Times New Roman;" class="user-task user-info">Xin chào <a style="text-decoration: underline;color: #00e1ff;font-weight: 700;" href="usertask?service=myprofile&uid=${account.getUserID()}">${sessionScope.account.getUsername()}</a>
                            <div id="user-drop-bar">
                                <c:if test="${sessionScope.account.getRoleID() == 2}">
                                    <a class="user-drop-bar-task" href="usertask?service=myprofile&uid=${account.getUserID()}">Thông tin cá nhân</a>
                                    <a class="user-drop-bar-task" href="usertask?service=mypurchase">Đơn mua</a>
                                    <a class="user-drop-bar-task" href="usertask?service=changepass">Đổi mật khẩu</a>
                                    <a class="user-drop-bar-task" href="usertask?service=logout">Đăng xuất</a>
                                </c:if>
                                <c:if test="${sessionScope.account.getRoleID() == 1}">
                                    <a class="user-drop-bar-task" href="usertask?service=adminpage">Đến trang admin</a>
                                    <a class="user-drop-bar-task" href="usertask?service=myprofile&uid=${account.getUserID()}">Thông tin cá nhân</a>
                                    <a class="user-drop-bar-task" href="usertask?service=logout">Đăng xuất</a>
                                </c:if>
                            </div>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.account==null}">
                        <li class="user-task"><a href="sign?service=login">Đăng nhập</a></li>
                        </c:if>
                </ul>
            </div>
        </div>
    </body>

</html>
