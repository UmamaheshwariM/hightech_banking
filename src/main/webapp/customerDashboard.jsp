<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
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
            text-align: center;
            font-size: 40px;
            margin-left: 30px;
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
            font-size: 30px;
            padding: 10px 20px;
            background-color: rgb(241, 207, 165);
        }
        .exit {
            margin-top: 500px;
            text-align: center;
        }
        body {
            background-color: black;
            color: powderblue;
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
