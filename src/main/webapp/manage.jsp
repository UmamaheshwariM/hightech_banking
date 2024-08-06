<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.util.Date" %>
<html>
<head>
    <title>Manage Customers</title>
    <style>
        input[type="number"]::-webkit-outer-spin-button,
        input[type="number"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type="number"] {
            -moz-appearance: textfield;
        }
        button{
            text-align: center;
            padding: 10px;
            background-color: midnightblue;
            margin-top: 40px;
            margin-left: 650px;
            border: 2px;
            border-radius: 7px;
            box-shadow: 1px 1px;
            color: white;
        }

        #view-customers{
            text-align: center;
            color: white;

        }
        .tab1{
            text-align: center;
            margin-left: 200px;
            font-size: 40px;
            color: white;
        }

        body {
            background-image: url('image/open.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            backdrop-filter: blur(5px);
            margin: 0;
            padding: 0;
        }
        .tab {
            display: inline-block;
            margin-right: 5px;
            padding: 10px;
            cursor: pointer;
            background-color: white;
            border: 1px solid #ccc;
        }
        .tab:hover {
            background-color: #ddd;
        }

        .tab-content {
            display: none;
        }
        .tab-content-active {
            display: block;
        }
        .tab2{
            text-align: center;
            color: white;
        }
        #sel{
            text-align: center;
            font-size:55px ;
            margin-top: 50px;
            text-shadow: 2px 2px midnightblue;
            color: white;
        }

        .tag {
            text-align: center;
            padding: 10px;
            font-size: 25px;
        }

        .tab{
            background-color: white;
            border: 2px midnightblue;
            border-radius:7px ;
            box-shadow: 1px 1px;
            color: midnightblue;
            font-weight: bold;
            padding: 10px;

        }
        .tab3{
            text-align: center;
            color: white;
        }
    </style>
</head>
<body>
<h1 id="sel">Select The Operation</h1>
<div class="tag">


<div class="tab" onclick="showTab('modify-customer')">Modify Customer</div>
<div class="tab" onclick="showTab('delete-customer')">Delete Customer</div>
</div>

<div id="view-customers" class="tab-content tab-content-active">
    <h2>View Customers</h2>
    <div class="tab1">
    <table border="1">
        <tr>
            <th>Account Number</th>
            <th>User Name</th>
            <th>Full Name</th>
            <th>Address</th>
            <th>Phone Number</th>
            <th>Email</th>
            <th>Account Type</th>
            <th>DOB</th>
            <th>ID Proof</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "1234");
                String query = "SELECT account_number, user_name, full_name, address, phone_number, email, account_type, DOB, ID_Proof FROM customers";
                PreparedStatement ps = con.prepareStatement(query);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("account_number") %></td>
            <td><%= rs.getString("user_name") %></td>
            <td><%= rs.getString("full_name") %></td>
            <td><%= rs.getString("address") %></td>
            <td><%= rs.getString("phone_number") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("account_type") %></td>
            <td><%= rs.getDate("DOB") %></td>
            <td><%= rs.getString("ID_Proof") %></td>
        </tr>
        <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</div>
</div>
<div class="tab2">
    <div id="modify-customer" class="tab-content">
        <h2>Modify Customer</h2>
        <form action="ManagementServlet?action=modify" method="post">
            <label>Select Customer:</label>
            <select name="user_name">
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "1234");
                        String query = "SELECT user_name, full_name FROM customers";
                        PreparedStatement ps = con.prepareStatement(query);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                %>
                <option value="<%= rs.getString("user_name") %>"><%= rs.getString("full_name") %></option>
                <%
                        }
                        rs.close();
                        ps.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </select><br><br>
            <label for="full_name">Full Name</label>
            <input type="text" id="full_name" name="full_name" required><br><br>
            <label for="address">Address</label>
            <input type="text" id="address" name="address" required><br><br>
            <label for="phone_number">Phone Number</label>
            <input type="text" id="phone_number" name="phone_number" required><br><br>
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required><br><br>
            <label for="account_type">Account Type:</label>
            <select id="account_type" name="account_type">
                <option value="Select">SELECT</option>
                <option value="Savings Account">Savings Account</option>
                <option value="Current Account">Current Account</option>
            </select><br><br>
            <label for="DOB">Date of Birth</label>
            <input type="date" id="DOB" name="DOB" required><br><br>
            <label for="ID_Proof">ID Proof:</label>
            <select id="ID_Proof" name="ID_Proof">
                <option value="Select">SELECT</option>
                <option value="Aadhaar Card">Aadhaar Card</option>
                <option value="Driving Licence">Driving Licence</option>
            </select><br><br>
            <input type="submit" value="Update">
        </form>
    </div>
</div>
<div class="tab3">
<div id="delete-customer" class="tab-content">
    <h2>Delete Customer</h2>
    <form action="ManagementServlet?action=delete" method="post">
        <label>Select Customer:</label>
        <select name="user_name">
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "1234");
                    String query = "SELECT user_name, full_name FROM customers";
                    PreparedStatement ps = con.prepareStatement(query);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
            %>
            <option value="<%= rs.getString("user_name") %>"><%= rs.getString("full_name") %></option>
            <%
                    }
                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </select><br><br>
        <input type="submit" value="Delete">
    </form>
</div>
</div>
<a href="adminDashboard.jsp"><button type="button">Back to Dashboard</button></a>

<script>
    function showTab(tabId) {
        var tabContents = document.querySelectorAll('.tab-content');
        tabContents.forEach(function(tabContent) {
            tabContent.classList.remove('tab-content-active');
        });

        var tabs = document.querySelectorAll('.tab');
        tabs.forEach(function(tab) {
            tab.classList.remove('tab-active');
        });

        document.getElementById(tabId).classList.add('tab-content-active');
        event.target.classList.add('tab-active');
    }
</script>
</body>
</html>
