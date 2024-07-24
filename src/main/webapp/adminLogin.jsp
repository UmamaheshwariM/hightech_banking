<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
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
            background-image: url('image/ad.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            backdrop-filter: blur(5px);
            margin: 0;
            padding: 0;
        }
        #welcome {
            text-align: center;
            font-size: 50px;
            margin-top: 80px;
            color: white;
            text-shadow: 2px 2px 4px midnightblue;
            font-weight: bold;
            font-family: 'Times New Roman', Times, serif;
        }
        .form-group {
            text-align: center;
            padding: 15px;
            font-size: 20px;
            font-weight: bold;
            color: white;
            font-family: 'Times New Roman', Times, serif;
        }
        button {
            font-size: 20px;
            padding: 10px;
            font-weight: bold;
            color: midnightblue;
            background-color: white;
            border: 2px solid midnightblue;
            border-radius: 7px;
            box-shadow: 1px 1px;
            font-family: 'Times New Roman', Times, serif;
        }
        label {
            padding: 10px;
            color: white;
            font-weight: bold;
            font-family: 'Times New Roman', Times, serif;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 id="welcome">Admin Login Page</h1>
    <form action="AdminLoginServlet" method="post">

        <div class="form-group">
            <label for="admin_Id">Admin Id</label>
            <input type="number" id="admin_Id" name="admin_Id" required>
        </div>

        <div class="form-group">
            <label for="admin_Password">Admin Password</label>
            <input type="password" id="admin_Password" name="admin_Password" required>
        </div>

        <div class="form-group">
            <button type="submit" class="btn">Login</button><br>

        </div>


    </form>
</div>
</body>
</html>