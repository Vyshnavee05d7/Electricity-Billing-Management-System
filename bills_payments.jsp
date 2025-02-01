<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bills and Payments</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .container {
            background-color: #ffffff;
            border: 2px solid #5a9bd6;
            border-radius: 10px;
            padding: 30px;
            margin-top: 50px;
            box-shadow: 0 0 15px rgba(90, 155, 214, 0.3);
            text-align: center;
        }
        h2 {
            color: #5a9bd6;
            margin-bottom: 30px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .btn-custom {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 150px;
            width: 150px;
            font-size: 1.2em;
            font-weight: bold;
            color: #ffffff;
            border-radius: 15px;
            background-color: #5a9bd6;
            border-color: #5a9bd6;
            transition: background-color 0.3s ease, transform 0.3s ease;
            margin: 5px;
        }
        .btn-custom i {
            font-size: 3em;
        }
        .btn-custom:hover {
            transform: scale(1.05);
        }
        .btn-custom:hover i {
            display: none;
        }
        .btn-custom:hover span {
            display: inline-block;
            position: absolute;
        }
        .btn-custom span {
            display: none;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-align: center;
        }
        .btn-primary:hover {
            background-color: #4787b1;
            border-color: #4787b1;
        }
        .navbar {
            background-color: #007bff;
            padding: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .navbar-brand {
            color: #ffffff;
            font-size: 1.5rem;
            font-weight: bold;
            display: flex;
            align-items: center;
        }
        .navbar-brand svg {
            width: 1.5em;
            height: 1.5em;
            fill: #ffffff;
            margin-right: 10px;
        }
        .navbar-nav .nav-link {
            color: #ffffff !important;
            font-weight: bold;
        }
        .navbar-nav .nav-item {
            margin-left: 15px;
        }
        .btn-dashboard {
            background-color: #0056b3;
            color: #ffffff;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .btn-dashboard:hover {
            background-color: #003d7a;
            transform: scale(1.05);
        }
        .button-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
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
                    <a class="nav-link btn-dashboard" href="dashboard.jsp">Go to Dashboard</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container mt-5">
        <h2>Bills and Payments</h2>
        <div class="button-container">
            <!-- Button 1: Peak Hours and Prices -->
            <a href="hours_prices.html" class="btn btn-primary btn-custom">
                <i class="fas fa-clock"></i>
                <span>Peak Hours and Prices</span>
            </a>

            <!-- Button 2: User Usage of Electricity -->
            <a href="user_usage.jsp" class="btn btn-primary btn-custom">
                <i class="fas fa-bolt"></i>
                <span>User Usage of Electricity</span>
            </a>

            <!-- Button 3: View Graph -->
            <a href="view_graph.jsp" class="btn btn-primary btn-custom">
                <i class="fas fa-chart-line"></i>
                <span>View Graph</span>
            </a>

            <!-- Button 4: View Bill -->
            <a href="view_bill.jsp" class="btn btn-primary btn-custom">
                <i class="fas fa-file-invoice-dollar"></i>
                <span>View Bill</span>
            </a>
        </div>
    </div>
</body>
</html>
