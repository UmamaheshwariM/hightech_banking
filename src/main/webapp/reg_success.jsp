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
            background-color: midnightblue;
        }
    </style>
</head>
<body>
<div class="container">
<%--    <h1>Registration Successful</h1>--%>
<%--    <p>Thank you for registering! Your account has been created successfully.</p>--%>
    <%
        if (session.getAttribute("Success") != null) {
    %>
    <h1><%=session.getAttribute("Success")%></h1>

    <%
        } else {
    %>
    <h1><%=session.getAttribute("Error")%></h1>
    <%
        }
    %>

    <p><%=session.getAttribute("Message")%></p>
<%
    if ((boolean)session.getAttribute("isAdmin") ) {
%>
    <a href="adminDashboard.jsp">Back to Admin Dashboard</a>
    <%
        }else{
    %>
    <a href="customerDashboard.jsp">Back to Customer Dashboard</a>
    <%
        }
    %>
</div>
</body>
</html>
