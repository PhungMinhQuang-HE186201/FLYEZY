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

            label {
                font-weight: 500 !important
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

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
                <input type="hidden" name="currentPassword" id="currentPassword" value="<%=ec.decryptAES(currentP,SECRET_KEY)%>"/>
                <input type="hidden" name="idAccount" value="${requestScope.account.getId()}"/>
                <!-- Error message display from session -->
                <div style=" margin-bottom: 10px"><p id="wrongCurrentPass" style="display: none; color: red;">
                        Mật khẩu hiện tại không chính xác
                    </p></div>


                <div class="form-group">
                    <input type="password" name="pass" id="password" onkeyup="checkCurrentPass()" required />
                    <label for="">Mật khẩu hiện tại</label>
                </div>

                <div style=" margin-bottom: 10px"><p id="wrongPassNew" style="display: none; color: red;">
                        Mật khẩu mới không trùng khớp
                    </p></div>

                <div class="form-group">
                    <input type="password" name="newPass" id="newPass" oninput="checkLengthNewPass()" required />
                    <label for="">Mật khẩu mới</label>
                </div>

                <div class="form-group">
                    <input type="password" id="confirmPassword" onkeyup="checkPass()"/>
                    <label for="">Nhập lại mật khẩu mới</label>
                </div>


                <p id="capslock-warning" style="display: none; margin-bottom: 30px">⚠️ Caps Lock is on</p>
                <div id="errorPass" style="color: red; display: none;">Password must more than 6 characters</div>
                <div class="button">
                    <input id="submit" type="submit" value="Đổi mật khẩu" /><br /><br />
                </div>
            </form>
        </div>
        <script>
            var p = document.getElementById("password");
            var pn = document.getElementById("passNew");
            var sp = document.getElementById("currentPassword");
            var cp = document.getElementById("confirmPassword");
            var submit = document.getElementById("submit");
            var wrongPass = document.getElementById("wrongPassNew");
            var wrongCurrentPass = document.getElementById("wrongCurrentPass");
            var text = document.getElementById("capslock-warning");

            function CapsCheck(event) {
                if (event.getModifierState("CapsLock")) {
                    text.style.display = "block";
                } else {
                    text.style.display = "none";
                }
            }

            p.addEventListener("keyup", CapsCheck);
            pn.addEventListener("keyup", CapsCheck);
            cp.addEventListener("keyup", CapsCheck);

            function checkPass() {
                if (pn.value !== cp.value) {
                    submit.disabled = true;
                    cp.style.border = "2px solid red";
                    wrongPass.style.display = "inline";
                } else {
                    submit.disabled = false;
                    cp.style.border = "2px solid green";
                    wrongPass.style.display = "none";
                }
            }
            
            function checkLengthNewPass() {
                var newPass = document.getElementById("newPass").value;
                var errorPass = document.getElementById("errorPass");
                if (newPass.length < 6) {
                    errorPass.style.display = "inline";
                    submit.disabled = true;
                } else {
                    errorPass.style.display = "none";
                    submit.disabled = false;
                }
            }
            function checkCurrentPass() {
                if (p.value !== sp.value) {
                    submit.disabled = true;
                    sp.style.border = "2px solid red";
                    wrongCurrentPass.style.display = "inline";
                } else {
                    submit.disabled = false;
                    sp.style.border = "2px solid green";
                    wrongCurrentPass.style.display = "none";
                }
            }
        </script>
    </body>
</html> 