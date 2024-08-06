package Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.*;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String user_name = request.getParameter("user_name");
        String full_name = request.getParameter("full_name");
        String account_type = request.getParameter("account_type");
        String phone_number = request.getParameter("phone_number");
        String gender = request.getParameter("gender");
        Date DOB = Date.valueOf(request.getParameter("DOB"));
        String email = request.getParameter("email");
        String ID_Proof = request.getParameter("ID_Proof");
        String address = request.getParameter("address");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "1234");

            if (isUserExists(con, user_name, email)) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                out.println("<h2>Registration Failed!</h2>");
                out.println("<p>User already exists with the same username or email.</p>");
                out.println("<p><a href=\"adminDashboard.jsp\">Back to Admin Dashboard</a></p>");
                out.println("</body></html>");
                return;
            }

            String query = "INSERT INTO customers (user_name, full_name, account_type, phone_number, gender, DOB, email, ID_Proof, address, initial_amount, balance) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
            ps = con.prepareStatement(query);

            ps.setString(1, user_name);
            ps.setString(2, full_name);
            ps.setString(3, account_type);
            ps.setString(4, phone_number);
            ps.setString(5, gender);
            ps.setDate(6, DOB);
            ps.setString(7, email);
            ps.setString(8, ID_Proof);
            ps.setString(9, address);
            ps.setDouble(10, 1000.00);
            ps.setDouble(11, 1000.00);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                // Registration successful
//                int password = generateNumber(4);
//                System.out.println("Generated PIN: " + password);

                HttpSession session = request.getSession();
                session.setAttribute("Success", "Registration Successful");
                session.setAttribute("Message", "Thank you for registering! Your account has been created successfully");
                response.sendRedirect("reg_success.jsp");
            } else {
                response.sendRedirect("adminDashboard.jsp");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println(e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static int generateNumber(int length) {
        String characters = "123456789";
        return Integer.parseInt(generateRandomString(characters, length));
    }

    private static String generateRandomString(String characters, int length) {
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(characters.length());
            sb.append(characters.charAt(randomIndex));
        }
        return sb.toString();
    }


    private boolean isUserExists(Connection con, String username, String email) throws SQLException {
        String query = "SELECT COUNT(*) AS count FROM customers WHERE user_name = ? OR email = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int count = rs.getInt("count");
            return count > 0;
        }
        return false;
    }
}