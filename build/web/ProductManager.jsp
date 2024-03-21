<%-- 
    Document   : adminpage
    Created on : Sep 11, 2023, 10:34:42 PM
    Author     : Chaunam270203
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.text.DecimalFormat" %>
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
        <link rel="stylesheet" href="css/adminpage.css">
        <script>
            function doDelete(id) {
                if (confirm("Xóa id: " + id + "\n" + "Bạn chắc chưa")) {
                    window.location = "ProductManager?service=deleteproduct&id=" + id;
                }
            }
        </script>
        <style>
            .active{
                background-color: var(--main-color-1);
                color: #fff !important;
            }
        </style>
    </head>
    <body>
        <%@include file="adminheader.jsp" %>
        <!-- Content -->
        <c:set var="page" value="${requestScope.page}"/>

        <%  ResultSet rs =  (ResultSet) request.getAttribute("rs");
            DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);
            double from = 0;
            double to = 40000000;
            if(request.getAttribute("from")!=null){
                from = (Double)request.getAttribute("from");
            }
            
            if(request.getAttribute("to")!=null){
                to = (Double)request.getAttribute("to");
            }
        %>
        <div class="app">
            <div id="navbar">
                <div style="padding: 20px">
                    <i onclick="closeNav()" class="close fa-solid fa-xmark"></i>
                    <h1 style="text-align: unset;margin: 0;font-size: 50px;padding-left: 16px;" class="name-shop">MENU</h1>
                    <ul class="list-option">
                        <li class="option">
                            <a href="home">
                                <i style="min-width: 20px;" class="fa-solid fa-house"></i>
                                Đến trang chủ</a>
                        </li>

                        <li class="option">
                            <a href="adminpage">
                                <i style="min-width: 20px;" class="fa-solid fa-mobile-button"></i>
                                Sản phẩm</a>
                        </li>

                        <li class="option">
                            <a href="adminpage?service=usermanager">
                                <i style="min-width: 20px;" class="fa-solid fa-user"></i>
                                Người dùng</a>
                        </li>

                        <li class="option">
                            <a href="adminpage?service=ordermanager">
                                <i style="min-width: 20px;" class="fa-solid fa-newspaper"></i>
                                Đơn hàng</a>
                        </li>
                        <li class="option">
                            <a href="adminpage?service=statistic">
                                <i style="min-width: 20px;" class="fa-solid fa-chart-pie"></i>
                                Thống kê</a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="admin-content">
                <div class="admin-content-title">
                    <h1 style="font-family:var(--main-font-family);font-weight: 700;line-height: 1.1;font-size: 44px;">                    
                        <i onclick="openNav()" class="btn-menu fa-solid fa-bars"></i>
                        Quản lý sản phẩm</h1>
                </div>
                <div class="head-content">
                    <div class="first-head">
                        <a class="button" href="ProductManager?service=addproduct">Thêm sản phẩm
                            <i class="fa-solid fa-circle-plus"></i>
                        </a>
                    </div>
                    <div class="second-head">
                        <form action="#" style="width: 100%;">
                            <input class="admin-search" type="text" placeholder="Search...">
                            <button class="admin-submit" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </form>
                    </div>
                </div>

                <div class="mid-content">
                    <div>
                        Hiển thị ${requestScope.start+1}-${requestScope.start+12} trong số ${requestScope.totalProduct} sản phẩm
                    </div>
                    <div class="pagination">
                        <c:forEach begin="1" end="${requestScope.numberPage}" var="i">
                            <a class="${i==page?"active":""}" 
                               href="ProductManager?service=searchadmin&page=${i}&sort=${sort}&from=<%=from%>&to=<%=to%>&key=${key}">${i}</a>
                        </c:forEach>
                    </div>
                </div>

                <!----------Search Section---------->
                <div style="background-color: #fff; border-radius: 8px;padding: 16px 12px; margin-top: 10px;    box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75);" class="search-section">
                    <form action="ProductManager">
                        <input type="hidden" name="service" value="searchadmin">
                        <input type="hidden" name="page" value="1">
                        <div style="margin-right: 7%">
                            Sắp xếp theo
                            <select class="input" name="sort">
                                <option ${requestScope.sort == 0?"selected":""} value="0">Giá từ thấp đến cao</option>
                                <option ${requestScope.sort == 1?"selected":""} value="1">Giá từ cao đến thấp</option>
                                <option ${requestScope.sort == 2?"selected":""} value="2">ID từ thấp đến cao</option>
                                <option ${requestScope.sort == 3?"selected":""} value="3">ID từ cao đến thấp</option>
                            </select>
                        </div>

                        <div style="margin-right: 7%">
                            Thể loại:
                            <select class="input" name="sort">
                                <option ${requestScope.sort == 0?"selected":""} value="0">Giá từ thấp đến cao</option>
                                <option ${requestScope.sort == 1?"selected":""} value="1">Giá từ cao đến thấp</option>
                                <option ${requestScope.sort == 2?"selected":""} value="2">ID từ thấp đến cao</option>
                                <option ${requestScope.sort == 3?"selected":""} value="3">ID từ cao đến thấp</option>
                            </select>
                        </div>

                        <div style="margin-right: 7%">
                            Hãng:
                            <select class="input" name="sort">
                                <option ${requestScope.sort == 0?"selected":""} value="0">Giá từ thấp đến cao</option>
                                <option ${requestScope.sort == 1?"selected":""} value="1">Giá từ cao đến thấp</option>
                                <option ${requestScope.sort == 2?"selected":""} value="2">ID từ thấp đến cao</option>
                                <option ${requestScope.sort == 3?"selected":""} value="3">ID từ cao đến thấp</option>
                            </select>
                        </div>

                        <div style="margin-right: 7%">
                            Trạng thái:
                            <select class="input" name="sort">
                                <option ${requestScope.sort == 0?"selected":""} value="0">Giá từ thấp đến cao</option>
                                <option ${requestScope.sort == 1?"selected":""} value="1">Giá từ cao đến thấp</option>
                                <option ${requestScope.sort == 2?"selected":""} value="2">ID từ thấp đến cao</option>
                                <option ${requestScope.sort == 3?"selected":""} value="3">ID từ cao đến thấp</option>
                            </select>
                        </div>

                        <div style="width: 360px; display: flex; flex-direction: column">
                            <div>
                                Từ giá: <span id="from-value"><%=df.format(from)%>&nbsp;₫</span> 
                            </div>
                            <input name="from" id="from" type="range" class="form-range" min="0" max="40000000" value="0" step="1000000">
                            <div>
                                Đến giá: <span id="to-value"><%=df.format(to)%>&nbsp;₫</span>
                            </div>
                            <input name="to" id="to" type="range" class="form-range" min="0" max="40000000" value="40000000" step="1000000">
                        </div>
                        <div style="margin-left: 7%">
                            Tìm kiếm theo tên hoặc ID
                            <input value="${requestScope.key}" class="input" name="key" type="text" placeholder="Tên hoặc ID sản phẩm">
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
                </div>


                <div class="tail-content">
                    <table class="info-product">
                        <thead style="text-align: center; background:white;color: var(--main-color-2);font-size: 16px;font-weight: 700px">
                            <tr>
                                <th>ID</th>
                                <th>ẢNH</th>
                                <th>THỂ LOẠI</th>
                                <th>Hãng</th>
                                <th style="width: 18%">TÊN SẢN PHẨM</th>
                                <th>SỐ LƯỢNG HÀNG</th>
                                <th>GIÁ GỐC</th>
                                <th>GIẢM GIÁ (%)</th>
                                <th>Hãng</th>
                                <th>ACTION</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% while(rs.next()){%>
                            <tr style="text-align: center;font-size: 15px">
                                <td><%=rs.getInt("ProductID")%></td>
                                <td><img class="image" src="image/product/<%=rs.getInt("ProductID")%>/1.png" alt=""></td>
                                <th>Hãng</th>
                                <td><%=rs.getString("CategoryName")%></td>
                                <td style="text-align: left;font-weight: 700"><%=rs.getString("ProductName")%></td>
                                <td><%=rs.getInt("UnitInStock")%></td>     

                                <td><%=df.format(rs.getDouble("UnitPrice"))%> (VND)</td>
                                <td><%=rs.getDouble("Discount")%></td>
                                <th>Trạng thái</th>
                                <td>
                                    <a class="icon-edit" href="ProductManager?service=updateproduct&id=<%=rs.getInt("ProductID")%>"><i class="fa-regular fa-pen-to-square"></i></a>
                                    <a class="icon-delete"  href="#" onclick="doDelete('<%=rs.getInt("ProductID")%>')">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </a>
                                </td>
                            </tr>
                            <%}%>

                        </tbody>
                    </table>
                </div>
                <div class="mid-content">
                    <div class="pagination">
                        <c:forEach begin="1" end="${requestScope.numberPage}" var="i">
                            <a class="${i==page?"active":""}" 
                               href="ProductManager?service=searchadmin&page=${i}&sort=${sort}&from=<%=from%>&to=<%=to%>&key=${key}">${i}</a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <!-- Content -->

        <!--JS-->
        <script>
            /* Set the width of the side navigation to 250px */
            function openNav() {
                document.getElementById("navbar").style.width = "18%";
            }

            /* Set the width of the side navigation to 0 */
            function closeNav() {
                document.getElementById("navbar").style.width = "0";
            }
        </script>
    </body>
    <%@include file="footer.jsp" %>
</html>
