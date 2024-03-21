<%-- 
    Document   : myprofile
    Created on : Oct 3, 2023, 1:04:47 AM
    Author     : Chaunam270203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="css/myprofile.css"/>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <c:set var="u" value="${sessionScope.account}"/>
        <% String ms = request.getParameter("ms"); %>
        <div id="app">
            <div class="container-user">
                <div class="user-info-left">
                    <div class="info-top">
                        <i class="fa-regular fa-circle-user icon-user"></i>
                        <div class="info-name">
                            <div class="info-username">${u.username}</div>
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
                                <a href="usertask?service=mypurchase">
                                    <div>
                                        <img style="width: 25px;" src="https://down-vn.img.susercontent.com/file/f0049e9df4e536bc3e7f140d071e9078">
                                    </div>
                                    Đơn mua
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="user-info-right">
                    <div style="margin-left: 20px; padding-left: 0; margin-right: 20px;" class="info-top">
                        <div class="">
                            <h2 style="font-size: 18px; margin-bottom: 4px;" >Hồ sơ của tôi</h2>
                            <p>Quản lý thông tin hồ sơ để bảo mật tài khoản</p>
                        </div>
                    </div>
                    <div style="margin-left: 40px; margin-right: 40px;" class="info-bot">
                        <form action="usertask" method="post">
                            <input type="hidden" name="service" value="myprofile">
                            <div style="margin-bottom: 30px;margin-top: 0;" class="field">
                                <label class="label">
                                    Tên đăng nhập:
                                </label>
                                <input name="username" value="${u.username}" class="input" type="text" readonly>
                            </div>
                            <div style="margin-bottom: 30px;margin-top: 0;" class="field">
                                <label class="label">
                                    Họ và tên:
                                </label>
                                <input id="input" name="full-name" value="${u.fullName}" class="input" type="text" readonly>
                                <div onclick="edit(this)" class="edit">Chỉnh sửa <i class="fa-solid fa-pen"></i></div>
                            </div>
                            <div style="margin-bottom: 30px;margin-top: 0;" class="field">
                                <label class="label">
                                    Gmail:
                                </label>
                                <input id="input" name="gmail" class="input" type="text" value="${u.email}" readonly>
                                <div onclick="edit(this)" class="edit">Chỉnh sửa <i class="fa-solid fa-pen"></i></div>
                            </div>
                            <div style="margin-bottom: 30px;margin-top: 0;" class="field">
                                <label class="label">
                                    Số điện thoại:
                                </label>
                                <input id="input" name="phone" class="input" type="text" value="${u.phone}" readonly>
                                <div onclick="edit(this)" class="edit">Chỉnh sửa <i class="fa-solid fa-pen"></i></div>
                            </div>
                            <c:if test="${u.isGender()}">
                                <div style="width: 100%; margin-bottom: 18px; font-size: 18px;">
                                    <div style="width: 70%; display: flex; align-items: center;">
                                        <p style="width: 43%">Giới tính : </p> Nam <input name="gender" value="true" checked
                                                                                          style="margin-right: 24px; margin-left: 8px;" type="radio"> Nữ <input style="margin-left: 8px;" name="gender" value="false"
                                                                                          type="radio">
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${!u.isGender()}">
                                <div style="width: 100%; margin-bottom: 18px; font-size: 18px;">
                                    <div style="width: 70%; display: flex; align-items: center;">
                                        <p style="width: 43%">Giới tính : </p> Nam <input name="gender" value="true"
                                                                                          style="margin-right: 24px; margin-left: 8px;" type="radio"> Nữ <input style="margin-left: 8px;" name="gender" value="false"
                                                                                          checked type="radio">
                                    </div>
                                </div>
                            </c:if>

                            <div class="field">
                                <label class="label">
                                    Địa chỉ:
                                </label>
                                <input id="input" name="address" class="input" type="text" value="${u.address}" readonly>
                                <div onclick="edit(this)" class="edit">Chỉnh sửa <i class="fa-solid fa-pen"></i></div>
                            </div>
                            <% if(ms!=null){%>
                            <h3 style="font-family: sans-serif;
                                color: red;
                                font-size: 16px;
                                font-weight: 600;"><%=ms%></h3>
                            <%} %>
                            <div style="width: 20%; margin: auto;">
                                <input class="submit" type="submit" value="LƯU">
                            </div>
                            <script>
                                function edit(edit) {
                                    var label = edit.parentElement;
                                    var input = label.querySelector('#input')
                                    input.removeAttribute('readonly');
                                    input.focus();
                                    var val = input.value; //store the value of the element
                                    input.value = ''; //clear the value of the element
                                    input.value = val; //set that value back.  
                                }
                            </script>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
