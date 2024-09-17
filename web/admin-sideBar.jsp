<%-- Document : admin-sideBar Created on : May 19, 2024, 1:49:43 PM Author :
Admin --%> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/styleAdminSideBar.css" />
    </head>
    <body>
        <% String currentPage = request.getRequestURI(); %>
        <div id="sidebar">
            <ul>
                <li>
                    <a href="accountController" class="<%= currentPage.equals("/flyezy/admin.jsp") ? "current-page" : "" %>">
                        Quản lý tài khoản 
                    </a>
                        <a href="airlineController" class="<%= currentPage.equals("/flyezy/airline.jsp") ? "current-page" : "" %>">
                        Quản lý hãng hàng không
                    </a>
                </li>
                
            </ul>
        </div>
    </body>
</html>
