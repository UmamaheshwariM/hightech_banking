<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <style>
    body {
      background-image: url('image/index.jpg');
      background-size: cover;
      background-repeat: no-repeat;
      background-attachment: fixed;
      backdrop-filter: blur(5px);
      margin: 0;
      padding: 0;
    }
    #wel{
      text-align: center;
      color: white;
      font-size: 60px;
      margin-top: 100px;
    }
    button{
      padding: 10px;
      box-shadow: 1px 1px;
      border:2px solid midnightblue;
      border-radius: 7px;

    }
    .b1{
      text-align: center;
      padding: 20px;
      border-radius: 7px;


    }
    .b2{
      text-align: center;
      padding: 20px;

    }
    .back{
      text-align: center;
      padding: 20px;
      font-weight: bold;
    }
    a{
      text-decoration: none;
      font-size: 25px;
      padding: 20px;
      color: midnightblue;
      font-family: "Times New Roman";

    }
  </style>
</head>
<body>
<div class="dashboard-container">
  <h2 id="wel">Admin Control Panel</h2>
  <div class="b1"><button><a href="register.jsp">New Customer Registration</a></button><br></div>
  <div class="b2"><button><a href="manage.jsp?action=view">Manage Customer</a></button><br></div>
  <div class="back"><button><a href='index.jsp'>Back </a></button></div>
</div>
</body>
</html>