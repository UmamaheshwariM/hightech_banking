<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        body {
            background-image: url('image/category.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            backdrop-filter: blur(5px);
            margin: 0;
            padding: 0;
        }
        #welcome {
            padding: 10px;
            margin-left: 40px;
            margin-bottom: 10px;
        }
        #acc {
            float: right;
            margin-top: -50px;
            padding-right: 50px;
            padding-bottom: 20px;
        }
        #op {
            font-size: 70px;
            text-align: center;
            font-size: 40px;
            margin-left: 300px;
            padding-bottom: 10px;
        }
        .f1, .f2 {
            margin-top: 40px;
        }
        .f1 {
            float: left;
            margin-left: 350px;
            font-size: 30px;
        }
        .f2 {
            float: right;
            margin-right: 350px;
            font-size: 30px;
        }
        button {
            color: midnightblue;
            font-family: "Times New Roman";

            font-size: 30px;
            padding: 10px 20px;
            background-color: white;
            border: 2px solid midnightblue;
            box-shadow: 1px 1px;
        }
        .exit {
            margin-top: 450px;
            text-align: center;
        }
        body {
            background-color: black;
            color: white;
        }
        a{
            color: midnightblue;
            font-family: "Times New Roman";

        }
    </style>
    <title></title>
</head>
<body>
<%
//    HttpSession session = request.getSession(false);
    String user_name = null;
    String account_number = null;

    if (session != null) {
        user_name = (String) session.getAttribute("user_name");
        account_number = (String) session.getAttribute("account_number");
    }

    if (user_name == null || account_number == null) {
        response.sendRedirect("category.jsp");
        return;
    }
%>
<h1 id="welcome">Welcome <%= user_name %>..!!</h1>
<h1 id="acc">Account Number: <%= account_number %></h1>

<h2 id="op">Please Select an Operation!</h2>
<div class="f1">
    <h4><form action="category.jsp" method="post">
        <button name="operation" value="deposit">Deposit</button>
    </form></h4>
    <h4><form action="category.jsp" method="post">
        <button name="operation" value="withdraw">Withdraw</button>
    </form></h4>
    <h4><form action="category.jsp" method="post">
        <button name="operation" value="fundTransfer">Fund Transfer</button>
    </form></h4>
</div>
<div class="f2">
    <h4><form action="category.jsp" method="post">
        <button name="operation" value="miniStatement">Mini Statement</button>
    </form></h4>
    <h4><form action="category.jsp" method="post">
        <button name="operation" value="balanceEnquiry">Check Balance</button>
    </form></h4>
    <h4><form action="category.jsp" method="post">
        <button name="operation" value="changePin">Change Pin</button>
    </form></h4>
</div>
<div class="exit">
    <h4><form action="index.jsp" method="post">
        <button name="operation" value="exit">Logout</button>
    </form></h4>
</div>

</body>
</html>
