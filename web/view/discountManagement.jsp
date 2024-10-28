<%-- 
    Document   : discountManagement
    Created on : Oct 19, 2024, 3:43:59 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Discount"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/styleAdminController.css"/>
        <title>JSP Page</title>
        <style>
            :root {
                --flyezyMainColor: rgb(60, 110, 87);
            }

            table.entity {
                border-collapse: collapse;
                border: 1px solid #ddd;
                font-family: Arial, sans-serif;
            }

            table.entity thead {
                background-color: #f2f2f2;
            }

            table.entity th,
            table.entity td {
                border: 1px solid #ddd;
                padding: 6px;
                text-align: center;
                padding-top: 10px;
                padding-bottom: 10px;
                word-wrap: break-word;
                font-size: 14px;
            }

            table.entity th {
                background-color: var(--flyezyMainColor);
                color: white;
            }

            table.entity td img {
                height: 80px;
                width: 80px;
                object-fit: cover;
            }

            table.entity td a {
                text-decoration: none;
                margin-right: 10px;
            }

            table.entity td a:hover {
                text-decoration: underline;
            }


            .filterController{
                font-size: 14px;
                float:left
            }

            .filterController button{
                padding: 6px;
            }

            .filterElm{
                margin-right: 15px;
                padding: 0.3%;
            }

            .box {
                margin: 100px auto;
                box-shadow: 0 0 5px 0 rgba(0, 0, 0, 0.1), 0 0 1px 0 rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                padding: 35px !important;
                font-size: 16px;
                width: max-content;
            }

            .editor{
                padding-left: 20px;
            }



        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>
        <div style="display: flex; margin-left: 400px;margin-top: 100px">
            <button type="button" class="btn btn-success" data-toggle="modal" >Add New Discount</button>
        </div>
        <table class="entity" style="margin-left: 210px; margin-top: 100px" border="1" >
            <thead>
                <tr>
                    <th>ID</th>
                    <th>percentage</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <%
        List<Discount> ls = (List<Discount>) request.getAttribute("discountlist");
        for(Discount discount : ls){
            %>
            <tbody>
                <tr>

                    <td><%= discount.getId()%></td>
                    <td><%= discount.getPercentage() %></td>
                    <td>Activated</td>
                    <td>
                        <button>update</button>
                        <button>delete</button>
                    </td>
                </tr>
            </tbody>
            <%}%>
    </body>
</table>
</html>
