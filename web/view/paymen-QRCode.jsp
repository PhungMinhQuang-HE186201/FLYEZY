<%-- 
    Document   : paymen-QRCode
    Created on : Jul 2, 2024, 9:16:33 AM
    Author     : admin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QR Code Payment</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                background-color: #fff;
                padding: 50px;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                border-radius: 12px;
                max-width: 1000px;
                width: 100%;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 30px;
            }
            img {
                width: 325px;
                height: 325px;
                display: block;
                margin: 0 auto;
            }
            td {
                padding: 30px;
                vertical-align: top;
                font-size: 22px;
            }
            .details {
                padding-left: 30px;
            }
            .details p {
                margin: 0 0 20px;
            }
            .submit-btn {
                display: block;
                width: 100%;
                padding: 20px;
                background-color: #28a745;
                color: #fff;
                border: none;
                border-radius: 8px;
                font-size: 24px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .submit-btn:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <form action="QRCodeController" method="get">
                <table>
                    <tr>
                        <td>
                            <img src="<c:url value='/img/QRCode.jpg'/>" alt="QRCode"/>
                        </td>
                        <td class="details">
                            <p>Transfer content: <b>${phone} ${email}</b></p>
                            <p>Transfer amount: <b>${totalCost}VND</b></p>
                            <p><i>Transfer time within 24 hours. 
                               If after 24 hours you do not receive transfer information, the order will be canceled.</i></p>
                        </td>
                    </tr>
                </table>
                <input type="submit" value="Confirm transfer" class="submit-btn">
            </form>
        </div>
    </body>
</html>
