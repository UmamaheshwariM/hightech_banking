<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Login</title>
    <style>
        *{
            font-family: "Times New Roman";
        }
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
            background-image: url('image/login.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            backdrop-filter: blur(5px);
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding-top: 100px;
        }
        .container {
            width: 40%;
            margin: 30px auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0px 0px 10px 0px #000;
            text-align: center;
            font-size: 20px;
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
            margin-top: 25px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        form{
            margin-top: 0px;
        }
        #topic{
            color: white;
            text-align: center;
            font-size: 50px;
            margin-top: 0px;
            text-shadow: 2px 2px 2px midnightblue;
        }
        label{
            padding-top: 20px;
        }
    </style>
</head>
<body>
<h1 id="topic">Customer Login</h1>
<div class="container">
    <form action="CustomerLoginServlet" method="post">
        <div class="form-group">
            <label for="account_number">Account Number</label>
                <input type="number" id="account_number" name="account_number" required>
            <label for="user_name">User Name</label>
                <input type="text" id="user_name" name="user_name" required>
            <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            <button type="submit" class="btn">Login</button>
        </div>

    </form>
</div>
</body>
</html>

