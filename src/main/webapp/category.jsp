<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<html>
<head>
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
            background-image: url('image/bank.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            backdrop-filter: blur(10px);
            margin: 0;
            padding: 0;
        }
        #message {
            padding: 50px;
            text-align: center;
            font-size: 30px;
            margin-top: 30px;
            text-shadow: 2px 2px 2px midnightblue;
            color: white;
            font-family: 'Times New Roman', Times, serif;
        }
        #form {
            text-align: center;
            margin-top: 50px;
            color: white;
            font-family: 'Times New Roman', Times, serif;
        }
        button {
            font-size: 20px;
            font-weight: bold;
            padding: 10px 20px;
            background-color: white;
            color: midnightblue;
            font-family: 'Times New Roman', Times, serif;
        }
    </style>

    <title>Operation</title>
</head>
<body>
<%
    String operation = request.getParameter("operation");
    String user_name = (String) session.getAttribute("user_name");
    String account_number = (String) session.getAttribute("account_number");

    if (user_name == null || account_number == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String message = "Welcome " + user_name + "! " + " " + " Account Number: " + account_number;
%>

<h2 id="message"><%= message %></h2>

<div id="form">

    <script>
        function validateNumberInput(input) {
            var value = input.value;
            var regex = /^[0-9]+$/;
            if (!regex.test(value)) {
                alert("Only numbers are allowed.");
                return false;
            }
            return true;
        }
    </script>

    <% if ("deposit".equals(operation)) { %>
    <form action="CategoryServlet" method="post" onsubmit="return validateNumberInput(this.amount)">
        <input type="hidden" name="action" value="deposit">
        <label>Amount <input type="number" name="amount" required pattern="^0\.[1-9]\d?|[1-9]\d*(\.\d{1,2})?$" title="Only numbers are allowed"><br><br>
            <button type="submit">Deposit</button>
        </label>
    </form>
    <% } else if ("withdraw".equals(operation)) { %>
    <form action="CategoryServlet" method="post" onsubmit="return validateNumberInput(this.amount)">
        <input type="hidden" name="action" value="withdraw">
        <label>Amount <input type="number" name="amount" required pattern=^0\.[1-9]\d?|[1-9]\d*(\.\d{1,2})?$" title="Only numbers are allowed"><br><br>
            <button type="submit">Withdraw</button>
        </label>
    </form>

    <%
        } else if ("fundTransfer".equals(operation)) { %>
    <form action="CategoryServlet" method="post" onsubmit="return validateNumberInput(this.amount)">
        <input type="hidden" name="action" value="fundTransfer">
        <label>Recipient Account Number <input type="text" name="recipient_account_number" required><br><br>
            Amount <input type="number" name="amount" required pattern=^0\.[1-9]\d?|[1-9]\d*(\.\d{1,2})?$" title="Only numbers are allowed"><br><br>
            <button type="submit">Transfer</button>
        </label></form>
    <%
        } else if ("miniStatement".equals(operation)) { %>
    <form action="CategoryServlet" method="post">
        <input type="hidden" name="action" value="miniStatement">
        <button type="submit">View Mini Statement</button>
    </form>
    <%
        } else if ("balanceEnquiry".equals(operation)) { %>
    <form action="CategoryServlet" method="post">
        <input type="hidden" name="action" value="balanceEnquiry">
        <label for="account_number">Enter Account Number</label>
        <input type="text" id="account_number" name="account_number" required>
        <input type="submit" value="Get Balance Enquiry">
    </form>
    <br><br>
    <%
        } else if ("changePin".equals(operation)) { %>
    <form action="CategoryServlet" method="post">
        <input type="hidden" name="action" value="changePin">
        <label>Current Pin <input type="password" name="current_pin" required><br><br>
            New Pin <input type="password" name="new_pin" required><br><br>
            <button type="submit">Change Pin</button>
        </label></form>
    <%
        } else { %>
    <form action="customerLogin.jsp" method="post">
        <button type="submit"> Exit </button>
    </form>
    <%
            }
         %>
    <form action="customerDashboard.jsp" method="post">
        <button type="submit">Back</button>
    </form>
</div>
</body>
</html>
