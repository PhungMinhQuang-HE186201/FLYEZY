<%-- 
    Document   : orderManagement
    Created on : Oct 12, 2024, 11:08:48 AM
    Author     : PMQUANG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.FlightDetails"%>
<%@page import="dal.OrderDAO"%>
<%@page import="dal.FlightDetailDAO"%>
<%@page import="dal.AccountsDAO"%>
<%@page import="dal.PaymentTypeDAO"%>
<%@page import="dal.FlightTypeDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Flights"%>
<%@page import="model.Order"%>
<%@page import="model.Accounts"%>
<%@page import="model.PaymentType"%>
<%@page import="model.FlightType"%>
<%@page import="model.Status"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="../css/styleAdminController.css"/>
        <link rel="shortcut icon" type="image/png" href="img/flyezy-logo3.png" />
        <link rel="stylesheet" href="css/styleAdminController.css">
        <link rel="stylesheet" href="css/styleFlightManagement.css">
        <link rel="stylesheet" href="css/styleToastNotification.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="admin-sideBar.jsp" %>
        <div id="back" style="margin-left: 210px;margin-top: 60px;margin-bottom: -100px " /> 
        <a href="flightDetailManagement?flightId=${requestScope.flight.getId()}&airlineId=${requestScope.airlineId}" class="btn btn-warning" >Back</a>
        <input type="hidden" name="flightDetailID">

        <table class="entity" style="margin-left: 210px;" >
            <thead>
                <tr>
                    <th>Code</th>
                    <th>Contact Name</th>
                    <th>Contact Phone</th>
                    <th>Contact Mail</th>
                    <th>Total Price</th>
                    <th>Account</th>
                    <th>Payment Type</th>
                    <th>Flight Type</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                        
                    OrderDAO od = new OrderDAO();
                    AccountsDAO ad = new AccountsDAO();
                    PaymentTypeDAO ptd = new PaymentTypeDAO();
                    FlightTypeDAO ftd = new FlightTypeDAO();
                    List<Order> listOrder = (List<Order>)request.getAttribute("listOrder");
                    List<Accounts> listAcc = ad.getAllAccounts();
                        
                    if(listOrder != null){
                        for(Order o : listOrder){
                            
                        
                %>
                <tr>
                    <td><%=o.getCode()%></td>
                    <td><%=o.getContactName()%></td>
                    <td><%=o.getContactPhone()%></td>
                    <td><%=o.getContactEmail()%></td>
                    <td><%=o.getTotalPrice()%></td>
                    <%for(Accounts acc : listAcc){
                            if(acc.getId() == o.getAccountsId()){%>
                    <td><%=acc.getName()%></td>
                    <%
                        }
                    }
                    %>
                    <%String paymentName = ptd.getPaymentTypeNameById(o.getPaymentTypesId());%>
                    <td><%=paymentName%></td>
                    <%String flightTypeName = ftd.getNameType(o.getFlightTypeId());%>
                    <td><%=flightTypeName%></td>
                    <td>
                        <select name="status" id="status-<%= o.getId() %>" onchange="submitForm(<%= o.getId() %>, <%= o.getFlightDetailId() %>, this.value); changeColor(this)" style="color: black;">
                            <option value="" disabled selected hidden>Select Status</option> <!-- Add a default option -->
                            <option value="9" style="background-color: white; color: black;" <%= o.getStatus_id() == 9 ? "selected" : "" %>>Empty</option>
                            <option value="10" style="background-color: green; color: white;" <%= o.getStatus_id() == 10 ? "selected" : "" %>>Successful Payment</option>
                            <option value="11" style="background-color: red; color: white;" <%= o.getStatus_id() == 11 ? "selected" : "" %>>Cancellation Rejection</option>
                        </select>

                    </td>
                </tr>
                <!--confirm modal btn3-->
            <div class="modal" id="confirmModal-<%= o.getId() %>">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Confirm Change</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to change the flight status?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary confirmChange" data-modal-id="<%= o.getId() %>">Confirm</button>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            }
            %>
        </tbody>
    </table>
    <script>
        let currentId = null;
        let currentFlightDetailId = null;
        let currentStatus = null;

        function submitForm(orderId, flightDetailId, status) {
            currentId = orderId;
            currentFlightDetailId = flightDetailId;
            currentStatus = status;

            console.log("Order ID: " + currentId); // Debugging
            console.log("Flight Detail ID: " + currentFlightDetailId); // Debugging
            console.log("Status: " + currentStatus); // Debugging

            $('#confirmModal-' + currentId).modal('show'); // Show the modal for confirmation
        }

        document.addEventListener('click', function (event) {
            if (event.target && event.target.classList.contains('confirmChange')) {
                const form = document.createElement("form");
                form.method = "post";
                form.action = "OrderController?action=updateStatus";

                const idInput = document.createElement("input");
                idInput.type = "hidden";
                idInput.name = "orderId";
                idInput.value = currentId;

                const flightDetailIdInput = document.createElement("input");
                flightDetailIdInput.type = "hidden";
                flightDetailIdInput.name = "flightDetailId";
                flightDetailIdInput.value = currentFlightDetailId;

                const statusInput = document.createElement("input");
                statusInput.type = "hidden";
                statusInput.name = "statusId";
                statusInput.value = currentStatus;

                form.appendChild(idInput);
                form.appendChild(flightDetailIdInput);
                form.appendChild(statusInput);

                document.body.appendChild(form);
                form.submit();

                $('#confirmModal-' + currentId).modal('hide');
            }
        });
        function changeColor(selectElement) {
            // Get the selected value
            const selectedValue = selectElement.value;

            // Reset the styles when no option is selected
            if (selectedValue === "") {
                selectElement.style.backgroundColor = "white";
                selectElement.style.color = "black";
            } else {
                

                // Change the background based on the selected value
                if (selectedValue == "9") {
                    selectElement.style.backgroundColor = "white";
                } else if (selectedValue == "10") {
                    selectElement.style.backgroundColor = "green";
                    selectElement.style.color = "white";  // Set text color to white
                } else if (selectedValue == "11") {
                    selectElement.style.backgroundColor = "red";
                    selectElement.style.color = "white";  // Set text color to white
                }
            }
        }

        // Apply the initial color based on the pre-selected value when the page loads
        document.addEventListener('DOMContentLoaded', function () {
            const selectElements = document.querySelectorAll('select[name="status"]');
            selectElements.forEach(function (selectElement) {
                changeColor(selectElement); // Apply color for pre-selected status
            });
        });

    </script>
</body>
</html>
