<%-- 
    Document   : flightdetailQuanHT
    Created on : Sep 29, 2024, 10:06:05 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>

    </head>
    <body>
        <div style="display: flex; margin-bottom: 20px">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#add-<%=rsFlightManage.getInt(1)%>">Add New Flight Detail</button>
        </div>
        <table class="entity" >
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Price</th>
                    <th>Plane Category</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                PlaneCategoryDAO planeCategoryDAO =  new PlaneCategoryDAO();
                List<PlaneCategory> categories = (List<PlaneCategory>) planeCategoryDAO.getAllCategories();
                %>
                <%
                    int flightIdFromDb = 0;
                    flightIdFromDb = rsFlightManage.getInt(1); 
                    List<FlightDetails> listFlightDetails = (List<FlightDetails>) request.getAttribute("listFlightDetails");
                    if (listFlightDetails != null) {
                        for (FlightDetails fd : listFlightDetails) {
                            if (fd.getFlightId() == flightIdFromDb) {
                                // Lấy tên PlaneCategory từ DAO
                                String planeCategoryName = planeCategoryDAO.getNameById(fd.getPlaneCategoryId());
                %>
                <tr>

                    <td><%= fd.getDate() %></td>
                    <td><%= fd.getTime() %></td>
                    <td><%= fd.getPrice() %></td>
                    <td>
                        <%= planeCategoryName %>
                    </td>
                    <td>
                        <select name="status" onchange="submitForm(<%= fd.getId() %>, this.value)">
                            <option value="3" <%= fd.getStatusId() == 3 ? "selected" : "" %>>Pre-Flight</option>
                            <option value="4" <%= fd.getStatusId() == 4 ? "selected" : "" %>>In-Flight</option>
                            <option value="5" <%= fd.getStatusId() == 5 ? "selected" : "" %>>On-Land</option>
                        </select>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#update-<%=fd.getId()%>">
                            Update
                        </button>
                            <a class="btn btn-danger" style="text-decoration: none; background-color: green;" href="FlightDetailManage?action=changeDetail&flightDetailID=<%= fd.getId() %>">Detail</a>
                    </td>
                </tr>

                <!--confirm modal btn3-->
            <div class="modal" id="confirmModal-<%= fd.getId() %>">
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
                            <button type="button" class="btn btn-primary confirmChange" data-modal-id="<%= fd.getId() %>">Confirm</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal update flight details -->
            <div class="modal fade" id="update-<%=fd.getId()%>" tabindex="-1" aria-labelledby="updateFlightModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="updateFlightModalLabel">Update Flight Detail</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="updateFlightForm" method="post" action="FlightDetailManage?action=update">
                                <input type="hidden" id="uid" name="id" value="<%=fd.getId()%>">
                                <div class="mb-3">
                                    <label for="flightDate" class="form-label">Date: </label>
                                    <input type="date" class="form-control" id="uflightDate" name="date" value=<%= fd.getDate()%> required>
                                </div>
                                <div class="mb-3">
                                    <label for="flightTime" class="form-label">Time: </label>
                                    <input id="utime" type="time" name="time" value="<%= fd.getTime() %>" step="1" required>
                                </div>
                                <div class="mb-3">
                                    <label for="flightPrice" class="form-label">Price: </label>
                                    <input type="number" class="form-control" id="uflightPrice" name="price" value="<%= fd.getPrice() %>" required>
                                </div>
                                <div class="mb-3">
                                    <label for="flightId" class="form-label">Flight ID: </label>
                                    <input type="number" class="form-control" id="uFlightId" name="flightId" value="<%= fd.getFlightId() %>" required="">
                                </div>
                                <div class="mb-3">
                                    <label for="planeCategoryId" class="form-label">Plane Category: </label>
                                    <select name="planeCategoryId">
                                        <%
                                            for (PlaneCategory category : categories) {
                                        %>
                                        <option value="<%=category.getId()%>"><%=category.getName()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Update Flight</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <%
                   }
               }
           }
            %>


        </tbody>
    </table>
    <!-- Modal to Add Flight Detail -->
    <div class="modal fade" id="add-<%=rsFlightManage.getInt(1)%>" tabindex="-1" role="dialog" aria-labelledby="addFlightDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addFlightDetailModalLabel">Add New Flight Detail</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form action="FlightDetailManage" method="POST">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="date">Date:</label>
                            <input type="date" class="form-control" id="date" name="date" required>
                        </div>
                        <div class="form-group">
                            <label for="time">Time:</label>
                            <input id="time" type="time" name="time" step="1" required>

                        </div>
                        <div class="form-group">
                            <label for="price">Price:</label>
                            <input type="number" class="form-control" id="price" name="price" required>
                        </div>
                        <div class="form-group">
                            <input type="hidden" class="form-control" id="flightId" name="flightId" value="<%= flightIdFromDb %>">
                        </div>
                        <div class="form-group">
                            <label for="planeCategoryId" class="form-label">Plane Category: </label>
                            <select name="planeCategoryId">
                                <%
                                    for (PlaneCategory category : categories) {
                                %>
                                <option value="<%=category.getId()%>"><%=category.getName()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" name="action" value="add" class="btn btn-primary">Add Flight Detail</button>
                    </div>
                </form>
            </div>
        </div>
    </div>




    <script>
        let currentId = null;
        let currentStatus = null;

        function submitForm(id, status) {
            currentId = id;
            currentStatus = status;
            $('#confirmModal-' + currentId).modal('show');
        }

        document.addEventListener('click', function (event) {
            // Check if the clicked element is the confirm button
            if (event.target && event.target.classList.contains('confirmChange')) {
                // Get the current modal ID from the button
                var modalId = event.target.getAttribute('data-modal-id');

                // Create the form dynamically
                const form = document.createElement("form");
                form.method = "post";
                form.action = "FlightDetailManage?action=updstatus";

                const idInput = document.createElement("input");
                idInput.type = "hidden";
                idInput.name = "id";
                idInput.value = currentId;

                const statusInput = document.createElement("input");
                statusInput.type = "hidden";
                statusInput.name = "status";
                statusInput.value = currentStatus;

                form.appendChild(idInput);
                form.appendChild(statusInput);

                document.body.appendChild(form);
                form.submit();

                $('#confirmModal-' + modalId).modal('hide');
            }
        });
    </script>
</body>
</html>
