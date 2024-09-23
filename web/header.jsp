<%-- 
    Document   : Header
    Created on : Sep 14, 2024, 10:09:21 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>JSP Page</title>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Reddit+Sans:ital,wght@0,200..900;1,200..900&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="css/styleHeader.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    </head>
    <body>
        <div id="header">
            <div id="header-logo">
                <a href="home">
                    <img src="img/flyezy-logo2.png" alt=""/>
                </a>
            </div>
            <ul id="header-nav1" style="font-weight: 520">
                <li "><a href="home" >Trang chủ</a></li>
                <li "><a href="routeTicket" >Mua vé</a></li>
                <li "><a href="news">Tin tức</a></li>
                <li "><a href="#footer" >Liên hệ</a></li>
            </ul>


            <c:if test="${requestScope.account==null}">
                <div id="header-nav2">
                    <a href="login"><button id="login-button">Đăng nhập</button></a>
                    <a href="register"><button id="register-button">Đăng ký</button></a>
                </div>
            </c:if>

            <c:if test="${requestScope.account!=null}">
                <div id="header-account">
                    <div id="header-avatar" class="">
                        <img class="" src="${requestScope.account.image}" alt="">
                    </div>
                    <ul id="header-subnav" style="display: none;">
                        <li><a href="info">Thông tin cá nhân</a></li>
                            <c:if test="${requestScope.account.getRoleId()==1}">
                            <li><a href="accountController">Quản lý</a></li>
                            </c:if>
                        <li><a href="buyingHistory">Lịch sử mua vé</a></li>
                        <li><a href="ChangePasswordServlet">Đổi mật khẩu</a></li>
                        <li><a style="color: red;" href="logout">Đăng xuất</a></li>
                    </ul>
                </div>
            </c:if>
        </div>

        <script>
            var subNav = document.getElementById('header-subnav');
            var avatar = document.getElementById('header-avatar');

            avatar.addEventListener('click', function () {
                if (subNav.style.display === "none" || subNav.style.display === "") {
                    subNav.style.display = "block";
                } else {
                    subNav.style.display = "none";
                }
            });
        </script>
    </body>
</html>
