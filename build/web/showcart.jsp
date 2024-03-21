<%-- 
    Document   : showcart
    Created on : Oct 17, 2023, 7:59:28 PM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Cart" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="css/showcart.css"/>
        <link rel="stylesheet" href="css/base.css"/>
        <link rel="stylesheet" href="css/header.css"/>
        <title>Giỏ hàng</title>
        <style>
            .header{
                margin-top: -20px;
            }
        </style>
    </head>
    <body onload="scroll()" >
        <%@include file="header.jsp" %>
        <!------------------------BreadCrumb------------------------->
        <div style="font-size: 20px;margin-left: 8px;" class="breadcrumb">
            <a class="menu-item" href="home">Trang chủ </a>&nbsp; <span style="color: #007bff"> / </span>&nbsp;
            <a class="menu-item" href="#"> Giỏ hàng</a>
        </div>
        <div style="margin-top: 1px !important;max-width: 1250px;" class="container px-3 my-5 clearfix">
            <!-- Shopping cart table -->
            <div class="card">
                <div class="card-header">
                    <h2>Giỏ hàng của: <span style="color: var(--main-color-2);font-weight: 700;">${sessionScope.account.getFullName()}</span></h2>
                </div>
                <div class="card-body">

                    <div class="table-responsive">
                        <table class="table table-bordered m-0">
                            <thead>
                                <tr>
                                    <!-- Set columns width -->
                                    <th class="text-center py-4 px-2"> 
                                    </th>
                                    <th class="text-center py-4 px-2" style="min-width: 350px;">Sản phẩm</th>
                                    <th class="text-center py-4 px-2" style="width: 200px;">Đơn giá</th>
                                    <th class="text-center py-4 px-2" style="width: 120px;">Số lượng</th>
                                    <th class="text-center py-4 px-2" style="width: 130px;">Số tiền</th>
                                    <th class="text-center align-middle py-3 px-2" style="width: 100px;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                em = session.getAttributeNames();
                                totalInCart = (Integer)request.getAttribute("totalInCart");
                                while (em.hasMoreElements()) {
                                    String id = em.nextElement().toString(); //get key
                                if (!id.equals("account") && !id.equals("jakarta.servlet.jsp.jstl.fmt.request.charset")) {
                                    Cart newcart = (Cart) session.getAttribute(id); //get value
//                                ResultSet rs = (ResultSet)request.getAttribute("rs");
                               
//                                while(rs.next()){
                                    
                                %>

                                <tr>
                                    <td class="text-center py-3 px-4">
                                        <div style="margin: 21px 0;" class="control control-checkbox">
                                            <input style="width: 20px;height: 20px;" class="check-box-list" type="checkbox" name="option" value="<%=newcart.getProduct().getProductID()%>">
                                        </div>
                                    </td>
                                    <td class="p-2">
                                        <div class="media align-items-center">
                                            <img style="width: 80px;" src="<%=newcart.getProduct().getImage()%>" class="d-block ui-bordered mr-4" alt="">
                                            <div class="media-body">
                                                <a style="font-weight: 600;" href="home?service=displayproduct&pid=<%=newcart.getProduct().getProductID()%>" class="d-block text-dark"><%=newcart.getProduct().getProductName()%></a>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center font-weight-semibold align-middle p-2">
                                        <span style="text-decoration: line-through; font-size: 12px;opacity: 0.8;margin-right: 8px" class="old-price">
                                            <%=df.format(newcart.getProduct().getUnitPrice())%>₫
                                        </span>
                                        <span style="font-weight: 600;" class="new-price">
                                            <%=df.format(newcart.getProduct().getUnitPrice()*(1-newcart.getProduct().getDiscount()/100))%>₫
                                        </span>
                                        <input type="hidden" name="unitprice" value="<%= newcart.getProduct().getUnitPrice()*(1-newcart.getProduct().getDiscount()/100) %>">
                                    </td>
                                    <td class="align-middle p-4"><input name="quantity" min="1" max="<%=newcart.getProduct().getUnitInStock()%>" type="number" class="form-control text-center" value="<%=newcart.getQuantity()%>">
                                        <input type="hidden" name="unitstock" value="<%=newcart.getProduct().getUnitInStock()%>">
                                    </td>
                                    <td class="text-center font-weight-semibold align-middle p-4">
                                        <input style="text-align: center;border: none; outline: none; cursor: unset" type="text" readonly name="total" price="<%=newcart.getProduct().getUnitPrice()*(1-newcart.getProduct().getDiscount()/100)*newcart.getQuantity()%>" value="<%= df.format(newcart.getProduct().getUnitPrice()*(1-newcart.getProduct().getDiscount()/100)*newcart.getQuantity())%>">
                                    </td>
                                    <td class="text-center align-middle px-1">
                                        <div style="font-size: 13px;margin-bottom: 6px;">
                                            <a class="icon-edit" href="productcontroller?service=showproduct&cid=<%=newcart.getProduct().getCategoryID()%>&page=1">Xem sản phẩm tương tự</a>
                                        </div>
                                        <div style="font-size: 20px;">
                                            <a class="icon-delete"  href="cartcontroller?service=deletecart&id=<%=newcart.getProduct().getProductID()%>" onclick="doDelete('<%=newcart.getProduct().getProductID()%>')">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </a>
                                        </div>
                                        <div style="font-size: 20px;">
                                            <form action="cartcontroller">
                                                <input type="hidden" name="scroll-position">
                                                <input type="hidden" name="service" value="updatecart">
                                                <input type="hidden" name="pid" value="<%=newcart.getProduct().getProductID()%>">
                                                <input type="hidden" name="update-quantity" value="<%=newcart.getQuantity()%>">
                                                <input type="submit" value="Lưu thay đổi" class="icon-update">
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>

                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <!-- / Shopping cart table -->
                    <div style="margin-bottom: 20px;" class="float-right">
                        <a style="    background-color: var(--red);
                           color: var(--light);cursor: pointer" href="home" type="button" class="btn btn-lg btn-default md-btn-flat mt-2 mr-3">Trở lại mua hàng</a>
                    </div>

                    <!--===========================FORM TO DELETE===============================-->
                    <form action="cartcontroller" class="float-right">
                        <%
                         em = session.getAttributeNames();
                         while (em.hasMoreElements()) {
                             String id = em.nextElement().toString(); //get key
                         if (!id.equals("account") && !id.equals("jakarta.servlet.jsp.jstl.fmt.request.charset")) {
                             Cart newcart = (Cart) session.getAttribute(id); //get value
                        %>
                        <input type="hidden" pid="<%=newcart.getProduct().getProductID()%>" name="option-delete" value="<%=newcart.getProduct().getProductID()%>">
                        <%}
                        }
                        %>
                        <input type="hidden" name="service" value="deletemany">
                        <input onclick="deleteCart()" style="    background-color: var(--red);
                               color: var(--light);" class="btn btn-lg btn-default md-btn-flat mt-2 mr-3" type="submit" name="name" value="Xóa khỏi giỏ hàng">
                    </form>
                </div>

                <!--============================Form to checkout========================-->
                <form style="position: -webkit-sticky; position: sticky; bottom: 0;" action="ordercontroller" method="get">
                    <%
                        em = session.getAttributeNames();
                        totalInCart = (Integer)request.getAttribute("totalInCart");
                        while (em.hasMoreElements()) {
                            String id = em.nextElement().toString(); //get key
                            System.out.println("id cart: "+id);
                        if (!id.equals("account") && !id.equals("jakarta.servlet.jsp.jstl.fmt.request.charset")&& !id.equals("admin")) {
                             Cart newcart = (Cart) session.getAttribute(id); //get value
                    %>
                    <input type="hidden" pid="<%=newcart.getProduct().getProductID()%>" name="option-checkout" value="<%=newcart.getProduct().getProductID()%>">
                    <%}
                    }
                    %>
                    <input type="hidden" name="service" value="checkout">
                    <div class="submit-buy">
                        <div>
                            <label class="control control-checkbox">
                                Chọn tất cả (<%=totalInCart-1%>)
                                <input  id="get-all" type="checkbox" value="0">
                                <div class="control_indicator"></div>
                            </label>
                        </div>
                        <div id="number-of-selected" style="font-family: sans-serif">
                            Tổng thanh toán (0 sản phẩm):
                        </div>
                        <div class="summary-price" id="summary-price">
                            0 ₫
                        </div>
                        <input type="hidden" name="name">
                        <input  type="hidden" type="text" name="uid" value="${sessionScope.account.getUserID()}">
                        <button class="buy-cart" type="submit">
                            Mua hàng 
                        </button>
                    </div>
                    <input type="hidden" name="totalPrice" id="totalPrice" value="0">
                </form>


                <script>

                    function deleteCart(){
                        
                    }
                    
                    function doDelete(id) {
                        if (confirm("Sản phẩm này sẽ bị xóa khỏi giỏ hàng?")) {
                            window.location = "cartcontroller?service=deletecart&id=" + id;
                        }
                    }

                    var unitprice = document.getElementsByName("unitprice");
                    var quantity = document.getElementsByName("quantity");
                    var updatequantity = document.getElementsByName("update-quantity");
                    var total = document.getElementsByName("total");
                    var checkout = document.getElementsByName("option-checkout");

                    var optiondelete = document.getElementsByName("option-delete");

                    console.log("delete: " + optiondelete);
                    console.log("length " + optiondelete.length);
                    console.log("type: " + typeof optiondelete);
                    console.log(optiondelete[0]);
                    console.log("checkout: " + checkout);
                    console.log("length: " + checkout.length);
                    console.log("type: " + typeof checkout);
                    console.log(checkout[0]);

                    var unitstock = document.getElementsByName("unitstock");

//                    var checkboxlist = document.getElementsByClassName("check-box-list");

                    for (let index = 0; index < unitprice.length; index++) {
                        quantity[index].addEventListener("change", function () {

                            //Check for UnitInStock
                            if (parseFloat(quantity[index].value) > unitstock[index].value) {
                                console.log("hihi");
                                quantity[index].value = unitstock[index].value;
                            }

                            updatequantity[index].value = quantity[index].value;
                            var totalprice = parseFloat(unitprice[index].value) * parseFloat(quantity[index].value);
                            total[index].value = totalprice.toLocaleString("en-US");
                            total[index].setAttribute("price", totalprice);

                            calallbuy();
                        });
                    }

                    // Get the button element by its id
                    let getall = document.getElementById("get-all");
                    // Get all the checkbox elements by their name attribute
                    let checkboxes = document.querySelectorAll("input[name ='option']");
                    // Declare a variable to store the state of the checkboxes
                    let count = 0;
                    // Add a click event listener to the button
                    getall.addEventListener("click", function () {
                        console.log(getall.checked);
                        // Loop through all the checkboxes and set them to checked or unchecked based on the variable
                        checkboxes.forEach(function (checkbox) {
                            for (let i = 0; i < checkboxes.length; i++) {
                                if (getall.checked) {
                                    checkboxes[i].checked = true;

                                } else {
                                    checkboxes[i].checked = false;
                                    ;
                                }
                            }
                            if (getall.checked) {
                                count = checkboxes.length;
                            } else {
                                count = 0;
                            }
                        });
                        document.getElementById("number-of-selected").innerHTML = "Tổng thanh toán (" + count + " sản phẩm):";
                        for (let i = 0; i < checkboxes.length; i++) {
                            if (!checkboxes[i].checked) {
                                checkout[i].value = 0;
                                optiondelete[i].value = 0;
                            } else {
                                checkout[i].value = checkout[i].getAttribute("pid");
                                optiondelete[i].value = optiondelete[i].getAttribute("pid");
                            }
                            console.log(optiondelete[i].value);
                        }
                        calallbuy();

                    });

                    for (let i = 0; i < checkboxes.length; i++) {
                        checkboxes[i].addEventListener("click", function () {

                            getall.checked = false;
                            //    console.log(getall.checked);
                            count = 0;
                            for (let i = 0; i < checkboxes.length; i++) {
                                if (checkboxes[i].checked)
                                    count++;
                            }
                            document.getElementById("number-of-selected").innerHTML = "Tổng thanh toán (" + count + " sản phẩm):";
                            for (let i = 0; i < checkboxes.length; i++) {
                                if (!checkboxes[i].checked) {
                                    checkout[i].value = 0;
                                    optiondelete[i].value = 0;
                                } else {
                                    checkout[i].value = checkout[i].getAttribute("pid");
                                    optiondelete[i].value = optiondelete[i].getAttribute("pid");
                                }
                                console.log("delete" + optiondelete[i].value);
                                console.log("checkout" + checkout[i].value);

                            }
                            calallbuy();

                        });
                    }
                    function calallbuy() {
                        var formattedPrice;
                        var sum = 0;
                        for (let i = 0; i < checkboxes.length; i++) {
                            if (checkboxes[i].checked) {
                                sum = sum + parseFloat(total[i].getAttribute("price"));
                            }
                        }
                        if (count === 0) {
                            formattedPrice = 0;
                        }
                        document.getElementById("totalPrice").value = sum;
                        console.log(document.getElementById("totalPrice").value);
                        formattedPrice = sum.toLocaleString("en-US");
                        document.getElementById("summary-price").innerHTML = formattedPrice + " ₫";
                    }
                </script>
            </div>
        </div>
        <%@include file="footer.jsp" %>

    </body>
</html>
