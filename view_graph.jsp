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

    // Variables to hold usage data
    int peakHours = 0;
    int offPeakHours = 0;
    int midPeakHours = 0;
    int superOffPeakHours = 0;

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
            peakHours = Integer.parseInt(rs.getString("peak_hours"));
            offPeakHours = Integer.parseInt(rs.getString("off_peak_hours"));
            midPeakHours = Integer.parseInt(rs.getString("mid_peak_hours"));
            superOffPeakHours = Integer.parseInt(rs.getString("super_off_peak_hours"));
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        response.getWriter().println("Error: " + e.getMessage());
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Graph - Electricity Usage</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background-color: #f0f8ff;
            font-family: 'Arial', sans-serif;
        }
        .navbar {
            background-color: #007bff;
            padding: 10px 20px;
            border-bottom: 2px solid #0056b3;
        }
        .navbar-brand {
            color: white;
            font-size: 24px;
            font-weight: bold;
            display: flex;
            align-items: center;
        }
        .navbar-brand svg {
            margin-right: 10px;
        }
        .navbar-brand:hover {
            color: white;
        }
        .navbar-nav .nav-link {
            color: white;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .navbar-nav .nav-link:hover {
            background-color: #0056b3;
            transform: scale(1.05);
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
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: bold;
            animation: fadeIn 1s ease-in-out;
        }
        .btn {
            background-color: #007bff;
            border: none;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .btn:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }
        .btn-primary.mt-4 {
            display: block;
            margin: 0 auto;
            animation: fadeIn 2s ease-in-out;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <a class="navbar-brand" href="#">
            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="white" class="bi bi-lightning-fill" viewBox="0 0 16 16">
                <path d="M11.3 1L1 8.4c-.6.4-.4 1.3.3 1.3h5.4L4.6 15c-.4.6.4 1.2 1 1L15 8.6c.6-.4.4-1.3-.3-1.3H9.3L11.3 1c.4-.6-.4-1.2-1-1H6.6L11.3 1z"/>
            </svg>
            Vidyuth
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="dashboard.jsp">Go to Dashboard</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <h2>Electricity Usage Graph</h2>
        <canvas id="usageChart"></canvas>
        <a href="dashboard.jsp" class="btn btn-primary mt-4">Back to Dashboard</a>
    </div>

    <script>
        const ctx = document.getElementById('usageChart').getContext('2d');
        const usageChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Peak Hours', 'Off-Peak Hours', 'Mid-Peak Hours', 'Super Off-Peak Hours'],
                datasets: [{
                    label: 'Electricity Usage (kWh)',
                    data: [<%= peakHours %>, <%= offPeakHours %>, <%= midPeakHours %>, <%= superOffPeakHours %>],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
