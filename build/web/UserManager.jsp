<%-- 
    Document   : adminpage
    Created on : Sep 11, 2023, 10:34:42 PM
    Author     : Chaunam270203
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
                    window.location = "usercontroller?service=deleteuser&uid=" + id;
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
        <% ResultSet rs =  (ResultSet) request.getAttribute("rs");
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
                        Quản lý người dùng</h1>
                </div>

                <div class="mid-content">
                    <div>
                        Hiển thị ${requestScope.start+1}-${requestScope.start+6} trong số ${requestScope.totalUser} người dùng
                    </div>
                    <div class="pagination">
                        <c:forEach begin="1" end="${requestScope.numberPage}" var="i">
                            <a class="${i==page?"active":""}" 
                               href="usercontroller?service=search&page=${i}&sort=${requestScope.sort}&key=${key}">${i}</a>
                        </c:forEach>
                    </div>
                </div>

                <!----------Search Section---------->
                <div style="background-color: #fff; border-radius: 8px;padding: 16px 12px; margin-top: 10px;    box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75);" class="search-section">
                    <form style="justify-content: space-around" action="usercontroller">
                        <input type="hidden" name="service" value="search">
                        <input type="hidden" name="page" value="1">
                        <div>
                            Sắp xếp theo
                            <select class="input" name="sort">
                                <option ${requestScope.sort == 0?"selected":""} value="0">Sắp xếp theo ngày đăng ký tăng dần</option>
                                <option ${requestScope.sort == 1?"selected":""} value="1">Sắp xếp theo ngày đăng ký giảm dần</option>
                                <option ${requestScope.sort == 2?"selected":""} value="2">Sắp xếp theo tên từ A-Z</option>
                                <option ${requestScope.sort == 3?"selected":""} value="3">Sắp xếp theo tên từ Z-A</option>
                                <option ${requestScope.sort == 4?"selected":""} value="4">Sắp xếp theo số đơn đã mua</option>
                            </select>
                        </div>

                        <div>
                            Tìm kiếm theo tên hoặc ID
                            <input value="${requestScope.key}" class="input" name="key" type="text" placeholder="Tên hoặc ID người dùng">
                        </div>

                        <input class="input btn" type="submit" value="Áp dụng">
                    </form>
                </div>

                <div class="tail-content">
                    <table class="info-product">
                        <thead style="text-align: center; background:white;color: var(--main-color-2);font-size: 16px;font-weight: 700px">
                            <tr>
                                <th>ID</th>
                                <th style="width: 12%;" >Họ và tên</th>
                                <th style="width: 12%;">Tên người dùng</th>
                                <th>Ngày đăng ký</th>
                                <th style="width: 10%;" >Số điện thoại</th>
                                <th>Email</th>
                                <th>Địa chỉ</th>
                                <th>Số đơn đã mua</th>
                                <th>ACTION</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% while(rs.next()){%>
                            <tr style="text-align: center;font-size: 15px">
                                <td><%=rs.getInt("UserID")%></td>
                                <td><%=rs.getString("FullName")%></td>
                                <td style="text-align: left;font-weight: 700"><%=rs.getString("Username")%></td>
                                <td style="line-height: 1.6;" ><%=rs.getString("DateAdd")%></td> 
                                <td><%=rs.getString("Phone")%></td>
                                <td><%=rs.getString("Email")%></td>
                                <td style="text-align: left; line-height: 1.6;" ><%=rs.getString("Address")%></td>
                                <td><%=rs.getInt(8)%></td>
                                <td>
                                    <a class="icon-delete"  href="#" onclick="doDelete('<%=rs.getInt("UserID")%>')">
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
                               href="usercontroller?service=search&page=${i}&sort=${requestScope.sort}&key=${key}">${i}</a>
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
