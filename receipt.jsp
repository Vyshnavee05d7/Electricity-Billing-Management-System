<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.time.format.DateTimeFormatter" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.html");
        return;
    }

    String username = request.getParameter("username");
    String dbUrl = "jdbc:mysql://localhost:3306/ElectricityBillingSystem";
    String dbUser = "root";
    String dbPassword = "root";

    String amount = "";
    String paymentMode = "";
    Timestamp paymentDate = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        String sql = "SELECT amount, payment_date, payment_mode FROM receipts WHERE username = ? ORDER BY payment_date DESC LIMIT 1";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            amount = rs.getString("amount");
            paymentDate = rs.getTimestamp("payment_date");
            paymentMode = rs.getString("payment_mode");
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receipt</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="my-4">Payment Receipt</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Amount Paid</th>
                    <th>Payment Date</th>
                    <th>Payment Mode</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= username %></td>
                    <td>₹<%= amount %></td>
                    <td><%= paymentDate.toLocalDateTime().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss")) %></td>
                    <td><%= paymentMode %></td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
