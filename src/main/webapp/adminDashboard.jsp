<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <style>
    #wel{
      text-align: center;
      font-size: 60px;
      margin-top: 100px;
    }
    button{
      padding: 10px;

    }
    .b1{
      text-align: center;
      padding: 20px;

    }
    .b2{
      text-align: center;
      padding: 20px;

    }
    .back{
      text-align: center;
      padding: 20px;
    }
    a{
      text-decoration: none;
      font-size: 25px;
      padding: 20px;
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