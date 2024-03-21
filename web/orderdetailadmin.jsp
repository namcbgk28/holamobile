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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="css/base.css">
        <link rel="stylesheet" href="css/adminpage.css">
        <link rel="stylesheet" href="css/myprofile.css"/>
    </head>
    <body>
        <%@include file="adminheader.jsp" %>
        <!-- Content -->
        <%  
            ResultSet rs = (ResultSet)request.getAttribute("rs");
            ResultSet rsDetail = (ResultSet)request.getAttribute("rsDetail");
            Object oid = request.getAttribute("oid");
            
            DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);
        %>
        <div class="app">
            <div class="admin-content">
                <div class="admin-content-title">
                    <h1 style="font-family:var(--main-font-family);font-weight: 700;line-height: 1.1;font-size: 44px;">                    
                        Chi tiết đơn hàng ID <span style="color: red;"><%=oid%></span></h1>

                </div>
                <div style="display: flex; justify-content: center">
                    <h5  class="mb-3 mr-3"><a href="OrderManager" class="text-body"><i
                                class="fas fa-long-arrow-alt-left me-2"></i>Trở lại</a></h5>
                            <%if(rs.next()){%>
                    <div style="width: 45%; background-color: #fff;height: 300px;" class="order">
                        <table>
                            <tr>
                                <td class="order-title">Mã hóa đơn:</td>
                                <td><%=rs.getInt("OrderID")%></td>
                            </tr>
                            <tr>
                                <td class="order-title">Tên khách hàng:</td>
                                <td><%=rs.getString("FullName")%></td>
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
                                <td style="color: red; font-weight: 600;"><%=df.format(rs.getDouble("TotalPrice"))%></td>
                            </tr>
                        </table>                    
                    </div>
                    <%}%>
                    <div style="margin-top: 20px;" class="order-detail">
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

                        <%while(rsDetail.next()){%>
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div class="d-flex flex-row align-items-center">
                                        <div class="mr-3">
                                            <img src="image/product/<%=rsDetail.getInt("ProductID")%>/1.png" class="img-fluid rounded-3" alt="Shopping item"
                                                 style="width: 65px;">
                                        </div>
                                        <div style="width: 250px;" class="text-center ms-3">
                                            <h5 style="font-size: 16px;"><%=rsDetail.getString("ProductName")%></h5>
                                        </div>
                                    </div>
                                    <div style="width: 25%;" class="d-flex flex-row align-items-center">
                                        <div class="text-center" style="width: 100px;">
                                            <h5 style="font-size: 16px;" class="fw-normal mb-0"><%=rsDetail.getInt("Quantity")%></h5>
                                        </div>
                                        <div style="width: 100px;">
                                            <h5 style="font-size: 16px;" class="mb-0"><%=df.format(rsDetail.getDouble("OrderPrice")*rsDetail.getInt("Quantity"))%></h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                </div>

            </div>
        </div>
        <!-- Content -->
    <%@include file="footer.jsp" %>

    </body>
</html>
