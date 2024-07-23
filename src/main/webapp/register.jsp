<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
    <style>
        input[type="number"]::-webkit-outer-spin-button,
        input[type="number"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type="number"] {
            -moz-appearance: textfield;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height:
            margin: 10;
        }
        .registration-container {
            background-color: #ffffff;
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
        }
        .registration-container h2 {
            margin-bottom: 20px;
        }
        .registration-container label {
            display: block;
            margin: 10px 0 5px;
        }
        .registration-container input, .registration-container select {
            width: 100%;
            padding: 1px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .registration-container button {
            width: 100%;
            padding: 5px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .registration-container button:hover {
            background-color: #218838;
        }
        .b1{
            margin-top: 0px;
        }
    </style>
</head>
<body>
<div class="registration-container">
    <h2>Customer Registration</h2>
    <form action="RegistrationServlet" method="post">
        <div class="b">
            <label for="user_name">User Name</label>
            <input type="text" id="user_name" name="user_name" required>
        </div>
        <div class="b1">
            <label for="full_name">Full Name</label>
            <input type="text" id="full_name" name="full_name" required>
        </div>
        <label for="account_type">Account Type</label>
        <select id="account_type" name="account_type">
            <option value="Select">Select</option>
            <option value="Savings Account">Savings Account</option>
            <option value="Current Account">Current Account </option>
        </select>

        <label for="phone_number">Phone Number</label>
        <input type="number" id="phone_number" name="phone_number" required>

        <label for="gender">Gender</label>
        <select id="gender" name="gender">
            <option value="Select">Select</option>
            <option value="Female">Female</option>
            <option value="Male">Male</option>
        </select>

        <label for="DOB">Date of Birth</label>
        <input type="date" id="DOB" name="DOB" required>

        <label for="email">Email ID</label>
        <input type="email" id="email" name="email" required>

        <label for="ID_Proof">ID Proof</label>
        <select id="ID_Proof" name="ID_Proof">
            <option value="Select">Select</option>
            <option value="Aadhaar Card">Aadhaar Card</option>
            <option value="Driving Licence">Driving Licence</option>
        </select>

        <label for="address">Address</label>
        <input type="text" id="address" name="address" required>

<%--        <label for="initial_amount">Initial Balance (min 1000):</label>--%>
<%--        <input type="number" id="initial_amount" name="initial_amount" required min="1000">--%>

        <button type="submit"> Save & Register </button>
    </form>
</div>
</body>
</html>