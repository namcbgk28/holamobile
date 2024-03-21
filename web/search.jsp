<%-- 
    Document   : search.jsp
    Created on : Oct 18, 2023, 10:18:56 PM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/base.css"/>
        <link rel="stylesheet" href="css/home.css"/>
        <link rel="stylesheet" href="css/product.css"/>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <style>
            .header {
                z-index: 100;
                position: fixed;
                top: 0;
            }
        </style>
        <%      
                ResultSet rs =  (ResultSet) request.getAttribute("rs");
        %>
        <div id="app">
            <div id="mySidenav" class="sidenav">
                <h1 style="text-align: unset;margin: 0;font-size: 50px;padding-left: 16px;" class="name-shop">MENU</h1>
                <ul class="list-category">
                    <li class="category"><a href="home">
                            <i style="min-width: 20px;" class="fa-solid fa-house"></i>
                            Trang chủ</a></li>
                            <c:forEach items="${requestScope.dataCate}" var="i">
                        <li class="category">
                            <a href="productcontroller?service=showproduct&cid=${i.getCategoryID()}&page=1">${i.getCategoryName()}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <div style="margin-top:-40%;" class="container-product">
                <!------------------------BreadCrumb------------------------->
                <div class="breadcrumb">
                    <a class="menu-item" href="home">Trang chủ</a>
                    /
                    <a class="menu-item" href="#">Tìm kiếm</a>
                </div>


                <div class="list-product">
                    <div style="font-size: 30px; margin-bottom: 20px; font-family: sans-serif">
                        Kết quả tìm kiếm cho từ khóa: <strong>${requestScope.key}</strong>
                    </div>

                    <div class="list-all-product">
                        <% while(rs.next()){%>
                        <div style="height: 500px" class="card-product">
                            <div class="sale-label">
                                Sale <%= rs.getDouble("Discount")%>%
                            </div>
                            <div class="product-image">
                                <a style="overflow: hidden; display: block; width: 100%; height: 100%;" href="home?service=displayproduct&pid=<%= rs.getInt("ProductID")%>">
                                    <img class="p-image" src="image/product/<%= rs.getInt("ProductID")%>/1.png" alt="">
                                </a>
                            </div>
                            <div class="product-content">
                                <div class="product-name">
                                    <a href=""><%= rs.getString("ProductName")%></a>
                                </div>
                                <div class="product-rate">
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                </div>
                                <div class="product-price">
                                    <div class="new-price">
                                        <%= df.format(rs.getDouble("UnitPrice")*(1-rs.getInt("ProductID")/100)) %>₫
                                    </div>
                                    <div class="old-price">
                                        <%=df.format(rs.getDouble("UnitPrice"))%>₫
                                    </div>
                                </div>
                            </div>
                            <form class="add-btn" action="cartcontroller">
                                <input type="hidden" name="pid" value="<%= rs.getInt("ProductID")%>">
                                <input type="hidden" name="service" value="addtocart">
                                <input type="hidden" name="quantity" value="1">
                                <button style="margin-top: 20px; border-radius: 12px;" class="add-cart" id="submit-add-to-cart" type="submit" value="submit">
                                    <i style="margin-right: 4px;" class="fa-solid fa-cart-plus"></i>Thêm  vào giỏ
                                </button>
                            </form>
                        </div>
                        <%} %>
                    </div>
                </div>

            </div>
        </div>
                        <%@include file="footer.jsp" %>

    </body>
</html>
