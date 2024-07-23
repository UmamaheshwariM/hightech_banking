<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
  <meta charset="UTF-8">
  <title>Banking System</title>
  <style>
    #welcome{
      text-align: center;
      font-size: 50px;
      margin-top: 80px;
    }
    p{
      text-align: center;
      font-size: 30px;
      font-weight:lighter;
    }
    .btn1{
      text-align: center;
      padding: 30px;
    }
    .btn2{
      text-align: center;
      padding: 20px;
    }
    button{
      padding: 10px;
      font-size: 20px;
      background-color: rgb(202, 153, 153);
      border: 2px solid rgb(157, 93, 93);
    }
    a{
      text-decoration: none;
      color: rgb(161, 24, 24);
    }
  </style>

</head>
<body>
<div class="container">
  <h1 id="welcome">Welcome to the Login page<br>Booz Cooper Bank</h1>
  <p>Please select an option </p>
  <div class="btn1">
    <button> <a href="customerLogin.jsp" >Customer Login</a></button><br>
  </div>
  <div class="btn2"><button><a href="adminLogin.jsp">Admin Login</a></button>
  </div>
</div>
</body>
</html>
