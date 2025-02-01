<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    // Retrieve session attribute directly without declaring a new session variable
    String username = (String) request.getSession().getAttribute("username");

    // Check if username is null (i.e., user is not logged in)
    if (username == null) {
        response.sendRedirect("login.html");
        return;
    }

    // JDBC driver and database URL
    String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    String DB_URL = "jdbc:mysql://localhost:3306/ElectricityBillingSystem";
    String USER = "root";
    String PASS = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Usage of Electricity</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .navbar {
            background-color: #007bff;
        }
        .navbar-brand {
            color: #ffffff;
            font-size: 1.5rem;
            font-weight: bold;
        }
        .navbar-brand svg {
            width: 1.5em;
            height: 1.5em;
            vertical-align: middle;
            fill: #ffffff;
        }
        .navbar-nav .nav-link {
            color: #ffffff !important;
            font-weight: bold;
        }
        .navbar-nav .nav-link:hover {
            color: #e2e6ea !important;
        }
        .navbar-nav .nav-item {
            margin-left: 15px;
        }
        .container {
            background-color: #ffffff;
            border: 2px solid #007bff;
            border-radius: 10px;
            padding: 30px;
            margin-top: 50px;
            box-shadow: 0 0 15px rgba(0, 123, 255, 0.3);
            transition: transform 0.3s ease-in-out;
        }
        .container:hover {
            transform: scale(1.02);
        }
        h2 {
            color: #007bff;
            text-align: center;
            margin-bottom: 30px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .table {
            margin: 0 auto;
            max-width: 800px;
        }
        .table thead th {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #007bff;
            color: #ffffff;
            text-align: center;
        }
        .table tbody td {
            font-family: 'Arial', sans-serif;
            text-align: center;
        }
        .btn-go-dashboard {
            background-color: #0056b3;
            color: #ffffff;
            border: none;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .btn-go-dashboard:hover {
            background-color: #003d7a;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="#">
            <svg viewBox="0 0 24 24"><path d="M12 0L10 8H7L10 15H9L5 21L11 17H10L13 10H16L14 0H12z"></path></svg>
            Vidyuth
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link btn-go-dashboard" href="dashboard.jsp">Go to Dashboard</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <h2>User Usage of Electricity</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Type</th>
                    <th>Usage (kWh)</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        // Load JDBC driver
                        Class.forName(JDBC_DRIVER);

                        // Establish connection
                        conn = DriverManager.getConnection(DB_URL, USER, PASS);

                        // Query to get user usage data
                        String sql = "SELECT peak_hours, off_peak_hours, mid_peak_hours, super_off_peak_hours FROM users WHERE username = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, username);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            out.println("<tr><td>Peak Hours</td><td>" + rs.getString("peak_hours") + "</td></tr>");
                            out.println("<tr><td>Off-Peak Hours</td><td>" + rs.getString("off_peak_hours") + "</td></tr>");
                            out.println("<tr><td>Mid-Peak Hours</td><td>" + rs.getString("mid_peak_hours") + "</td></tr>");
                            out.println("<tr><td>Super Off-Peak Hours</td><td>" + rs.getString("super_off_peak_hours") + "</td></tr>");
                        } else {
                            out.println("<tr><td colspan='2'>No data available</td></tr>");
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='2'>Error retrieving data</td></tr>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException se) {
                            se.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
