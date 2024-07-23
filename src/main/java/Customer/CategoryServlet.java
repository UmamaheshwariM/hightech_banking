package Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;

import static java.lang.System.out;

@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bank";
    private static final String USER = "root";
    private static final String PASS = "1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "deposit":
                handleDeposit(request, response);
                break;
            case "withdraw":
                handleWithdrawal(request, response);
                break;
            case "fundTransfer":
                handleFundTransfer(request, response);
                break;
            case "miniStatement":
                handleMiniStatement(request, response);
                break;
            case "balanceEnquiry":
                handleBalanceEnquiry(request, response);
                break;
            case "changePin":
                handleChangePIN(request, response);
                break;
            case "exit":
                handleExit(request, response);
                break;
            default:
                response.getWriter().println("Invalid action!");
        }
    }

    private void handleDeposit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String account_number = (String) session.getAttribute("account_number");
        double amount = Double.parseDouble(request.getParameter("amount"));

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement stmt = conn.prepareStatement("UPDATE customers SET balance = balance + ? WHERE account_number = ?")) {

            stmt.setDouble(1, amount);
            stmt.setInt(2, Integer.parseInt(account_number));

            int rowsUpdated = stmt.executeUpdate();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            if (rowsUpdated > 0) {
                try (PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO ministatement (from_account, to_account, transfer_date, amount, transaction_type) VALUES (?, ?, ?, ?, ?)")) {
                    insertStmt.setString(1, account_number);
                    insertStmt.setString(2, account_number); // Self deposit, so from_account and to_account are the same
                    insertStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                    insertStmt.setDouble(4, amount);
                    insertStmt.setString(5, "Self Deposit");
                    insertStmt.executeUpdate();
                }

                response.setContentType("text/html");
                out.println("Deposit Successful! Amount: " + amount);
            } else {
                out.println("Deposit Failed!");
            }
            out.print("<br>");
            out.println("<a href='customerDashboard.jsp'>Back to board</a>");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void handleWithdrawal(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String account_number = (String) session.getAttribute("account_number");
        double amount = Double.parseDouble(request.getParameter("amount"));

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
            conn.setAutoCommit(false); // Start transaction

            try (PreparedStatement checkStmt = conn.prepareStatement("SELECT balance FROM customers WHERE account_number = ?")) {
                checkStmt.setString(1, account_number);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    double currentBalance = rs.getDouble("balance");
                    if (currentBalance < amount) {
                        response.sendRedirect("insufficient_balance.jsp");
                        return;
                    }
                }
            }

            try (PreparedStatement updateStmt = conn.prepareStatement("UPDATE customers SET balance = balance - ? WHERE account_number = ?")) {
                updateStmt.setDouble(1, amount);
                updateStmt.setString(2, account_number);
                int rowsUpdated = updateStmt.executeUpdate();

                if (rowsUpdated > 0) {
                    try (PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO ministatement (from_account, to_account, transfer_date, amount, transaction_type) VALUES (?, ?, ?, ?, ?)")) {
                        insertStmt.setString(1, account_number);
                        insertStmt.setString(2, account_number); // Self-withdrawal, so from_account and to_account are the same
                        insertStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                        insertStmt.setDouble(4, amount);
                        insertStmt.setString(5, "Self Withdrawal");
                        insertStmt.executeUpdate();
                    }

                    conn.commit();
                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();
                    out.println("Withdrawal Successful! Amount: " + amount);
                } else {
                    conn.rollback(); // Rollback transaction if update fails
                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();
                    out.println("Withdrawal Failed! Insufficient balance.");
                }
            }
            out.println("<a href='customerDashboard.jsp'>Back to board</a>");
        } catch (SQLException e) {
            e.printStackTrace();
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
                conn.rollback();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }

    private void handleFundTransfer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String account_number = (String) session.getAttribute("account_number");
        String toAccount = request.getParameter("recipient_account_number");
        double amount = Double.parseDouble(request.getParameter("amount"));

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement withdrawStmt = conn.prepareStatement("UPDATE customers SET balance = balance - ? WHERE account_number = ? AND balance >= ?");
             PreparedStatement depositStmt = conn.prepareStatement("UPDATE customers SET balance = balance + ? WHERE account_number = ?");
             PreparedStatement transferStmt = conn.prepareStatement("INSERT INTO ministatement (from_account, to_account, transfer_date, amount, transaction_type) VALUES (?, ?, ?, ?, ?)")) {

            conn.setAutoCommit(false);

            withdrawStmt.setDouble(1, amount);
            withdrawStmt.setString(2, account_number);
            withdrawStmt.setDouble(3, amount);

            int rowsUpdated = withdrawStmt.executeUpdate();

            if (rowsUpdated > 0) {
                depositStmt.setDouble(1, amount);
                depositStmt.setString(2, toAccount);
                depositStmt.executeUpdate();

                transferStmt.setString(1, account_number);
                transferStmt.setString(2, toAccount);
                transferStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                transferStmt.setDouble(4, amount);
                transferStmt.setString(5, "Fund Transfer");
                transferStmt.executeUpdate();

                conn.commit();

                response.setContentType("text/html");
                response.getWriter().println("Fund Transfer Successful! Amount: " + amount + ", To Account: " + toAccount);
            } else {
                conn.rollback();
                response.setContentType("text/html");
                response.getWriter().println("Fund Transfer Failed! Insufficient balance.");
            }
            PrintWriter out = response.getWriter();
            out.println("<a href='customerDashboard.jsp'>Back to board</a>");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void handleMiniStatement(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String account_number = (String) session.getAttribute("account_number");

        if (account_number == null) {
            response.getWriter().println("Account number not found in session");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM ministatement WHERE from_account = ? OR to_account = ? ORDER BY transfer_date DESC LIMIT 10")) {

            stmt.setString(1, account_number);
            stmt.setString(2, account_number);

            ResultSet rs = stmt.executeQuery();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h3>Mini Statement:</h3>");
            out.println("<table border='1'><tr><th>From Account</th><th>To Account</th><th>Amount</th><th>Date</th><th>Transaction Type</th></tr>");

            while (rs.next()) {
                String fromAccount = rs.getString("from_account");
                String toAccount = rs.getString("to_account");
                double amount = rs.getDouble("amount");
                Timestamp transferDate = rs.getTimestamp("transfer_date");
                String transactionType = rs.getString("transaction_type");

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String formattedDate = dateFormat.format(transferDate);

                out.println("<tr><td>" + fromAccount + "</td><td>" + toAccount + "</td><td>" + amount + "</td><td>" + formattedDate + "</td><td>" + transactionType + "</td></tr>");
            }
            out.println("</table>");
            out.println("<a href='customerDashboard.jsp'>Back to board</a>");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void handleBalanceEnquiry(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String account_number = (String) session.getAttribute("account_number");

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement stmt = conn.prepareStatement("SELECT balance FROM customers WHERE account_number = ?")) {

            stmt.setString(1, account_number);
            ResultSet rs = stmt.executeQuery();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            if (rs.next()) {
                double balance = rs.getDouble("balance");
                out.println("Balance: " + balance);
            } else {
                out.println("Account not found!");
            }
            out.println("<a href='customerDashboard.jsp'>Back to board</a>");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void handleChangePIN(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String account_number = (String) session.getAttribute("account_number");
        String newPin = request.getParameter("new_pin");
        String inputUsername = (String) session.getAttribute("user_name");
        String inputPassword = request.getParameter("current_pin");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (account_number == null || newPin == null || inputUsername == null || inputPassword == null ) {
            out.println("Missing parameters.");
            out.print("<br>");
            out.println("<a href='customerDashboard.jsp'>Back to board</a>");
            return;
        }


        if (inputPassword.equals(newPin)) {
            out.println("PIN already exists.");
            out.print("<br>");
            out.println("<a href='customerDashboard.jsp'>Back to board</a>");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {

            String authQuery = "SELECT acc_no FROM pin WHERE user_name = ? AND password = ?";
            try (PreparedStatement authStmt = conn.prepareStatement(authQuery)) {
                authStmt.setString(1, inputUsername);
                authStmt.setString(2, inputPassword);

                try (ResultSet rs = authStmt.executeQuery()) {
                    if (rs.next()) {
                        String userAccNo = rs.getString("acc_no");

                        String updateQuery = "UPDATE pin SET password = ? WHERE acc_no = ?";
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                            updateStmt.setString(1, newPin);
                            updateStmt.setString(2, userAccNo);

                            int rowsUpdated = updateStmt.executeUpdate();

                            if (rowsUpdated > 0) {
                                out.println("PIN Change Successful!");
                            } else {
                                out.println("PIN Change Failed!");
                            }
                        }
                    } else {
                        out.println("Authentication Failed!");
                    }
                }
                out.println("<a href='customerDashboard.jsp'>Back to board</a>");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("An error occurred.");
        }
    }

    private void handleExit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        response.getWriter().println("Exit Successful! Thank you for using our service.");
    }
}
