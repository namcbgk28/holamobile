<%-- 
    Document   : listallproduct
    Created on : Oct 14, 2023, 8:08:04 PM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${requestScope.cate.getCategoryName()}</title>
        <link rel="stylesheet" href="css/home.css"/>
        <link rel="stylesheet" href="css/listallproduct.css"/>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <style>
            .header {
                z-index: 100;
                position: fixed;
                top: 0;
            }

            .active{
                background-color: var(--main-color-1);
                color: #fff !important;
            }
        </style>
        <c:set var="page" value="${requestScope.page}"/>
        <c:set var="cid" value="${requestScope.cid}" />
        <%      
            ResultSet rs =  (ResultSet) request.getAttribute("rs");
            double max = (Double)request.getAttribute("max");
            double from = 0;
            double to = max;
            if(request.getAttribute("from")!=null){
                from = (Double)request.getAttribute("from");
            }
            
            if(request.getAttribute("to")!=null){
                to = (Double)request.getAttribute("to");
            }
        %>
        <div id="app">
            <div id="mySidenav" class="sidenav">
                <h1 style="text-align: unset;margin: 0;font-size: 50px;padding-left: 16px;" class="name-shop">MENU</h1>
                <ul class="list-category">
                    <li class="category"><a href="home">
                            <i style="min-width: 20px;" class="fa-solid fa-house"></i>
                            Trang chủ</a></li>
                            <c:forEach items="${requestScope.dataCate}" var="i">
                        <li class="category ${i.getCategoryID()==cid?"active":""}">
                            <a class="${i.getCategoryID()==cid?"active":""}" href="productcontroller?service=showproduct&cid=${i.getCategoryID()}&page=1">${i.getCategoryName()}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div style="margin-top: -48%" class="container-product">
                <div class="list-cate-img">
                    <c:forEach items="${requestScope.dataCate}" var="i">
                        <c:if test="${i.getCategoryID() != 6}">
                            <a href="productcontroller?service=showproduct&cid=${i.getCategoryID()}&page=1""><img src="image/category/${i.getCategoryID()}.png" alt=""></a>
                            </c:if>
                        </c:forEach>
                </div>
                <div class="show-product">
                    <div class="show-cate-name">
                        <h1 style="font-family:var(--main-font-family);font-size: 38px;">
                            Tất cả sản phẩm <span style="color: var(--main-color-2)">${requestScope.cate.getCategoryName()}</span></h1>
                    </div>
                </div>
                <div class="list-product">

                    <!----------Search Section---------->
                    <div class="search-section">
                        <form action="productcontroller">
                            <input type="hidden" name="service" value="listProduct">
                            <input type="hidden" name="page" value="1">
                            <input type="hidden" name="cid" value="${cid}">
                            <div>
                                Sắp xếp theo
                                <select class="input" name="sort">
                                    <option ${requestScope.sort == 0?"selected":""} value="0">Giá từ thấp đến cao</option>
                                    <option ${requestScope.sort == 1?"selected":""} value="1">Giá từ cao đến thấp</option>
                                </select>
                            </div>
                            <div style="width: 360px; display: flex; flex-direction: column">
                                <div>
                                    Từ giá: <span id="from-value"><%=df.format(from)%>&nbsp;₫</span> 
                                </div>
                                <input name="from" id="from" type="range" class="form-range" min="0" max="<%=to%>" value="0" step="1000000">
                                <div>
                                    Đến giá: <span id="to-value"><%=df.format(to)%>&nbsp;₫</span>
                                </div>
                                <input name="to" id="to" type="range" class="form-range" min="0" max="<%=to%>" value="<%=to%>" step="1000000">
                            </div>
                            <script>
                                const from = document.getElementById("from");
                                const to = document.getElementById("to");
                                const fromValue = document.getElementById("from-value");
                                const toValue = document.getElementById("to-value");

                                from.addEventListener("input", () => {
                                    fromValue.innerHTML = (Number(from.value)).toLocaleString() + " ₫";
                                    to.min = from.value;
                                    toValue.innerHTML = (Number(to.value)).toLocaleString() + " ₫";
                                });

                                to.addEventListener("input", () => {
                                    toValue.innerHTML = (Number(to.value)).toLocaleString() + " ₫";
                                });
                            </script>
                            <input class="input btn" type="submit" value="Áp dụng">
                        </form>
                        <h3 style="color: red">${requestScope.ms}</h3>
                    </div>

                    <!--------List product-------->
                    <div class="list-all-product">
                        <% while(rs.next()){%>
                        <div class="card-product">
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
                                        <%= df.format(rs.getDouble("UnitPrice")*(1-rs.getDouble("Discount")/100)) %>₫
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

                    <!----------Pagination---------->
                    <div class="pagination">
                        <c:forEach begin="${1}" end="${requestScope.numberPage}" var="i">
                            <a class="${i==page?"active":""}" 
                               href="productcontroller?service=listProduct&page=${i}&cid=${cid}&sort=${requestScope.sort}&from=<%=from%>&to=<%=to%>">${i}</a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
                        <%@include file="footer.jsp" %>>
    </body>
</html>
