<%-- Document : infor Created on : May 12, 2024, 9:59:46 PM Author : Admin --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Thông tin cá nhân</title>
        <link rel="shortcut icon" type="image/jpg" href="image/logo-icon.png" />
        <link rel="stylesheet" href="css/styleInfo.css" />
        <link rel="stylesheet" href="icon/themify-icons/themify-icons.css" />
    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="row" id="info" style="margin: 0; margin-top: 100px; margin-bottom: 100px;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div id="info-banner">
                    <div id="info-avatar" style="display: flex; position: relative;">
                        <img id="info-avatar-pic" style="height: 220px; width: 216px;" src="${requestScope.account.image}" />
                        <p>${requestScope.account.name}
                        <p style="font-size: 20px; opacity: 0.6; margin-top: 165px;">#</p>
                        </p>
                    </div>
                </div>

                <div id="info-in4" class="row">
                    <div class="info-in4-1 col-md-4">
                        Tham gia Tripove từ
                        <strong></strong>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="info-in4-1 col-md-7">
                       
                        <strong>Full Name:</strong>
                        <p>${requestScope.account.name}</p>
                        <strong>Day of birth:</strong>
                        <p>${requestScope.account.dob}</p>
                        <strong>Email:</strong>
                        <p>${requestScope.account.email}</p>
                        <strong>Phone Number:</strong>
                        <p>${requestScope.account.phoneNumber}</p>
                        <strong>Address:</strong>
                        <p>${requestScope.account.address}</p>
                        
                        <button id="info-update" onclick="window.location.href = 'infoUpdate'">Cập nhật</button>
                        <button id="info-home" onclick="window.location.href = 'home'">Trở lại</button>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

       

    </body>
</html>
