<%-- 
    Document   : infoUpdate
    Created on : May 13, 2024, 8:23:26 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cập nhật thông tin</title>
        <link rel="shortcut icon" type="image/jpg" href="image/logo-icon.png" />
        <link rel="stylesheet" href="css/styleInfo.css" />
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div id="update-form">
            <h1>Cập nhật thông tin cá nhân</h1>
            <form action="InfoUpdateServlet" method="post">
                Ảnh đại diện: <input type="file" name="image">
                <input type="hidden" name="id" value="${requestScope.account.id}"/>
                Họ và tên:<br> <input type="text" name="name" value="${requestScope.account.name}" /><br>
                Ngày sinh: <br> <input type="date" name="birth" value="${requestScope.account.dob}"><br>
                Email:<br><input type="email" name="email" value="${requestScope.account.email}"/><br>
                Số điện thoại:<br><input type="number" name="phone" value="${requestScope.account.phoneNumber}"/><br>
                Địa chỉ:<br>
                <textarea style="padding: 2px" name="address" cols="20" rows="3" value="${requestScope.account.address}">${requestScope.account.address}</textarea>
                <br>
                <button id="info-update" type="submit">Cập nhật</button>
                <button id="info-home" onclick="window.location.href = 'info'">Huỷ</button>                
            </form>
                
                
                    
                
                
        </div>
       
    </body>
</html>
