<%@ page import="java.sql.*,java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback - Electricity Billing Management System</title>
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
            animation: fadeIn 1s ease-in-out;
        }
        .form-group {
            animation: fadeIn 1.5s ease-in-out;
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
        <h2 class="my-4">Submit Feedback</h2>
        <form action="PostFeedbackServlet" method="post">
            <div class="form-group">
                <label for="feedback">Your Feedback</label>
                <textarea class="form-control" id="feedback" name="feedback" rows="5" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Submit Feedback</button>
        </form>
        <a href="dashboard.jsp" class="btn btn-primary mt-4">Back to Dashboard</a>
    </div>
</body>
</html>
