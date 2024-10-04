<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Flight Management</title>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

    </head>
    <body>
        <h1>${requestScope.result}</h1>
        <form action="flightTickets">
            <input type="number" name="departureAirport"/>
            <input type="number" name="destinationAirport"/>
            <input type="date" name="departureDate"/>
            <input type="submit" value="OK"/>
        </form>
    </body>

    <script>
        toastr.options = {
            "closeButton": true,
            "debug": false,
            "newestOnTop": false,
            "progressBar": true,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "3500",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };

        function successful(message) {
            toastr["success"](message, "Successful");
        };
        
        $(document).ready(function() {
            <% if (request.getAttribute("result") != null) { %>
                successful("Add successful");
            <% } %>
        });
    </script>


</html>