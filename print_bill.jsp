<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Print Bill</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }
        .bill-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        h1 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #333;
        }
        .details {
            margin-bottom: 20px;
        }
        .details label {
            font-weight: bold;
            margin-right: 10px;
        }
        .details p {
            margin: 5px 0;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4158d0;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            text-align: center;
            margin-top: 20px;
        }
        .button:hover {
            background-color: #364fc7;
        }
    </style>
</head>
<body>
    <div class="bill-container">
        <h1>Electricity Bill</h1>
        <div class="details">
            <p><label>Username:</label> <%= request.getAttribute("username") %></p>
            <p><label>Service Number:</label> <%= request.getAttribute("serviceNumber") %></p>
            <p><label>Phone Number:</label> <%= request.getAttribute("phoneNumber") %></p>
            <p><label>Email:</label> <%= request.getAttribute("email") %></p>
            <p><label>Status:</label> <%= request.getAttribute("status") %></p>
            <p><label>Peak Hours:</label> <%= request.getAttribute("peakHours") %></p>
            <p><label>Mid-Peak Hours:</label> <%= request.getAttribute("midPeakHours") %></p>
            <p><label>Off-Peak Hours:</label> <%= request.getAttribute("offPeakHours") %></p>
            <p><label>Super Off-Peak Hours:</label> <%= request.getAttribute("superOffPeakHours") %></p>
            <p><label>Amount Due:</label> $<%= String.format("%.2f", (Double)request.getAttribute("amountDue")) %></p>
        </div>
        <button class="button" onclick="window.print()">Print Bill</button>
    </div>
</body>
</html>
