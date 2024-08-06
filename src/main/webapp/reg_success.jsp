<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration Success</title>
    <style>
        body {
            background-image: url('image/reg.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            backdrop-filter: blur(5px);
            margin: 0;
            padding: 0;
            font-family: "Times New Roman";
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .container h1 {
            color: midnightblue;
        }
        .container p {
            color: #333;
        }
        .container a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: midnightblue;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
        }
        .container a:hover {
            background-color: darkblue;
        }
    </style>
</head>
<body>
<div class="container">
    <%
        String success = (String) session.getAttribute("Success");
        String error = (String) session.getAttribute("Error");
        String message = (String) session.getAttribute("Message");
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    %>

    <% if (success != null) { %>
    <h1><%= success %></h1>
    <% } else if (error != null) { %>
    <h1><%= error %></h1>
    <% } %>

    <p><%= message != null ? message : "" %></p>

    <% if (isAdmin != null && isAdmin) { %>
    <a href="adminDashboard.jsp">Back to Admin Dashboard</a>
    <% } else { %>
    <a href="customerDashboard.jsp">Back to Customer Dashboard</a>
    <% } %>
</div>
</body>
</html>
