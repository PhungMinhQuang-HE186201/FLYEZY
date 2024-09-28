<%-- 
    Document   : changePassword
    Created on : Jun 9, 2024, 2:10:34 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="controller.EncodeController"%>
<%@page import="static controller.EncodeController.SECRET_KEY" %>
<%@page import="model.Accounts"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/styleLoginAndRegister.css" />
        <style>
            body{
                background-image: none !important;
            }
        </style>
    </head>
    <body>
        <%@include file="view/header.jsp" %> 
         <%
            EncodeController ec = new EncodeController();
         %>
        <div style="display: flex;
             justify-content: center;
             align-items: center;
             height: 100%">
            <form action="changePassword" method="post" 
                  style="margin: 100px 0;">
                <%String currentP = ((Accounts)request.getAttribute("account")).getPassword();%>
                <input type="hidden" id="currentPassword" value="<%=ec.decryptAES(currentP,SECRET_KEY)%>"/>
                <input type="hidden" name="idAccount" value="${requestScope.account.getId()}"/>
                <div class="form-group">
                    <input type="password" name="pass" id="password" onkeyup="checkCurrentPass()" required />
                    <label for="">Mật khẩu hiện tại</label>
                </div>
                <div class="form-group">
                    <input type="password" name="newPass" id="newPass" required />
                    <label for="">Mật khẩu mới</label>
                </div>
                <div class="form-group">
                    <input
                        type="password"
                        id="confirmPassword"
                        required
                        onkeyup="checkPass()"
                        />
                    <label for="">Nhập lại mật khẩu mới</label>
                </div>
                <div style=" margin-bottom: 10px"><p id="wrongCurrentPass" style="display: none; color: red;">
                        Mật khẩu hiện tại không chính xác
                    </p></div>
                <div style=" margin-bottom: 10px"><p id="wrongPassNew" style="display: none; color: red;">
                        Mật khẩu mới không trùng khớp
                    </p></div>
                <p id="capslock-warning" style="display: none; margin-bottom: 30px">⚠️ Caps Lock is on</p>
                <div class="button">
                    <input id="submit" type="submit" value="Đổi mật khẩu" /><br /><br />
                </div>
            </form>
        </div>
        <script>    
            var p = document.getElementById("password");
            var pn = document.getElementById("passNew");