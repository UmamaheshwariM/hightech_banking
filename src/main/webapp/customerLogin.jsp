<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Login</title>
    <style>
        input[type="number"]::-webkit-outer-spin-button,
        input[type="number"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* For Firefox */
        input[type="number"] {
            -moz-appearance: textfield;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 40%;
            margin: 50px auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0px 0px 10px 0px #000;
            text-align: center;
        }
        h1 {
            color: #333;
        }
        .form-group {
            margin: 15px 0;
        }
        .form-group label {
            display: block;
            text-align: left;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            text-decoration: none;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Customer Login</h1>
    <form action="CustomerLoginServlet" method="post">
        <div class="form-group">
            <label for="account_number">Account Number</label>
                <input type="number" id="account_number" name="account_number" required>

            <label for="user_name">User Name</label>
                <input type="text" id="user_name" name="user_name" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <button type="submit" class="btn">Login</button>
        </div>

    </form>
</div>
</body>
</html>

