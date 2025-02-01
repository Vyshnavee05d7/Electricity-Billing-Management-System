<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electricity Bill Payment</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #fff; /* White background */
            color: #000;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background-color: #4158d0; /* Blue background for the navbar */
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }
        .navbar .logo {
            display: flex;
            align-items: center;
        }
        .navbar .logo img {
            height: 40px; /* Adjust height as needed */
            margin-right: 10px; /* Spacing between logo and text */
        }
        .navbar h1 {
            margin: 0;
            font-size: 20px;
        }
        .navbar .normal-button {
            background-color: #fff; /* White background for the button */
            color: #4158d0; /* Blue text color */
            border: 1px solid #4158d0; /* Blue border */
            padding: 6px 12px; /* Smaller padding for a smaller button */
            text-align: center;
            text-decoration: none;
            font-size: 12px; /* Smaller font size */
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease, transform 0.2s ease;
        }
        .navbar .normal-button:hover {
            background-color: #4158d0; /* Blue background on hover */
            color: #fff; /* White text on hover */
            transform: scale(1.05); /* Slightly enlarges the button */
        }
        .container {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 350px;
            margin: 80px auto 20px auto; /* Adjusted margin to account for fixed navbar */
            text-align: center;
            animation: fadeIn 1s ease-in;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        h1 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333; /* Darker text for better readability */
        }
        .payment-method {
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        .payment-method label {
            margin-bottom: 10px;
            cursor: pointer;
            color: #333; /* Darker text for better readability */
            display: flex;
            align-items: center;
        }
        .payment-method input {
            margin-right: 10px;
        }
        .payment-details {
            display: none;
            transition: all 0.3s ease;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333; /* Darker text for better readability */
        }
        .form-group input {
            width: calc(100% - 22px); /* Adjusted width to account for padding and border */
            padding: 10px;
            border: 1px solid #ddd; /* Light border */
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.9); /* Slightly opaque white */
            color: #000;
            font-size: 16px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-group input:focus {
            border-color: #4158d0; /* Blue border on focus */
            box-shadow: 0 0 5px rgba(65, 88, 208, 0.3); /* Subtle shadow */
            outline: none;
        }
        .button {
            display: inline-block;
            width: 100%;
            padding: 12px;
            background-color: #4158d0; /* Blue background */
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .button:hover {
            background-color: #364fc7; /* Darker blue on hover */
            transform: scale(1.05); /* Slightly enlarges the button */
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo">
            <img src="logo.png" alt="Vidyuth Logo">
            <h1>Vidyuth</h1>
        </div>
        <!-- Updated Button Text -->
        <a href="dashboard.jsp" class="normal-button">Go to Dashboard</a>
    </div>
    <div class="container">
        <h1>Electricity Bill Payment</h1>
        <form id="paymentForm">
            <input type="hidden" name="username" value="<%= request.getParameter("username") %>">
            <input type="hidden" name="billAmount" value="<%= request.getParameter("billAmount") %>">
            <div class="payment-method">
                <label>
                    <input type="radio" name="payment" value="credit" onclick="showDetails('credit')"> Credit Card
                </label>
                <label>
                    <input type="radio" name="payment" value="debit" onclick="showDetails('debit')"> Debit Card
                </label>
                <label>
                    <input type="radio" name="payment" value="netbanking" onclick="showDetails('netbanking')"> Net Banking
                </label>
            </div>
            <div id="credit" class="payment-details">
                <div class="form-group">
                    <label for="cardNumber">Card Number</label>
                    <input type="text" id="cardNumber" name="cardNumber" placeholder="Enter your card number" required>
                </div>
                <div class="form-group">
                    <label for="expiryDate">Expiry Date</label>
                    <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
                </div>
                <div class="form-group">
                    <label for="cvv">CVV</label>
                    <input type="text" id="cvv" name="cvv" placeholder="Enter CVV" required>
                </div>
            </div>
            <div id="debit" class="payment-details">
                <div class="form-group">
                    <label for="debitNumber">Card Number</label>
                    <input type="text" id="debitNumber" name="debitNumber" placeholder="Enter your card number" required>
                </div>
                <div class="form-group">
                    <label for="debitExpiryDate">Expiry Date</label>
                    <input type="text" id="debitExpiryDate" name="debitExpiryDate" placeholder="MM/YY" required>
                </div>
                <div class="form-group">
                    <label for="debitCVV">CVV</label>
                    <input type="text" id="debitCVV" name="debitCVV" placeholder="Enter CVV" required>
                </div>
            </div>
            <div id="netbanking" class="payment-details">
                <div class="form-group">
                    <label for="bankName">Bank Name</label>
                    <input type="text" id="bankName" name="bankName" placeholder="Enter your bank name" required>
                </div>
                <div class="form-group">
                    <label for="accountNumber">Account Number</label>
                    <input type="text" id="accountNumber" name="accountNumber" placeholder="Enter your account number" required>
                </div>
            </div>
            <a href="view_bill.jsp" class="button">Submit Payment</a>
        </form>
    </div>
    <script>
        function showDetails(paymentType) {
            document.querySelectorAll('.payment-details').forEach(div => div.style.display = 'none');
            document.getElementById(paymentType).style.display = 'block';
        }
    </script>
</body>
</html>
