<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .navbar {
            background-color: #007bff; /* Blue color for the navbar */
            color: white;
            padding: 15px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }
        .navbar .logo {
            display: flex;
            align-items: center;
        }
        .navbar .logo img {
            height: 40px;
            width: auto;
            margin-right: 10px;
        }
        .navbar .logo span {
            font-size: 24px;
            font-weight: bold;
            color: white; /* White color for the Vidyuth text */
        }
        .navbar a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            padding: 10px 15px;
            border-radius: 5px;
            background-color: rgba(0, 123, 255, 0.7); /* Semi-transparent background */
            transition: background-color 0.3s;
        }
        .navbar a:hover {
            background-color: rgba(0, 123, 255, 1); /* Solid color on hover */
        }
        .container {
            margin-top: 80px; /* Space for fixed navbar */
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }
        h1.text-center {
            text-align: center;
            color: #333;
        }
        .profile-info {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 12px; /* Rounded edges for the table */
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin: 20px 0;
            transition: transform 0.3s, box-shadow 0.3s;
            max-width: 600px; /* Limit table width */
            margin-left: auto;
            margin-right: auto;
        }
        .profile-info:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        td {
            color: #555;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <div class="logo">
            <img src="logo.png"> <!-- Replace with Vidyuth logo image path -->
            <span>Vidyuth</span>
        </div>
        <a href="dashboard.jsp">Go to Dashboard</a>
    </div>

    <!-- Profile Content -->
    <div class="container">
        <h1 class="text-center">User Profile</h1>

        <%
            // Retrieve user details from session
            HttpSession userSession = request.getSession(false);
            if (userSession == null) {
                out.println("Session not found. Please log in.");
                response.sendRedirect("login.html");
                return;
            }

            String username = (String) userSession.getAttribute("username");
            String email = (String) userSession.getAttribute("email");
            String phoneNumber = (String) userSession.getAttribute("phone_number");
            String serviceNumber = (String) userSession.getAttribute("service_number");

            if (username == null) {
                out.println("User not found in session. Please log in.");
                response.sendRedirect("login.html");
                return;
            }
        %>

        <!-- User Information Table -->
        <div class="profile-info">
            <table>
                <tr>
                    <th>Attribute</th>
                    <th>Value</th>
                </tr>
                <tr>
                    <td>Username</td>
                    <td><%= username %></td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td><%= email %></td>
                </tr>
                <tr>
                    <td>Phone Number</td>
                    <td><%= phoneNumber %></td>
                </tr>
                <tr>
                    <td>Service Number</td>
                    <td><%= serviceNumber %></td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
