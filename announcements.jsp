<%@ page import="java.sql.*,java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Announcements - Electricity Billing Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f8ff;
            font-family: 'Arial', sans-serif;
        }
        .navbar {
            background-color: #007bff;
            padding: 10px 20px;
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
            transition: background-color 0.3s ease;
        }
        .navbar-nav .nav-link:hover {
            background-color: #0056b3;
        }
        .container {
            background-color: #ffffff;
            border: 2px solid #007bff;
            border-radius: 10px;
            padding: 30px;
            margin-top: 20px;
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
            animation: fadeIn 1s ease-in-out;
        }
        .card {
            animation: fadeIn 1.5s ease-in-out;
            transition: transform 0.3s ease-in-out;
        }
        .card:hover {
            transform: scale(1.02);
        }
        .card-footer {
            background-color: transparent;
            border-top: none;
            color: #6c757d;
        }
        .card-text {
            font-size: 1.2em; /* Increase font size */
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
        <h2 class="my-4">Announcements</h2>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ElectricityBillingSystem", "root", "root");
                Statement stmt = conn.createStatement();
                String sql = "SELECT * FROM news ORDER BY posted_at DESC";
                ResultSet rs = stmt.executeQuery(sql);
                while (rs.next()) {
                    String content = rs.getString("content");
                    Timestamp postedAt = rs.getTimestamp("posted_at");
        %>
                <div class="card mb-4">
                    <div class="card-body">
                        <p class="card-text"><%= content %></p>
                        <footer class="blockquote-footer card-footer">Posted on <%= postedAt %></footer>
                    </div>
                </div>
        <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        <a href="dashboard.jsp" class="btn btn-primary mt-4">Back to Dashboard</a>
    </div>
</body>
</html>
