<%-- 
    Document   : product.jsp
    Created on : Oct 8, 2023, 7:49:02 PM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.util.Vector"%>
<%@page import="entity.Category" %>
<%@page import="entity.Product" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/base.css"/>
        <link rel="stylesheet" href="css/home.css"/>
        <link rel="stylesheet" href="css/product.css"/>
        <link rel="stylesheet" href="css/toast.css"/>

    </head>
    <body>
        <%      
            Vector<Category> vectorCate = (Vector)request.getAttribute("dataCate");
            Vector<Product> sameProduct = (Vector)request.getAttribute("sameProduct");
            Category category = (Category)request.getAttribute("category");
            Product p = (Product)request.getAttribute("pro");
            String show = (String)request.getAttribute("ms");
            
        %>
        <%@include file="header.jsp" %>
        <c:set var="p" value="${requestScope.pro}"/>
        <c:set var="pid" value="${p.getProductID()}"/>
        <% //if(show != null){%>

        <% //}%>

        <div id="container" class="container">

            <!------------------------BreadCrumb------------------------->
            <div class="breadcrumb">
                <a class="menu-item" href="home">Trang chủ</a>
                /
                <a class="menu-item" href="productcontroller?service=showproduct&cid=<%=p.getCategoryID()%>"><%=category.getCategoryName()%></a>
                /
                <a class="menu-item" href="home?service=displayproduct&pid=<%=p.getProductID()%>"><%=p.getProductName()%></a>
            </div>

            <!------------------------Show product details------------------------->
            <div class="container-detail-product">
                <div class="detail-product-image">
                    <div class="product-image-main">
                        <img id="main-image" src="<%=p.getImage()%>" alt="">
                    </div>
                    <div class="product-image-sub">
                        <img onclick="changeImage(this)" class="sub-image" src="image/product/<%=p.getProductID()%>/1.png" alt="">
                        <img onclick="changeImage(this)" class="sub-image" src="image/product/<%=p.getProductID()%>/2.png" alt="">
                        <img onclick="changeImage(this)" class="sub-image" src="image/product/<%=p.getProductID()%>/3.png" alt="">
                        <img onclick="changeImage(this)" class="sub-image" src="image/product/<%=p.getProductID()%>/4.png" alt="">
                    </div>
                </div>
                <div class="detail-product-info">
                    <h1 class="product-name">
                        Điện thoại <%=p.getProductName()%>
                    </h1>
                    <div class="rating">
                        <div class="stars">
                            <span class="fa fa-star checked"></span>
                            <span class="fa fa-star checked"></span>
                            <span class="fa fa-star checked"></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>
                        </div>
                        <span class="review-no"> <span style="text-decoration: underline;">6.4K</span> <span
                                style="opacity: 0.6; font-size: 18px;">Đánh giá</span></span>
                    </div>
                    <div class="product-description">
                        <%=p.getDescription()%>
                    </div>
                    <div class="product-detail-price">
                        <div class="old-price">
                            ₫<%=df.format(p.getUnitPrice())%>
                        </div>
                        <div class="new-price">
                            ₫<%=df.format(p.getUnitPrice()*(1-p.getDiscount()/100))%>
                        </div>
                        <div class="discount">
                            <%=p.getDiscount()%>% GIẢM
                        </div>
                    </div>
                    <div class="some-info">
                        <table>
                            <tr>
                                <td class="col-name">Hãng sản xuất</td>
                                <td class="col-info">
                                    <img style="width: 100px;" src="image/category/<%=p.getCategoryID()%>.png" alt="">
                                </td>
                            </tr>
                            <tr>
                                <td class="col-name">Vận chuyển</td>
                                <td class="col-info">
                                    <img style="width: 30px;" src="image/freeship.png" alt="">
                                    Miễn phí vận chuyển
                                </td>
                            </tr>
                            <tr>
                                <td class="col-name"></td>
                                <td class="col-info"><i style="color: #80cfc6; margin-right: 4px;"
                                                        class="fa-solid fa-truck"></i>
                                    Vận chuyển tới:
                                </td>
                                <td>${sessionScope.account.getAddress()}</td>
                            </tr>
                            <tr>
                                <td class="col-name">Bảo hành</td>
                                <td style="font-weight: 600;" class="col-info">Bảo hành thường 6 tháng</td>
                            </tr>
                        </table>
                        <div style="position: relative">
                            <form id="addtocartform" action="cartcontroller">
                                <table>
                                    <input type="hidden" name="uid" value="${sessionScope.account.getUserID()}">
                                    <input type="hidden" id="pid" name="pid" value="<%=p.getProductID()%>">
                                    <input type="hidden" name="service" value="addtocart">
                                    <tr>
                                        <td class="col-name">Số lượng</td>
                                        <%if(p.getUnitInStock()>0){%>
                                        <td class="col-info">
                                            <div class="counter">
                                                <input type="hidden" id="unitstock" value="<%=p.getUnitInStock()%>">
                                                <button class="quantity-button minus" type="button" id="minus">
                                                    <i class="fa-solid fa-minus"></i>
                                                </button>
                                                <input class="quantity-input" id="quantity" name="quantity" type="text" value="1">
                                                <button class="quantity-button plus" type="button" id="plus">
                                                    <i class="fa-solid fa-plus"></i>
                                                </button>
                                            </div>
                                        </td>
                                        <%}%>
                                        <%if(p.getUnitInStock()>0){%>
                                        <td class="col-name" style="font-size: 16px;"><span style="font-weight: 600"><%=p.getUnitInStock()%></span> sản phẩm có sẵn</td>
                                        <%}else{%>
                                        <td class="col-name" style="font-size: 20px;"><span style="font-weight: 600;color: red;">Hết hàng</span></td>
                                        <%}%>

                                    </tr>
                                    <%if(p.getUnitInStock()>0){%>
                                    <tr>
                                        <td>
                                            <div onclick="addToCart()" class="add-cart" id="submit-add-to-cart">
                                                <i style="margin-right: 4px;" class="fa-solid fa-cart-plus"></i>Thêm vào giỏ hàng
                                            </div>
                                        </td>
                                    </tr>
                                    <%}%>
                                </table>
                            </form>
                            <%if(p.getUnitInStock()>0){%>
                            <form style="    position: absolute;
                                  bottom: 2px;
                                  right: 40%;"action="ordercontroller">
                                <input type="hidden" name="service" value="buynow">
                                <input type="hidden" name="pid" value="<%=p.getProductID()%>">
                                <input type="hidden" id="quantity-buy" name="quantity-buy" value="1">
                                <button class="buy-now">
                                    Mua ngay
                                </button>
                            </form>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
            <!------------------------Show same product------------------------->
            <div class="same-product">
                <h1 class="same-product-title">Sản phẩm tương tự</h1>

                <div class="list-same-product">
                    <%
                    for (Product sp : sameProduct) {%>
                    <div class="card-product">
                        <div class="product-image">
                            <a style="overflow: hidden; display: block; width: 100%; height: 100%;" href="home?service=displayproduct&pid=<%=sp.getProductID()%>">
                                <img class="p-image" src="image/product/<%=sp.getProductID()%>/1.png" alt="">
                            </a>
                        </div>
                        <div class="product-content">
                            <div class="product-name">
                                <a href=""><%=sp.getProductName()%></a>
                            </div>
                            <div class="product-rate">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                            </div>
                            <div class="product-price">
                                <div class="old-price">
                                    ₫<%=df.format(sp.getUnitPrice())%>
                                </div>
                                <div class="new-price">
                                    ₫<%=df.format(sp.getUnitPrice()*(1-sp.getDiscount()/100))%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%}%>
                </div>
                <div class="view-more">
                    <a href="productcontroller?service=showproduct&cid=<%=p.getCategoryID()%>">
                        Xem thêm
                    </a>
                </div>
            </div>
            <!--            <div id="toast">
                            <div class="toast toast--success">
                                <div class="toast__icon">
                                    <i class="fas fa-check-circle"></i>
                                </div>
                                <div class="toast__body">
                                    <h3 class="toast__title">Thông báo</h3>
                                    <p class="toast__msg">Thêm vào giỏ hàng thành công</p>
                                    Đặt hàng thành công!
                                    <p class="toast__msg">Mời bạn tiếp tục mua sắm</p>
                                    Đơn hàng sẽ được vận chuyển trong thời gian sớm nhất
                                </div>
                            </div>
                        </div>-->
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>

                                                var minus = document.getElementById("minus");
                                                var plus = document.getElementById("plus");
                                                var quantity = document.getElementById("quantity");
                                                var quantitybuy = document.getElementById("quantity-buy");
                                                var unitstock = document.getElementById("unitstock");
                                                quantity.addEventListener("change", function () {
                                                    quantitybuy.value = quantity.value;
                                                    console.log(quantity.value);
                                                    console.log(unitstock.value);
                                                    if (quantity.value > unitstock.value) {
                                                        quantity.value = unitstock.value;
                                                        quantitybuy.value = unitstock.value;
                                                        console.log(quantitybuy.value);
                                                        console.log(quantity.value);
                                                    }
                                                });

                                                minus.addEventListener("click", function () {
                                                    if (quantity.value > 1) {
                                                        quantity.value--;
                                                        quantitybuy.value = quantity.value;
//                    console.log(quantitybuy.value);
                                                    }
                                                });

                                                plus.addEventListener("click", function () {
                                                    if (quantity.value < parseFloat(unitstock.value)) {
                                                        quantity.value++;
                                                        quantitybuy.value = quantity.value;
                                                        console.log(typeof quantity.value);
                                                        console.log(typeof unitstock.value);
                                                    }

                                                });
                                                function changeImage(img) {
                                                    var temp;
                                                    var mainImage = document.getElementById("main-image");
                                                    mainImage.src = img.src;
                                                }

                                                var pid = document.getElementById("pid");
                                                console.log("pid: " + pid);
                                                function addToCart() {
                                                    console.log("addToCart");

                                                    $.ajax({
                                                        url: "/HolaShop/cartcontroller?service=addtocart&pid=" + pid.value + "&quantity=" + quantity.value,
                                                        type: "get",
                                                        data: {
                                                        },
                                                        success: function (data) {
                                                            var parts = data.split("##DELIMITER##");
                                                            console.log("data1: " + parts[0]);
                                                            console.log("=========================================================================");
                                                            console.log("data2: " + parts[1]);
                                                            var cart = document.getElementById("cart");
                                                            
                                                            var container = document.getElementById("container");
                                                            container.innerHTML += parts[0];
                                                            cart.innerHTML = parts[1];
                                                        }

                                                    });

                                                }



        </script>
        <%@include file="footer.jsp" %>

    </body>
</html>
