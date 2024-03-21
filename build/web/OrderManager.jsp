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
<%@page import="entity.Status"%>
<%@page import="entity.Shipper"%>
<%@page import="java.util.Vector"%>
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
        <%  ResultSet rs =  (ResultSet) request.getAttribute("rs");
            ResultSet rsStatus = (ResultSet)request.getAttribute("rsStatus");
            
            Vector<Status> vectorStatus = (Vector<Status>)request.getAttribute("vectorStatus");
            Vector<Shipper> vectorShipper = (Vector<Shipper>)request.getAttribute("vectorShipper");
            
            DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);
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
                        Quản lý đơn hàng</h1>
                </div>

                <div class="mid-content">
                    <div>
                        Hiển thị ${requestScope.start+1}-${requestScope.end} trong số ${requestScope.totalOrder} đơn hàng
                    </div>
                    <div class="pagination">
                        <c:forEach begin="1" end="${requestScope.numberPage}" var="i">
                            <a class="${i==page?"active":""}" 
                               href="OrderManager?service=listOrder&page=${i}&sort=${sort}&key=${key}">${i}</a>
                        </c:forEach>
                    </div>
                </div>

                <!----------Search Section---------->
                <div style="background-color: #fff; border-radius: 8px;padding: 16px 12px; margin-top: 10px;    box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75);" class="search-section">
                    <form style="justify-content: space-around" action="OrderManager">
                        <input type="hidden" name="service" value="listOrder">
                        <input type="hidden" name="page" value="1">
                        <div>
                            Sắp xếp theo
                            <select class="input" name="sort">
                                <option ${requestScope.sort == 0?"selected":""} value="0">Sắp xếp theo ngày đặt hàng</option>
                                <option ${requestScope.sort == 1?"selected":""} value="1">Sắp xếp theo tên khách hàng</option>
                                <option ${requestScope.sort == 2?"selected":""} value="2">Sắp xếp theo đơn giá</option>
                                <option ${requestScope.sort == 3?"selected":""} value="3">Sắp xếp theo đơn vị giao hàng</option>
                            </select>
                        </div>

                        <div>
                            Tìm kiếm theo tên hoặc địa chỉ giao hàng
                            <input value="${requestScope.key}" class="input" name="key" type="text" placeholder="Tên hoặc địa chỉ giao hàng">
                        </div>

                        <div>
                            Trạng thái
                            <select class="input" name="stt">
                                <option ${requestScope.stt == 0?"selected":""} value="0">Tất cả</option>
                                <option ${requestScope.stt == 1?"selected":""} value="1">Wait</option>
                                <option ${requestScope.stt == 2?"selected":""} value="2">Process</option>
                                <option ${requestScope.stt == 3?"selected":""} value="3">Done</option>
                            </select>
                        </div>

                        <input class="input btn" type="submit" value="Áp dụng">
                    </form>
                </div>

                <div class="tail-content">
                    <table class="info-product">
                        <thead style="text-align: center; background:white;color: var(--main-color-2);font-size: 15px;font-weight: 700px">
                            <tr>
                                <th style="width: 7%;">Mã đơn hàng</th>
                                <th style="width: 12%;">Tên khách hàng</th>
                                <th style="width: 7%;">SĐT Người nhận</th>
                                <th style="width: 10%">Địa chỉ</th>
                                <th style="width: 10%">Ngày đặt hàng</th>
                                <th style="width: 10%">Ngày nhận hàng dự kiến</th>
                                <th style="width: 10%">Ngày nhận hàng thực tế</th>
                                <th style="width: 10%">Tổng thanh toán</th>
                                <th style="width: 10%">Đơn vị giao hàng</th>
                                <th>Trạng thái</th>
                                <th>ACTION</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% while(rs.next()){%>
                            <tr style="text-align: center;font-size: 15px">
                                <td><%=rs.getInt("OrderID")%></td>
                                <td><%=rs.getString("FullName")%></td>
                                <td><%=rs.getString("DeliverPhone")%></td>
                                <td style="line-height: 1.6;text-align: left;" ><%=rs.getString("DeliverAddress")%></td> 
                                <td style="line-height: 1.6;" ><%=rs.getString("OrderDate")%></td> 
                                <td style="line-height: 1.6;" ><%=rs.getString("RequiredDate")%></td> 
                                <td style="line-height: 1.6;" ><%=rs.getString("ShippedDate")%></td> 
                                <td style="line-height: 1.6;" ><%=df.format(rs.getDouble("TotalPrice"))%>₫</td> 
                                <td style="line-height: 1.6;" >
                                    <%if(rs.getInt("StatusID")==3){
                                    for (Shipper sh : vectorShipper){
                                        if(sh.getShipperID()==rs.getInt("ShipVia")){%>
                                    <strong><%=sh.getCompanyName()%></strong> 
                                    <%}
                                    }%>
                                    <%}else{%>
                                    <select style="padding: 8px; border-radius: 8px;" name="shipper">
                                        <%if(rs.getInt("ShipVia")==0){%>
                                        <option value="0">Chọn đơn vị vận chuyển</option>
                                        <%  for (Shipper sh : vectorShipper) {%>
                                        <option value="<%=sh.getShipperID()%>"><%=sh.getCompanyName()%></option>
                                        <%}%>
                                        <%}else{
                                            for (Shipper sh : vectorShipper){
                                                if(sh.getShipperID()==rs.getInt("ShipVia")){%>
                                        <option selected value="<%=sh.getShipperID()%>"><%=sh.getCompanyName()%></option>
                                        <%}else{%>
                                        <option value="<%=sh.getShipperID()%>"><%=sh.getCompanyName()%></option>
                                        <%}
                                            }
                                        }
                                        %>
                                    </select>
                                    <%}%>
                                </td> 
                                <td style="line-height: 1.6;" >
                                    <%if(rs.getInt("StatusID")==3){%>
                                    <strong>Done</strong>
                                    <%}else if(rs.getInt("StatusID")==1){%>
                                    <strong>Wait</strong>
                                    <%}else{%>
                                    <select style="padding: 8px; border-radius: 8px;" name="statusid">
                                        <option selected value="2">Process</option>
                                        <option value="3">Done</option>
                                    </select>
                                    <%}%>
                                </td> 
                                <td>
                                    <%if(rs.getInt("StatusID")!=3){%>
                                    <form action="OrderManager" method="post">
                                        <input type="hidden" name="service" value="update">
                                        <input type="hidden" name="oid" value="<%=rs.getInt("OrderID")%>">
                                        <input type="hidden" name="update-shipper" value="<%=rs.getInt("ShipVia")%>">
                                        <input type="hidden" name="update-statusid" value="<%=rs.getInt("StatusID")%>">
                                        <input class="action" type="submit" name="submit" value="Cập nhật">
                                    </form>
                                    <%}%>

                                    <form style="margin-top: 12px;" action="OrderManager" method="post">
                                        <input type="hidden" name="service" value="viewdetail">
                                        <input type="hidden" name="oid" value="<%=rs.getInt("OrderID")%>">
                                        <button title="Xem chi tiết" class="action" type="submit" name="submit"><i class="fa-solid fa-eye"></i></button>
                                    </form>
                                    <style>
                                        .action{
                                            background-color: var(--main-color-2);
                                            border: none;
                                            color: white;
                                            cursor: pointer;
                                            padding: 4px;
                                            border-radius: 8px;
                                        }
                                    </style>
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
                               href="OrderManager?service=listOrder&page=${i}&sort=${sort}&key=${key}&stt=${stt}">${i}</a>
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

            var shipper = document.getElementsByName("shipper");
            var shipperupdate = document.getElementsByName("update-shipper");
            var statusid = document.getElementsByName("statusid");
            var statusidupdate = document.getElementsByName("update-statusid");

            for (let index = 0; index < shipper.length; index++) {
                shipper[index].addEventListener("change", function () {
//                    console.log(shipperupdate[index]);
//                    console.log(shipper[index]);
                    shipperupdate[index].value = shipper[index].value;
//                    console.log(shipperupdate[index].value);
                });
            }

            for (let i = 0; i < statusid.length; i++) {
                statusid[i].addEventListener("change", function () {
                    statusidupdate[i].value = statusid[i].value;
                    console.log(i);
                    console.log(statusidupdate[i]);
                    console.log(statusidupdate[i].value);
                });
            }
        </script>
        <%@include file="footer.jsp" %>
    </body>
</html>
