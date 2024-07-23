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

        #welcome{
            text-align: center;
            font-size: 50px;
            margin-top:80px ;
        }
        .form-group{
            text-align: center;
            padding:20px;
            font-size: 20px;
            font-weight: bold;
        }
        button{
            font-size: 20px;
            padding: 10px;
            font-weight: bold;
        }
        label{
            padding: 10px;

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