<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Electricity Billing Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .navbar {
            background-color: #0056b3;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
        }
        .navbar-brand {
            display: flex;
            align-items: center;
            font-size: 2rem; /* Increased font size */
            color: white;
        }
        .navbar-brand img {
            position: absolute;
            left: 10px;
            top: 10px;
            width: 40px; /* Increased size of the thunderbolt image */
            height: 40px;
        }
        .navbar-brand span {
            margin-left: 50px; /* Adjusted for the thunderbolt image */
        }
        .btn-light {
            margin-left: 10px;
        }
        .welcome-message {
            text-align: center;
            margin-top: 20px;
            font-size: 2rem; /* Increased font size */
            font-weight: bold;
        }
        .btn-custom {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            background-color: #0056b3;
            color: white;
            border-radius: 20px; /* Rounded corners */
            width: 200px; /* Square buttons */
            height: 200px; /* Square buttons */
            margin: 15px; /* Margin for spacing */
            transition: transform 0.3s;
        }
        .btn-custom img {
            width: 80%;
            height: 80%;
            object-fit: contain;
        }
        .btn-custom:hover {
            transform: scale(1.05);
            background-color: #004494;
        }
        .btn-custom p {
            margin: 0;
            font-size: 1.2rem; /* Increased font size */
            margin-top: 5px; /* Ensure text appears below the image */
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <a class="navbar-brand" href="#">
            <img src="logo.png" alt="Thunderbolt Symbol">
            <span>Vidyuth</span>
        </a>
        <div>
            <button class="btn btn-light" onclick="location.href='profile.jsp'">Profile</button>
            <button class="btn btn-light" onclick="location.href='index.html'">Logout</button>
        </div>
    </nav>

    <div class="welcome-message">Welcome to Dashboard!!</div>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-4 d-flex justify-content-center">
                <a href="bills_payments.jsp" class="btn btn-primary btn-custom">
                    <img src="bills.gif" alt="Bills Icon">
                    <p>Bills and Payments</p>
                </a>
            </div>
            <div class="col-md-4 d-flex justify-content-center">
                <a href="energsav.html" class="btn btn-primary btn-custom">
                    <img src="tips.gif" alt="Tips Icon">
                    <p>Energy Saving Tips</p>
                </a>
            </div>
            <div class="col-md-4 d-flex justify-content-center">
                <a href="faq.html" class="btn btn-primary btn-custom">
                    <img src="faq.gif" alt="FAQ Icon">
                    <p>Frequently Asked Questions</p>
                </a>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-4 d-flex justify-content-center">
                <a href="announcements.jsp" class="btn btn-primary btn-custom">
                    <img src="announcement.gif" alt="Announcements Icon">
                    <p>Announcements</p>
                </a>
            </div>
            <div class="col-md-4 d-flex justify-content-center">
                <a href="feedback.jsp" class="btn btn-primary btn-custom">
                    <img src="feedback.gif" alt="Feedback Icon">
                    <p>Feedback</p>
                </a>
            </div>
            <div class="col-md-4 d-flex justify-content-center">
                <a href="print_receipt.jsp" class="btn btn-primary btn-custom">
                    <img src="print.gif" alt="Receipt Icon">
                    <p>Print Receipt</p>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
