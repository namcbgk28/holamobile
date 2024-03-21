<%-- 
    Document   : bill.jsp
    Created on : Oct 23, 2023, 3:47:43 PM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Vector"%>
<%@page import="entity.Product"%>
<%@page import="entity.OrderDetail"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="header.jsp"%>

        <section class="h-100 h-custom" style="background-color: #eee;">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col">
                        <div class="card">
                            <div class="card-body p-4">

                                <div class="row">
                                    <div class="col-lg-7">
                                        <h5 class="mb-3"><a href="cartcontroller" class="text-body"><i
                                                    class="fas fa-long-arrow-alt-left me-2"></i>Trở lại giỏ hàng</a></h5>
                                        <hr>
                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                            <div>
                                                <h2 class="mb-1">Đơn hàng của <span class="text-danger font-weight-bold"><%=user.getFullName()%></span></h2>
                                            </div>
                                        </div>

                                        <% 
                                            String service = (String)request.getAttribute("service");
                                            int quantity_buynow = 0;
                                            if(request.getAttribute("quantity_buynow") != null){
                                                quantity_buynow =(Integer)request.getAttribute("quantity_buynow");
                                            }
                                            double totalPrice = (Double)request.getAttribute("totalPrice");
                                            em = session.getAttributeNames();
                                            String[] checkBoxList = (String[])request.getAttribute("checkBoxList");
                                            while (em.hasMoreElements()) {
                                                String id = em.nextElement().toString(); //get key
                                                for (String string : checkBoxList) {
                                                    if(id.equals(string)){
                                                        Cart newcart = (Cart) session.getAttribute(id);
                                        %>
                                        <div class="card mb-3">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between">
                                                    <div class="d-flex flex-row align-items-center">
                                                        <div class="mr-3">
                                                            <img
                                                                src="<%=newcart.getProduct().getImage()%>"
                                                                class="img-fluid rounded-3" alt="Shopping item" style="width: 65px;">
                                                        </div>
                                                        <div style="width: 285px;" class="ms-3">
                                                            <h5 style="font-size: 16px;"><%=newcart.getProduct().getProductName()%></h5>
                                                        </div>
                                                    </div>
                                                    <div class="d-flex flex-row align-items-center">
                                                        <div style="width: 50px;">
                                                            <%if(quantity_buynow>0){%>
                                                            <h5 style="font-size: 16px;" class="fw-normal mb-0"><%=quantity_buynow%></h5>
                                                            <%}else{%>
                                                            <h5 style="font-size: 16px;" class="fw-normal mb-0"><%=newcart.getQuantity()%></h5>
                                                            <%}%>
                                                        </div>
                                                        <div style="width: 100px;">
                                                            <%if(quantity_buynow>0){%>
                                                            <h5 style="font-size: 16px;" class="mb-0"><%= df.format(newcart.getProduct().getUnitPrice()*(1-newcart.getProduct().getDiscount()/100)*quantity_buynow)%></h5>
                                                            <%}else{%>
                                                            <h5 style="font-size: 16px;" class="mb-0"><%= df.format(newcart.getProduct().getUnitPrice()*(1-newcart.getProduct().getDiscount()/100)*newcart.getQuantity())%></h5>
                                                            <%}%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%
                                                    }
                                                }
                                            }
                                        %>
                                    </div>
                                    <div class="col-lg-5 d-flex align-items-end">
                                        <div style="width: 100%; height: 100%;" class="card bg-danger text-white rounded-3">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-center mb-4">
                                                    <h5 style="font-size: 24px;" class="mb-0">Thông tin khách hàng</h5>
                                                </div>
                                                <form action="ordercontroller" method="post" class="mt-4">

                                                    <input type="hidden" name="service" value="<%=service%>">
                                                    <input type="hidden" name="totalPrice" value="<%=totalPrice%>">
                                                    <input type="hidden" name="quantity_buynow" value="<%=quantity_buynow%>">

                                                    <div class="form-outline form-white mb-4">
                                                        <label class="form-label" for="typeName">Tên khách hàng</label>
                                                        <input type="text" id="typeName" value="<%=user.getFullName()%>" class="form-control form-control-lg" style="font-size: 18px"/>
                                                    </div>

                                                    <div class="form-outline form-white mb-4">
                                                        <label class="form-label">Địa chỉ giao hàng</label>
                                                        <input name="address" type="text" value="<%=user.getAddress()%>" class="form-control form-control-lg" style="font-size: 18px"/>
                                                    </div>

                                                    <div class="form-outline form-white mb-4">
                                                        <label class="form-label">Số điện thoại</label>
                                                        <input name="phone" type="text" value="<%=user.getPhone()%>" class="form-control form-control-lg" style="font-size: 18px"/>
                                                    </div>

                                                    <hr class="my-4">

                                                    <div class="d-flex justify-content-between">
                                                        <p class="mb-2">Số tiền</p>
                                                        <p class="mb-2"><%=df.format(totalPrice)%></p>
                                                    </div>

                                                    <div class="d-flex justify-content-between">
                                                        <p class="mb-2">Phí Ship</p>
                                                        <p class="mb-2">Miễn phí vận chuyển</p>
                                                    </div>

                                                    <div class="d-flex justify-content-between">
                                                        <p class="mb-2">Thanh toán</p>
                                                        <p class="mb-2">Thanh toán khi nhận hàng</p>
                                                    </div>

                                                    <div class="d-flex justify-content-between mb-4">
                                                        <p class="mb-2">Tổng số tiền</p>
                                                        <p style="font-size: 20px" class="mb-2"><strong><%=df.format(totalPrice)%></strong></p>
                                                    </div>

                                                    <button type="submit" class="btn btn-info btn-block btn-lg">
                                                        <div class="d-flex justify-content-center">
                                                            <span><strong>Đặt hàng</strong></span>
                                                        </div>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
    <%@include file="footer.jsp" %>
</html>
