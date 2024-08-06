package Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.sql.*;

@WebServlet("/ManagementServlet")
public class ManagementServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "1234");

            if ("view".equals(action)) {
                String query = "SELECT account_number, user_name, full_name, address, phone_number, email, account_type, DOB, ID_Proof FROM customers";
                ps = con.prepareStatement(query);
                rs = ps.executeQuery();

                out.println("<h2>View Customers</h2>");
                out.println("<table border='1'>");
                out.println("<tr>");
                out.println("<th>Account Number</th>");
                out.println("<th>User Name</th>");
                out.println("<th>Full Name</th>");
                out.println("<th>Address</th>");
                out.println("<th>Phone Number</th>");
                out.println("<th>Email</th>");
                out.println("<th>Account Type</th>");
                out.println("<th>DOB</th>");
                out.println("<th>ID Proof</th>");
                out.println("<th>Action</th>");
                out.println("</tr>");

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("account_number") + "</td>");
                    out.println("<td>" + rs.getString("user_name") + "</td>");
                    out.println("<td>" + rs.getString("full_name") + "</td>");
                    out.println("<td>" + rs.getString("address") + "</td>");
                    out.println("<td>" + rs.getString("phone_number") + "</td>");
                    out.println("<td>" + rs.getString("email") + "</td>");
                    out.println("<td>" + rs.getString("account_type") + "</td>");
                    out.println("<td>" + rs.getDate("DOB") + "</td>");
                    out.println("<td>" + rs.getString("ID_Proof") + "</td>");
                    out.println("<td>");
                    out.println("<a href='ManagementServlet?action=modify&user_name=" + rs.getString("user_name") + "'>Modify</a>");
                    out.println("&nbsp;&nbsp;");
                    out.println("<a href='ManagementServlet?action=delete&user_name=" + rs.getString("user_name") + "'>Delete</a>");
                    out.println("</td>");
                    out.println("</tr>");
                }

                out.println("</table>");
                out.println("<br>");
                out.println("<a href='adminDashboard.jsp'>Back to Dashboard</a>");

            } else if ("modify".equals(action)) {
                String user_name = request.getParameter("user_name");
                String full_name = request.getParameter("full_name");
                String address = request.getParameter("address");
                String phone_number = request.getParameter("phone_number");
                String email = request.getParameter("email");
                String account_type = request.getParameter("account_type");
                String dob = request.getParameter("DOB");
                String id_proof = request.getParameter("ID_Proof");

                String query = "UPDATE customers SET full_name=?, address=?, phone_number=?, email=?, account_type=?, DOB=?, ID_Proof=? WHERE user_name=?";
                ps = con.prepareStatement(query);
                ps.setString(1, full_name);
                ps.setString(2, address);
                ps.setString(3, phone_number);
                ps.setString(4, email);
                ps.setString(5, account_type);
                ps.setString(6, dob);
                ps.setString(7, id_proof);
                ps.setString(8, user_name);

                int result = ps.executeUpdate();
                HttpSession session = null;
                if (result > 0) {
                    session = request.getSession();
                    session.setAttribute("Success", "Modify Customer Information");
                    session.setAttribute("Message", "Customer details updated successfully");
                    response.sendRedirect("reg_success.jsp");
//                    out.println("<p>Customer details updated successfully</p>");
                } else {
                    session.setAttribute("Error", "Modify Customer Information");
                    session.setAttribute("Message", "Customer details updated successfully");
                    response.sendRedirect("reg_success.jsp");
//                    out.println("<p>Error updating customer details.</p>");
                }
                out.println("<br>");
                out.println("<a href='adminDashboard.jsp'>Back to Dashboard</a>");

            } else if ("delete".equals(action)) {
                String user_name = request.getParameter("user_name");

                String query = "DELETE FROM customers WHERE user_name=?";
                ps = con.prepareStatement(query);
                ps.setString(1, user_name);

                int result = ps.executeUpdate();
                HttpSession session = null;
                if (result > 0) {
                    session = request.getSession();
                    session.setAttribute("Success", "Delete Customer Information");
                    session.setAttribute("Message", "Customer deleted successfully");
                    response.sendRedirect("reg_success.jsp");

                } else {
                    session.setAttribute("Error", "Delete Customer Information");
                    session.setAttribute("Message", "Error deleting customer");
                    response.sendRedirect("reg_success.jsp");

                }
                out.println("<br>");
                out.println("<a href='adminDashboard.jsp'>Back to Dashboard</a>");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Forward POST requests to doGet
    }
}