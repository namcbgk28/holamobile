<%-- 
    Document   : myprofile
    Created on : Oct 3, 2023, 1:04:47 AM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Page</title>
        <link rel="stylesheet" href="fonts/fontawesome-free-6.4.0-web/css/all.css">
        <link href='https://fonts.googleapis.com/css?family=Anton' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css2?family=Ephesis&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="css/base.css">
        <link rel="stylesheet" href="css/myprofile.css" />
    </head>
    <body>
        <%@include file="header.jsp" %>
        <c:set var="u" value="${sessionScope.account}"/>
        <%
            ResultSet rs = (ResultSet)request.getAttribute("rs");
            ResultSet rs1 = (ResultSet)request.getAttribute("rs1");
            Boolean show = (Boolean)request.getAttribute("show");
            Object oid = request.getAttribute("oid");
        %>
        <div id="app">
            <div class="container-user">
                <div class="user-info-left">
                    <div class="info-top">
                        <i class="fa-regular fa-circle-user icon-user"></i>
                        <div class="info-name">
                            <div class="info-username">${u.getUsername()}</div>
                            <a href="usertask?service=myprofile&uid=${u.getUserID()}">
                                <i class="fa-solid fa-pen"></i>
                                Sửa hồ sơ</a>
                        </div>
                    </div>
                    <div class="info-bot">
                        <ul class="list-info">
                            <li class="info-task">
                                <a href="usertask?service=myprofile&uid=${u.getUserID()}">
                                    <div>
                                        <i style="color: green;" class="fa-solid fa-user"></i>
                                    </div>
                                    Hồ sơ của tôi
                                </a>
                            </li>
                            <li class="info-task">
                                <a href="usertask?service=changepass">
                                    <div>
                                        <i style="color:#ee4d2d;" class="fa-solid fa-key"></i>
                                    </div>
                                    Đổi mật khẩu
                                </a>
                            </li>
                            <li class="info-task">
                                <a href="">
                                    <div>
                                        <img style="width: 25px;"
                                             src="https://down-vn.img.susercontent.com/file/f0049e9df4e536bc3e7f140d071e9078">
                                    </div>
                                    Đơn mua
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div style="width: 44%; padding-bottom: 20px;" class="user-info-right">
                    <div style="margin-left: 20px; padding-left: 0; margin-right: 20px;" class="info-top">
                        <div class="">
                            <h2 style="font-size: 33px; margin-bottom: 4px;">Hóa đơn của tôi</h2>
                        </div>
                    </div>
                    <div style="margin-left: 20px; padding-left: 0; margin-right: 20px; margin-top: 4px;"
                         class="my-order-section">
                        <%while(rs.next()){%>
                        <div class="order">
                            <div style="display: flex; justify-content: space-between;margin-bottom: 20px;" class="view-detail">
                                <div>
                                    <img style="width: 150px;" src="image/logo.png" alt="alt"/>
                                </div>
                                <div>
                                    <a href="usertask?service=mypurchase&oid=<%=rs.getInt("OrderID")%>">Xem chi tiết</a>
                                </div>
                            </div>
                            <table>
                                <tr>
                                    <td class="order-title">Mã hóa đơn:</td>
                                    <td><%=rs.getInt("OrderID")%></td>
                                </tr>
                                <tr>
                                    <td class="order-title">Ngày đặt hàng:</td>
                                    <td><%=rs.getString("OrderDate")%></td>
                                </tr>
                                <tr>
                                    <td class="order-title">Trạng thái:</td>
                                    <td><%=rs.getString("Status")%></td>
                                </tr>
                                <tr>
                                    <td class="order-title">Địa chỉ nhận hàng:</td>
                                    <td><%=rs.getString("DeliverAddress")%></td>
                                </tr>
                                <tr>
                                    <td class="order-title">Tổng thanh toán:</td>
                                    <td><%=df.format(rs.getDouble("TotalPrice"))%></td>
                                </tr>
                            </table>
                            <%if(rs.getInt("StatusID")==2){%>
                            <form action="ordercontroller" method="post">
                                <input type="hidden" name="service" value="update">
                                <input type="hidden" name="oid" value="<%=rs.getInt("OrderID")%>">
                                <input type="hidden" name="update-statusid" value="3">
                                <input class="action" type="submit" name="submit" value="Xác nhận thanh toán">
                            </form>
                            <%}%>
                            <style>
                                .action{
                                    background-color: var(--main-color-2);
                                    border: none;
                                    color: white;
                                    cursor: pointer;
                                    padding: 4px 8px;
                                    border-radius: 8px;
                                    font-weight: 600;
                                    margin-left: 300px;
                                }
                            </style>
                        </div>
                        <%}%>
                    </div>
                </div>
                <%if(show){%>
                <div class="order-detail">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 style="font-size: 24px;" class="mb-0">Chi tiết đơn hàng ID: <span style="color: red;"><%=oid%></span></h5>
                    </div>

                    <div style="border: none;" class="card mb-3">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div style="font-weight: 500;" class=" d-flex flex-row align-items-center">
                                    Sản phẩm
                                </div>
                                <div style="width: 25%;" class="d-flex flex-row align-items-center">
                                    <div class="text-center" style="width: 100px;">
                                        <h5 style="font-size: 16px;" class=" fw-normal mb-0">Số lượng</h5>
                                    </div>
                                    <div style="width: 100px;">
                                        <h5 style="font-size: 16px;" class="text-center mb-0">Số tiền</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%while(rs1.next()){%>
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div class="d-flex flex-row align-items-center">
                                    <div class="mr-3">
                                        <img src="image/product/<%=rs1.getInt("ProductID")%>/1.png" class="img-fluid rounded-3" alt="Shopping item"
                                             style="width: 65px;">
                                    </div>
                                    <div style="width: 250px;" class="text-center ms-3">
                                        <h5 style="font-size: 16px;"><%=rs1.getString("ProductName")%></h5>
                                    </div>
                                </div>
                                <div style="width: 25%;" class="d-flex flex-row align-items-center">
                                    <div class="text-center" style="width: 100px;">
                                        <h5 style="font-size: 16px;" class="fw-normal mb-0"><%=rs1.getInt("Quantity")%></h5>
                                    </div>
                                    <div style="width: 100px;">
                                        <h5 style="font-size: 16px;" class="mb-0"><%=df.format(rs1.getDouble("OrderPrice")*rs1.getInt("Quantity"))%></h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%}%>
                </div>
                <%}%>
            </div>
        </div>
                <%@include file="footer.jsp" %>

    </body>
</html>
