<%@ page import="java.sql.*,java.util.*" %>
<%@ page session="true" %>
<%
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("admin_login.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f5f5f5;
        }
        .container {
            border: 2px solid #007bff;
            border-radius: 10px;
            padding: 20px;
            background-color: #ffffff;
            transition: all 0.3s ease-in-out;
        }
        .container:hover {
            box-shadow: 0 0 20px rgba(0, 123, 255, 0.7);
        }
        .navbar {
            background-color: #007bff;
        }
        .navbar-brand {
            color: #ffffff !important;
            font-weight: bold;
            display: flex;
            align-items: center;
        }
        .navbar-brand svg {
            margin-left: 5px;
        }
        .navbar-nav .nav-item .nav-link {
            color: #ffffff !important;
            transition: color 0.3s ease;
        }
        .nav-item:hover .nav-link {
            color: #d4d4d4 !important;
        }
        .card {
            border: 1px solid #007bff;
            transition: box-shadow 0.3s ease-in-out;
        }
        .card:hover {
            box-shadow: 0 0 15px rgba(0, 123, 255, 0.5);
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <a class="navbar-brand" href="#">
            Vidyuth 
            <svg width="24" height="24" fill="currentColor" class="bi bi-lightning" viewBox="0 0 16 16">
                <path d="M11.3 1H6.7L2 8h3.4l-1.2 7 6.3-9H7.2L11.3 1z"/>
            </svg>
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.html">Logout</a>
                </li>
            </ul>
        </div>
    </nav>
    <div class="container mt-5">
        <h1 class="mt-5">Admin Dashboard</h1>
        <div class="mt-4">
            <h3>Post News</h3>
            <form action="PostNewsServlet" method="post">
                <div class="form-group">
                    <label for="news">News Content</label>
                    <textarea class="form-control" id="news" name="news" rows="5" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Post News</button>
            </form>
        </div>
        <div class="mt-4">
            <h3>User Feedback</h3>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ElectricityBillingSystem", "root", "root");
                    Statement stmt = conn.createStatement();
                    String sql = "SELECT * FROM feedback ORDER BY created_at DESC";
                    ResultSet rs = stmt.executeQuery(sql);
                    while (rs.next()) {
                        String feedback = rs.getString("feedback");
                        Timestamp createdAt = rs.getTimestamp("created_at");
            %>
                        <div class="card mt-3">
                            <div class="card-body">
                                <p class="card-text"><%= feedback %></p>
                                <footer class="blockquote-footer">Submitted on <%= createdAt %></footer>
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
        </div>
    </div>
</body>
</html>
