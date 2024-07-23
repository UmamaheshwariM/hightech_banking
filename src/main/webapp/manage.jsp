<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<html>
<head>
    <title>Manage Customers</title>
    <style>
        .tab {
            display: inline-block;
            margin-right: 5px;
            padding: 10px;
            cursor: pointer;
            background-color: #f1f1f1;
            border: 1px solid #ccc;
        }

        .tab:hover {
            background-color: #ddd;
        }

        .tab-active {
            background-color: #ccc;
        }

        .tab-content {
            display: none;
        }

        .tab-content-active {
            display: block;
        }
    </style>
</head>
<body>
<h1>Select Operation</h1>

<!-- Tab Headers -->
<div class="tab tab-active" onclick="showTab('view-customers')">View Customers</div>
<div class="tab" onclick="showTab('modify-customer')">Modify Customer</div>
<div class="tab" onclick="showTab('delete-customer')">Delete Customer</div>

<!-- Tab Content -->
<div id="view-customers" class="tab-content tab-content-active">
    <h2>View Customers</h2>
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

<a href="adminDashboard.jsp">Back to Dashboard</a>

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
