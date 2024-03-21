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
        <link rel="stylesheet" href="css/chart.css"/>
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

            .simple-bar-chart{
                --line-color: currentcolor;
                --line-opacity: 0.25;
                --item-gap: 2%;
                --item-default-color: #060606;

                height: 10rem;
                /*display: grid;*/
                display: flex;
                /*                grid-auto-flow: column;
                                gap: var(--item-gap);*/
                /*justify-content: space-evenly;*/
                align-items: end;
                position: relative;
            }

            .simple-bar-chart::after{
                content: "";
                position: absolute;
                /*inset: var(--padding-block) 0;*/
                z-index: -1;
                --line-width: 1px;
                box-shadow: 0 var(--line-width) 0 var(--line-color);
                opacity: var(--line-opacity);
            }
            .simple-bar-chart > .item{
                height: calc((1% * var(--val))*2);
                background-color: #4444b3;
                position: relative;
                width: 60px;
                margin-left: 20px;

            }
            .simple-bar-chart > .item > * {
                position: absolute;
                text-align: center
            }
            .simple-bar-chart > .item > .label {
                inset: 100% 0 auto 0;
                width: 66px;
                font-weight: 600;
            }
            .simple-bar-chart > .item > .value {
                inset: auto 0 100% 0
            }
        </style>
    </head>
    <body>
        <%@include file="adminheader.jsp" %>
        <!-- Content -->
        <%  
            DecimalFormat df = new DecimalFormat("###,###");
            df.setMaximumFractionDigits(8);
            double totalIncome = (Double)request.getAttribute("totalIncome");
            int totalOrder = (Integer)request.getAttribute("totalOrder");

            double m1 = (Double)request.getAttribute("m1");
            double m2 = (Double)request.getAttribute("m2");
            double m3 = (Double)request.getAttribute("m3");
            double m4 = (Double)request.getAttribute("m4");
            double m5 = (Double)request.getAttribute("m5");
            double m6 = (Double)request.getAttribute("m6");
            double m7 = (Double)request.getAttribute("m7");
            double m8 = (Double)request.getAttribute("m8");
            double m9 = (Double)request.getAttribute("m9");
            double m10 = (Double)request.getAttribute("m10");
            double m11 = (Double)request.getAttribute("m11");
            double m12 = (Double)request.getAttribute("m12");
            
            int totalUser = (Integer)request.getAttribute("totalUser");
            int totalMale = (Integer)request.getAttribute("totalMale");
            int totalFemale = (Integer)request.getAttribute("totalFemale");
            int totalNew = (Integer)request.getAttribute("totalNew");
            
            int numberDone =  (Integer)request.getAttribute("numberDone");
            int numberWait =  (Integer)request.getAttribute("numberWait");
            int numberProcess =  (Integer)request.getAttribute("numberProcess");
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
                        Thống kê số liệu</h1>
                </div>

                <div style="background-color: #fff; padding: 40px;" class="tail-content">
                    <div style=" box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75);
                         padding: 20px;
                         border-radius: 8px;" class="row mb-3 ">

                        <!-- Earnings (Monthly) Card Example -->
                        <div style="height: 270px;" class="col-xl-3 col-md-6 mb-4">
                            <div style="border-radius: 16px; " class="card h-100 shadow-sm">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col mr-2">
                                            <div style="font-size: 30px;" class="text-xs font-weight-bold text-uppercase mb-1">Tổng doanh thu năm 2023
                                            </div>
                                            <div style="font-size: 26px;" class="h5 mb-0 font-weight-bold text-success"><%=df.format(totalIncome)%> VNĐ</div>
                                        </div>

                                    </div>
                                    <div style="    font-size: 43px;
                                         padding: 0;
                                         padding-right: 9px;" class="text-success">
                                        <i class="fa-solid fa-money-bill"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%df = new DecimalFormat("#.##");%>
                        <div style="" class="col-xl-9 col-md-6 mb-4">
                            <h1 class="text-xs font-weight-bold text-uppercase">doanh thu qua các tháng</h1>
                            <div style="margin-top: 200px;" class="simple-bar-chart">

                                <div class="item" style="--clr: #5EB344; --val: <%=df.format(m1/totalIncome * 100)%>">
                                    <div class="label">Tháng 1</div>
                                    <div class="value"><%=df.format(m1/totalIncome * 100)%>%</div>
                                </div>

                                <div class="item" style="--clr: #FCB72A; --val: <%=df.format(m2/totalIncome*100)%>">
                                    <div class="label">Tháng 2</div>
                                    <div class="value"><%=df.format(m2/totalIncome*100)%>%</div>
                                </div>

                                <div class="item" style="--clr: #F8821A; --val: <%=df.format(m3/totalIncome*100)%>">
                                    <div class="label">Tháng 3</div>
                                    <div class="value"><%=df.format(m3/totalIncome*100)%>%</div>
                                </div>

                                <div class="item" style="--clr: #E0393E; --val: <%=df.format(m4/totalIncome*100)%>">
                                    <div class="label">Tháng 4</div>
                                    <div class="value"><%=df.format(m4/totalIncome*100)%>%</div>
                                </div>

                                <div class="item" style="--clr: #963D97; --val: <%=df.format(m5/totalIncome*100)%>">
                                    <div class="label">Tháng 5</div>
                                    <div class="value"><%=df.format(m5/totalIncome*100)%>%</div>
                                </div>

                                <div class="item" style="--clr: #069CDB; --val: <%=df.format(m6/totalIncome*100)%>">
                                    <div class="label">Tháng 6</div>
                                    <div class="value"><%=df.format(m6/totalIncome*100)%>%</div>
                                </div>

                                <div class="item" style="--clr: #069CDB; --val: <%=df.format(m7/totalIncome*100)%>">
                                    <div class="label">Tháng 7</div>
                                    <div class="value"><%=df.format(m7/totalIncome*100)%>%</div>
                                </div>

                                <div class="item" style="--clr: #069CDB; --val: <%=df.format(m8/totalIncome*100)%>">
                                    <div class="label">Tháng 8</div>
                                    <div class="value"><%=df.format(m8/totalIncome*100)%>%</div>
                                </div>

                                <div class="item" style="--clr: #069CDB; --val: <%=df.format(m9/totalIncome*100)%>">
                                    <div class="label">Tháng 9</div>
                                    <div class="value"><%=df.format(m9/totalIncome*100)%>%</div>
                                </div>

                                <div class="item" style="--clr: #069CDB; --val: <%=df.format(m10/totalIncome*100)%>">
                                    <div class="label">Tháng 10</div>
                                    <div class="value"><%=df.format(m10/totalIncome*100)%>%</div>
                                </div>

                                <div class="item" style="--clr: #069CDB; --val: <%=df.format(m11/totalIncome * 100)%>">
                                    <div class="label">Tháng 11</div>
                                    <div class="value"><%=df.format(m11/totalIncome * 100)%>%</div>
                                </div>

                                <div class="item" style="--clr: #069CDB; --val: <%=df.format(m12/totalIncome * 100)%>">
                                    <div class="label">Tháng 12</div>
                                    <div class="value"><%=df.format(m12/totalIncome * 100)%>%</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div style="box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75); padding: 20px;border-radius: 12px; margin-top: 30px;">
                        <div class="row">
                            <div class="col-xl-3 col-md-6 ">
                                <div style="border-radius: 16px; " class="card h-100 shadow-sm">
                                    <div style="display: flex; align-items: center;" class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col mr-2">
                                                <div style="font-size: 24px;" class="text-xs font-weight-bold text-uppercase mb-1">Đơn hàng
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold text-primary"><%=totalOrder%> đơn hàng (100%)</div>
                                            </div>
                                            <div style="    font-size: 43px;
                                                 " class="col-auto text-primary">
                                                <i class="fa-solid fa-newspaper"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div style="border-radius: 16px; " class="card h-100 shadow-sm">
                                    <div style="display: flex; align-items: center;" class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col mr-2">
                                                <div style="font-size: 24px;" class="text-xs font-weight-bold text-uppercase mb-1 ">Số đơn đã giao
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold text-success"><%=numberDone%> Đơn (<%=df.format((double)numberDone/totalOrder *100)%>%)</div>
                                            </div>
                                            <div style="    font-size: 43px;
                                                 " class="col-auto text-success">
                                                <i class="fa-solid fa-circle-check"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div style="border-radius: 16px; " class="card h-100 shadow-sm">
                                    <div style="display: flex; align-items: center;" class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col mr-2">
                                                <div style="font-size: 24px;" class="text-xs font-weight-bold text-uppercase mb-1">Số đơn đang giao
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold text-warning"><%=numberProcess%> Đơn (<%=df.format((double)numberProcess/totalOrder *100)%>%)</div>
                                            </div>
                                            <div style="    font-size: 43px;
                                                 padding: 0;
                                                 padding-right: 9px;" class="col-auto text-warning">
                                                <i class="fa-solid fa-truck-moving"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div style="border-radius: 16px; " class="card h-100 shadow-sm">
                                    <div style="display: flex; align-items: center;" class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col mr-2">
                                                <div style="font-size: 25px;" class="text-xs font-weight-bold text-uppercase mb-1">Số đơn đang chờ
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold text-danger"><%=numberWait%> Đơn (<%=df.format((double)numberWait/totalOrder *100)%>%)</div>
                                            </div>
                                            <div style="    font-size: 43px;
                                                 padding: 0;
                                                 padding-right: 9px;" class="col-auto text-danger">
                                                <i class="fa-solid fa-cart-shopping"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div style="box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75); padding: 20px;border-radius: 12px; margin-top: 30px;">

                        <div class="row mb-3 ">
                            <div class="col-xl-3 col-md-6 text-danger">
                                <div style="border-radius: 16px; height: 150px;" class="card shadow-sm">
                                    <div style="display: flex; align-items: center;" class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col mr-2">
                                                <div style="font-size: 25px;" class="text-xs font-weight-bold text-uppercase mb-1 text-dark">Người dùng
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold"><%=totalUser%> Người (100%)</div>
                                            </div>
                                            <div style="    font-size: 43px;
                                                 " class="col-auto">
                                                <i class="fa-solid fa-user"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-md-6 text-primary">
                                <div style="border-radius: 16px; height: 150px;" class="card shadow-sm">
                                    <div style="display: flex; align-items: center;" class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col mr-2">
                                                <div style="font-size: 25px;" class="text-xs font-weight-bold text-uppercase mb-1 text-dark">Nam
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold "><%=totalMale%> Người (<%=df.format((double)totalMale/totalUser *100)%>%)</div>
                                            </div>
                                            <div style="    font-size: 43px;
                                                 " class="col-auto">
                                                <i class="fa-solid fa-mars"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div style="color: #ec4fdf;" class="col-xl-3 col-md-6">
                                <div style="border-radius: 16px; height: 150px;" class="card shadow-sm">
                                    <div style="display: flex; align-items: center;" class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col mr-2">
                                                <div style="font-size: 25px;" class="text-xs font-weight-bold text-uppercase mb-1 text-dark">Nữ
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold"><%=totalFemale%> Người (<%=df.format((double)totalFemale/totalUser *100)%>%)</div>
                                            </div>
                                            <div style="    font-size: 43px;
                                                 padding: 0;
                                                 padding-right: 9px;" class="col-auto">
                                                <i class="fa-solid fa-venus"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-md-6 text-success">
                                <div style="border-radius: 16px; height: 150px;" class="card shadow-sm">
                                    <div style="display: flex; align-items: center;" class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col mr-2">
                                                <div style="font-size: 25px;" class="text-xs font-weight-bold text-uppercase mb-1 text-dark">Mới tham gia
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold"><%=totalNew%> Người</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%  int totalProduct = (Integer)request.getAttribute("totalProduct");
                        ResultSet rsPro = (ResultSet)request.getAttribute("rsPro");
                    
                    %>
                    <div style="box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75); padding: 20px;border-radius: 12px; margin-top: 30px;">
                        <h1 style="margin-bottom: 30px;">THỐNG KÊ SẢN PHẨM ĐÃ BÁN</h1>
                        <div class="row mb3">
                            <div style="" class="col-xl-9 col-md-6 mb-4">
                                <section class="bar-graph bar-graph-horizontal bar-graph-one">
                                    <%while(rsPro.next()){%>
                                    <div class="bar-one">
                                        <span class="year"><%=rsPro.getString("CategoryName")%></span>
                                        <div title="<%=rsPro.getInt("TOTAL")%> Sản phẩm" class="bar" data-percentage="<%=df.format((double)rsPro.getInt("TOTAL")/totalProduct*100)%>%" style="--per:<%=df.format((double)rsPro.getInt("TOTAL")/totalProduct*100)%>"></div>
                                    </div>
                                    <%}%>
                                </section>
                            </div>
                            <div style="height: 270px;" class="col-xl-3 col-md-6 mb-4">
                                <div style="border-radius: 16px; " class="card h-100 shadow-sm">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col">
                                                <div style="font-size: 30px;" class="text-xs font-weight-bold text-uppercase mb-1">Tổng số sản phẩm đã bán
                                                </div>
                                                <div style="display: flex; justify-content: center;align-items: center;">
                                                    <div style="font-size: 26px; border:solid 4px #4444b3; height: 150px;width: 150px;border-radius: 50%;padding-top: 12%;color: #4444b3" class="h5 mb-0 text-center"><%=totalProduct%> Sản phẩm (100%)</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                    console.log(shipperupdate[index]);
                    console.log(shipper[index]);
                    shipperupdate[index].value = shipper[index].value;
                    console.log(shipperupdate[index].value);
                });

                statusid[index].addEventListener("change", function () {
                    statusidupdate[index].value = statusid[index].value;
                    console.log(statusidupdate[index].value);
                });
            }
        </script>
        <%@include file="footer.jsp" %>

    </body>
</html>
