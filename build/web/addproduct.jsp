<%-- 
    Document   : addproduct
    Created on : Sep 15, 2023, 8:32:56 PM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    </head>
    <body>
        <div class="container">

            <!--Header-->
            <%@include file="adminheader.jsp" %>
            <!--Header-->
            
            <div class="form-add">
                <div>
                    <h1 style="margin: 20px 15%; font-family: Anton; color: var(--main-color-2)">THÊM SẢN PHẨM</h1>
                </div>
                <div style="width: 70%; margin: 8px auto;" class="form-info">
                    <h3 class="text">Thông tin sản phẩm</h3>
                    <form action="ProductManager" method="post">
                        <input type="hidden" name="service" value="addproduct">
                        <!--Loại sản phẩm-->
                        <div class="field">
                            <label class="label">
                                Loại sản phẩm:
                            </label>
                            <select onchange="change()" id="category-name" name="cid" class="input">
                                <option value="0">Loại sản phẩm</option>
                                <c:forEach items="${requestScope.dataCate}" var="c">
                                    <option value="${c.getCategoryID()}">${c.getCategoryName()}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="field">
                            <label class="label">
                                Tên sản phẩm:
                            </label>
                            <input name="productname" class="input" type="text" required>
                        </div>

                        <div class="field">
                            <label class="label">
                                Mô tả:
                            </label>
                            <input name="description" class="input" type="text" required>
                        </div>
                        
                        <div class="field">
                            <label class="label">
                                Số lượng:
                            </label>
                            <input name="unitinstock" class="input" type="number" required>
                        </div>

                        <div class="field">
                            <label class="label">
                                Giá thành:
                            </label>
                            <input name="price" class="input" type="text" required>
                        </div>
                        
                        <div class="field">
                            <label class="label">
                                Giảm giá:
                            </label>
                            <input name="discount" class="input" type="text" required>
                        </div>
                        
                        <div class="field">
                            <label class="label">
                                Ảnh:
                            </label>
                            <input name="image" class="input" type="file" accept="image/png, image/jpeg" required>
                        </div>
                        <div  style="margin: 20px auto; width: 60%" >
                            <input style="width: 100%" class="submit" type="submit" value="Thêm sản phẩm">
                        </div>
                    </form>
                </div>
            </div>
    </body>
</html>
