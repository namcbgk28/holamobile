<%-- 
    Document   : home
    Created on : Sep 26, 2023, 12:32:18 PM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.util.Vector"%>
<%@page import="entity.Category" %>
<%@page import="entity.Product" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hola Mobile</title>
        <link rel="stylesheet" href="css/home.css"/>
        <link rel="stylesheet" href="css/toast.css"/>
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
                Vector<Category> vectorCate = (Vector)request.getAttribute("dataCate");
                Vector<Product> vector1 = (Vector)request.getAttribute("data1");
                Vector<Product> vector2 = (Vector)request.getAttribute("data2");
                Vector<Product> vector3 = (Vector)request.getAttribute("data3");
                boolean show = (Boolean)request.getAttribute("show");

        %>
        <!--------Content-------->
        <div id="app">
            <%
                if(show){%>
            <div id="toast">
                <div class="toast toast--success">
                    <div class="toast__icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="toast__body">
                        <h3 class="toast__title">Thông báo</h3>
                        <p class="toast__msg">Đặt hàng thành công!</p>
                        <p class="toast__msg">Đơn hàng sẽ được vận chuyển trong thời gian sớm nhất!</p>
                    </div>
                </div>
            </div>
            <%}
            %>

            <div id="mySidenav" class="sidenav">
                <h1 style="text-align: unset;margin: 0;font-size: 50px;padding-left: 16px;" class="name-shop">MENU</h1>
                <ul class="list-category">
                    <li class="category"><a href="home">
                            <i style="min-width: 20px;" class="fa-solid fa-house"></i>
                            Trang chủ</a></li>
                            <% for(Category c : vectorCate){%>
                    <li class="category">
                        <a href="productcontroller?service=showproduct&cid=<%=c.getCategoryID()%>&page=1"><%=c.getCategoryName()%></a>
                    </li>
                    <%} %>
                </ul>
            </div>
            <div class="w3-content w3-section" style="max-width:100%; margin-left: 18%;margin-top: -38%;">
                <a href="home?service=displayproduct&pid=30"><img class="mySlides" src="image/banner.png" style="width:100%"></a>
                <a href="home?service=displayproduct&pid=68"><img class="mySlides" src="image/banner2.png" style="width:100%"></a>
                <a href="home?service=displayproduct&pid=93"><img class="mySlides" src="image/banner3.png" style="width:100%"></a>
            </div>
            <script>
                var myIndex = 0;
                carousel();

                function carousel() {
                    var i;
                    var x = document.getElementsByClassName("mySlides");
                    for (i = 0; i < x.length; i++) {
                        x[i].style.display = "none";
                    }
                    myIndex++;
                    if (myIndex > x.length) {
                        myIndex = 1;
                    }
                    x[myIndex - 1].style.display = "block";
                    setTimeout(carousel, 2000); // Change image every 2 seconds
                }
            </script>

            <div class="container-product">

                <!--Data Xiaomi-->
                <div class="list-product">
                    <div class="title-cate">
                        Xiaomi
                    </div>
                    <div class="list-all-product">
                        <% for(Product p : vector1){%>
                        <div class="card-product">
                            <div class="sale-label">
                                Sale <%=p.getDiscount()%> %
                            </div>
                            <div class="product-image">
                                <a style="overflow: hidden; display: block; width: 100%; height: 100%;" href="home?service=displayproduct&pid=<%=p.getProductID()%>">
                                    <img class="p-image" src="image/product/<%=p.getProductID()%>/1.png" alt="">
                                </a>
                            </div>
                            <div class="product-content">
                                <div class="product-name">
                                    <a href=""><%=p.getProductName()%></a>
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
                                        <%=df.format(p.getUnitPrice()*(1-p.getDiscount()/100))%>
                                        ₫
                                    </div>
                                    <div class="old-price">
                                        <%=df.format(p.getUnitPrice())%>
                                        ₫
                                    </div>
                                </div>
                            </div>
                            <form class="add-btn" action="cartcontroller">
                                <input type="hidden" name="service" value="addtocart">
                                <input type="hidden" name="quantity" value="1">
                                <div onclick="addToCart(this)" style="margin-top: 20px; border-radius: 12px;" class="add-cart" id="submit-add-to-cart" type="submit" value="submit">
                                    <i style="margin-right: 4px;" class="fa-solid fa-cart-plus"></i>Thêm  vào giỏ
                                </div>
                                <input type="hidden" name="pid" value="<%=p.getProductID()%>">
                            </form>
                        </div>
                        <%} %>
                    </div>
                    <div class="view-more">
                        <a href="productcontroller?service=showproduct&cid=1">
                            Xem thêm
                        </a>
                    </div>
                </div>

                <!--Data Samsung-->
                <div class="list-product">
                    <div class="title-cate">
                        Samsung
                    </div>
                    <div class="list-all-product">
                        <% for(Product p : vector2){%>
                        <div class="card-product">
                            <div class="sale-label">
                                Sale <%=p.getDiscount()%> %
                            </div>
                            <div class="product-image">
                                <a style="overflow: hidden; display: block; width: 100%; height: 100%;" href="home?service=displayproduct&pid=<%=p.getProductID()%>">
                                    <img class="p-image" src="image/product/<%=p.getProductID()%>/1.png" alt="">
                                </a>
                            </div>
                            <div class="product-content">
                                <div class="product-name">
                                    <a href=""><%=p.getProductName()%></a>
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
                                        <%=df.format(p.getUnitPrice()*(1-p.getDiscount()/100))%>
                                        ₫
                                    </div>
                                    <div class="old-price">
                                        <%=df.format(p.getUnitPrice())%>
                                        ₫
                                    </div>
                                </div>
                            </div>
                            <form class="add-btn" action="cartcontroller">
                                <input type="hidden" name="pid" value="<%=p.getProductID()%>">
                                <input type="hidden" name="service" value="addtocart">
                                <input type="hidden" name="quantity" value="1">
                                <button style="margin-top: 20px; border-radius: 12px;" class="add-cart" id="submit-add-to-cart" type="submit" value="submit">
                                    <i style="margin-right: 4px;" class="fa-solid fa-cart-plus"></i>Thêm  vào giỏ
                                </button>
                            </form>
                        </div>
                        <%} %>
                    </div>
                    <div class="view-more">
                        <a href="productcontroller?service=showproduct&cid=2">
                            Xem thêm
                        </a>
                    </div>
                </div>

                <!--Data OPPO-->
                <div class="list-product">
                    <div class="title-cate">
                        OPPO
                    </div>
                    <div class="list-all-product">
                        <% for(Product p : vector3){%>
                        <div class="card-product">
                            <div class="sale-label">
                                Sale <%=p.getDiscount()%> %
                            </div>
                            <div class="product-image">
                                <a style="overflow: hidden; display: block; width: 100%; height: 100%;" href="home?service=displayproduct&pid=<%=p.getProductID()%>">
                                    <img class="p-image" src="image/product/<%=p.getProductID()%>/1.png" alt="">
                                </a>
                            </div>
                            <div class="product-content">
                                <div class="product-name">
                                    <a href=""><%=p.getProductName()%></a>
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
                                        <%=df.format(p.getUnitPrice()*(1-p.getDiscount()/100))%>
                                        ₫
                                    </div>
                                    <div class="old-price">
                                        <%=df.format(p.getUnitPrice())%>
                                        ₫
                                    </div>
                                </div>
                            </div>
                            <form class="add-btn" action="cartcontroller">
                                <input type="hidden" name="pid" value="<%=p.getProductID()%>">
                                <input type="hidden" name="service" value="addtocart">
                                <input type="hidden" name="quantity" value="1">
                                <button style="margin-top: 20px; border-radius: 12px;" class="add-cart" id="submit-add-to-cart" type="submit" value="submit">
                                    <i style="margin-right: 4px;" class="fa-solid fa-cart-plus"></i>Thêm  vào giỏ
                                </button>
                            </form>
                        </div>
                        <%} %>
                    </div>
                    <div class="view-more">
                        <a href="productcontroller?service=showproduct&cid=3">
                            Xem thêm
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>

                                    function addToCart(div) {
                                        console.log("addToCart");
                                        console.log(div.nextElementSibling.value);
                                        var proid = div.nextElementSibling.value;
                                        $.ajax({
                                            url: "/HolaShop/cartcontroller",
                                            type: "get",
                                            data: {
                                                service: "addtocart",
                                                pid: proid.toString(),
                                                quantity: "1"
                                            },
                                            success: function (data) {
                                                console.log("data: " + data);
                                                var container = document.getElementById("app");
                                                container.innerHTML += data;
                                            }

                                        });
                                    }
        </script>
    </body>
</html>
