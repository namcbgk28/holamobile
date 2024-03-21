<%-- 
    Document   : updateproduct
    Created on : Sep 20, 2023, 7:52:30 PM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="entity.Product"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="fonts/fontawesome-free-6.4.0-web/css/all.css">
        <link href='https://fonts.googleapis.com/css?family=Anton' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css2?family=Ephesis&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/addproduct.css">
        <link rel="stylesheet" href="css/base.css">
    </head>
    <body>
        <!--Header-->
        <%@include file="adminheader.jsp" %>
        <!--Header-->
        <c:set var="p" value="${requestScope.product}"/>
        <c:set var="cid" value="${requestScope.cid}"/>
        <div class="form-add">
            <div>
                <h1 style="margin: 20px 15%; font-family: Anton; color: var(--main-color-2)">CẬP NHẬT SẢN PHẨM</h1>
            </div>
            <div style="width: 70%; margin: 8px auto;" class="form-info">

                <h3 class="text">Thông tin sản phẩm  <span style="color: var(--main-color-2); text-decoration: underline; font-weight: bold">ID = ${requestScope.product.getProductID()}</span></h3>

                <form action="ProductManager?service=updateproduct&id=${requestScope.product.getProductID()}" method="post">
                    <!--Loại sản phẩm-->
                    <div class="field">
                        <label class="label">
                            Loại sản phẩm:
                        </label>
                        <select onchange="change()" id="category-name" name="cid" class="input">
                            <option value="0">Loại sản phẩm</option>
                            <c:forEach items="${requestScope.dataCate}" var="c">
                                <c:if test="${c.getCategoryID() == cid}">
                                    <option selected value="${c.getCategoryID()}">${c.getCategoryName()}</option>
                                </c:if>
                                <c:if test="${c.getCategoryID() != cid}">
                                    <option value="${c.getCategoryID()}">${c.getCategoryName()}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="field">
                        <label class="label">
                            Tên sản phẩm:
                        </label>
                        <input name="productname" class="input" type="text" required value="${p.getProductName()}">
                    </div>

                    <div class="field">
                        <label class="label">
                            Mô tả:
                        </label>
                        <input name="description" class="input" type="text" required value="${p.getDescription()}">
                    </div>

                    <div class="field">
                        <label class="label">
                            Số lượng:
                        </label>
                        <input name="unitinstock" class="input" type="number" required value="${p.getUnitInStock()}">
                    </div>

                    <div class="field">
                        <label class="label">
                            Giá thành:
                        </label>
                        <%
                            DecimalFormat df = new DecimalFormat("#");
                            df.setMaximumFractionDigits(0);
                            Product pro = (Product)request.getAttribute("product");
                        %>
                        <input name="price" class="input" type="text" required value="<%= df.format(pro.getUnitPrice())%>">
                    </div>

                    <div class="field">
                        <label class="label">
                            Giảm giá:
                        </label>
                        <input name="discount" class="input" type="text" required value="${p.getDiscount()}">
                    </div>
                    
                    <div class="field">
                        <label class="label">
                            Ảnh:
                        </label>
                        <input name="image" class="input" accept="image/png, image/jpeg" type="file" value="" required>
                    </div>
                    
                    <div  style="margin: 20px auto; width: 60%" >
                        <input style="width: 100%" class="submit" type="submit" value="Cập nhật">
                    </div>
                    
                </form>
            </div>
        </div>
    </body>
</html>
