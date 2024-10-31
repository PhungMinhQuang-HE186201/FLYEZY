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
                    <a href="accountController" class="<%= currentPage.equals("/flyezy/view/accountController.jsp") ? "current-page" : "" %>">
                        Account Management
                    </a>
                </li>
                <li>
                    <a href="airlineController" class="<%= currentPage.equals("/flyezy/view/airlineManagement.jsp") ? "current-page" : "" %>">
                        Airline Management
                    </a>
                </li>
                <li>
                    <a href="planeCategoryController" class="<%= currentPage.equals("/flyezy/view/planeCategoryController.jsp") ? "current-page" : "" %>">
                        Plane Category Management
                    </a>
                </li>
                <li>
                    <a href="flightManagement" class="<%= currentPage.equals("/flyezy/view/flightManagement.jsp") ? "current-page" : "" %>">
                        Flight Management
                    </a>
                </li>
                <li>
                    <a href="discountManagement" class="<%= currentPage.equals("/flyezy/view/discountManagement.jsp") ? "current-page" : "" %>">
                        Discount Management
                    </a>
                </li>

            </ul>
        </div>
    </body>
</html>
