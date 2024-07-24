<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
  <meta charset="UTF-8">
  <title>Banking System</title>
  <style>
    body {
      background-image: url('image/first.jpg');
      background-size: cover;
      background-repeat: no-repeat;
      background-attachment: fixed;
      backdrop-filter: blur(5px);
      margin: 0;
      padding: 0;
    }

    #welcome {
      position: relative;
      text-align: center;
      font-size: 50px;
      /*margin-top: 80px;*/
      padding-top: 150px;
      color: white;
      text-shadow: 2px 2px 4px #000000;
    }

    p {
      text-align: center;
      font-size: 30px;
      font-weight: lighter;
      color: white;
      text-shadow: 2px 2px 4px #000000;
    }

    .btn1, .btn2 {
      text-align: center;
      margin-top: 20px;
    }

    button {
      padding: 10px;
      font-size: 20px;
      background-color: white;
      border: 2px solid midnightblue;
      margin-top: 10px;
      border-radius: 7px;
      box-shadow: 1px 1px;
    }

    a {
      text-decoration: none;
      color: midnightblue;
      font-family:"Times New Roman" ;
      font-weight: bold;
    }
  </style>
</head>
<body>
<div class="container">
  <h1 id="welcome">Welcome to the Login page<br>Booz Cooper Bank</h1>
  <p>Please select an option</p>
  <div class="btn1">
    <button><a href="customerLogin.jsp">Customer Login</a></button><br>
  </div>
  <div class="btn2">
    <button><a href="adminLogin.jsp">Admin Login</a></button>
  </div>
</div>
</body>
</html>
