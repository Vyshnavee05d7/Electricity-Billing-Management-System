<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("username") == null) {
        response.sendRedirect("login.html");
        return;
    }

    String username = (String) userSession.getAttribute("username");
    String dbUrl = "jdbc:mysql://localhost:3306/ElectricityBillingSystem";
    String dbUser = "root";
    String dbPassword = "root";

    double peakRate = 7.50;
    double midPeakRate = 5.00;
    double offPeakRate = 3.00;
    double superOffPeakRate = 2.00;

    String status = null;
    double peakHours = 0;
    double midPeakHours = 0;
    double offPeakHours = 0;
    double superOffPeakHours = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        String sql = "SELECT peak_hours, mid_peak_hours, off_peak_hours, super_off_peak_hours, status FROM users WHERE username = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            peakHours = rs.getDouble("peak_hours");
            midPeakHours = rs.getDouble("mid_peak_hours");
            offPeakHours = rs.getDouble("off_peak_hours");
            superOffPeakHours = rs.getDouble("super_off_peak_hours");
            status = rs.getString("status");
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    double billAmount = (peakHours * peakRate) + (midPeakHours * midPeakRate) + (offPeakHours * offPeakRate) + (superOffPeakHours * superOffPeakRate);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bill</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .navbar {
            background-color: #007bff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease;
        }
        .navbar-brand {
            color: #ffffff;
            font-size: 1.5rem;
            font-weight: bold;
            transition: color 0.3s ease;
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
            transition: all 0.3s ease;
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
        .table tbody tr:hover {
            background-color: #f1f1f1;
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
        .paid-message {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #ffffff;
            background-color: #0056b3;
            font-size: 1.2rem;
            text-align: center;
            margin-top: 20px;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
    </style>
    <script>
        function printReceipt() {
            // Open a new window for printing
            var printWindow = window.open('', '', 'height=600,width=800');
            var paperSize = document.querySelector('input[name="paperSize"]:checked').value;
            var orientation = document.querySelector('input[name="orientation"]:checked').value;
            
            // Prepare print settings
            var printStyles = `
                <style>
                    @media print {
                        @page {
                            size: ${paperSize} ${orientation};
                            margin: 1in;
                        }
                        body {
                            -webkit-print-color-adjust: exact;
                        }
                    }
                </style>
            `;
            
            printWindow.document.write('<html><head><title>Print Receipt</title>' + printStyles + '</head><body>');
            printWindow.document.write(document.getElementById('printableArea').innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
        }
    </script>
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
        <h2>Your Bill</h2>
        <div id="printableArea"> 
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Details</th>
                        <th>Information</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Username</td>
                        <td><%= username %></td>
                    </tr>
                    <tr>
                        <td>Bill Amount</td>
                        <td>Rs.<%= String.format("%.2f", billAmount) %></td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td><%= status %></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <form>
            <div class="form-group">
                <label for="paperSize">Paper Size:</label>
                <div>
                    <label><input type="radio" name="paperSize" value="A4" checked>A4</label>
                    <label><input type="radio" name="paperSize" value="Letter">Letter</label>
                </div>
            </div>
            <div class="form-group">
                <label for="orientation">Orientation:</label>
                <div>
                    <label><input type="radio" name="orientation" value="portrait" checked>Portrait</label>
                    <label><input type="radio" name="orientation" value="landscape">Landscape</label>
                </div>
            </div>
            <button type="button" class="btn btn-primary" onclick="printReceipt()">Print Receipt</button>
        </form>
    </div>
</body>
</html>
