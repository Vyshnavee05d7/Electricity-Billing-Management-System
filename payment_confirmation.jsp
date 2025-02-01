<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("username") == null) {
        response.sendRedirect("login.html");
        return;
    }

    String username = request.getParameter("username");
    double amount = Double.parseDouble(request.getParameter("amount"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Confirmation</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="my-4">Payment Confirmation</h2>
        <p>Thank you, <%= username %>. Your payment of ₹<%= amount %> has been processed successfully.</p>
        <a href="view_bill.jsp" class="btn btn-primary">Back to Billing Page</a>
    </div>
</body>
</html>
