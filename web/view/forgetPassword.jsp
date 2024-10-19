<%-- Document : register Created on : May 12, 2024, 5:49:30 PM Author : Admin
--%> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Register</title>
        <link rel="shortcut icon" type="image/jpg" href="image/logo-icon.png" />
        <link rel="stylesheet" href="css/styleLoginAndRegister.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <link rel="stylesheet" href="icon/themify-icons/themify-icons.css" />
    </head>
    <body>
        <div class="container">
            <h1 style="margin-bottom: 30px">
                Đặt lại mật khẩu<a
                    style="
                    float: right;
                    font-size: 25px;
                    margin-top: 8px;
                    text-decoration: none;
                    color: rgb(71, 143, 192);
                    "
                    href="home"
                    ><i class="ti-home"></i
                    ></a>
            </h1>

            <div>
                <a href="home" style="position: relative; left: -30px; top: -99px; transition: none; cursor: move;">
                    <i style="font-size: 20px;color: #3c6e57;" class="bi bi-arrow-90deg-left"></i>
                </a>
            </div>
            <form action="ForgetPassword" method="post">
                <div class="form-group">
                    <input type="email" name="email" required />
                    <label for="">Email của bạn</label>

                </div>
                <p id="capslock-warning" style="display: none; margin-bottom: 30px">⚠️ Caps Lock is on</p>
                <h5 style="color: red">${requestScope.error}</h5><br>
                <div class="button">
                    <input id="submit" type="submit" value="Nhận email" /><br /><br />
                </div>
                Bạn đã nhớ ra mật khẩu? <a class="letDoIt" href="login">Đăng nhập</a>
            </form>
        </div>
        <script>
            var p = document.getElementById("password");
            var cp = document.getElementById("confirmPassword");
            var text = document.getElementById("capslock-warning");

            function CapsCheck(event) {
                if (event.getModifierState("CapsLock")) {
                    text.style.display = "block";
                } else {
                    text.style.display = "none";
                }
            }

            p.addEventListener("keyup", CapsCheck);
            cp.addEventListener("keyup", CapsCheck);

        </script>

    </body>
</html>
