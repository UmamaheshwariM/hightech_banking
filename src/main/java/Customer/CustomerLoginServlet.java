package Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.Serial;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
    @Serial()
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String admin_Id = request.getParameter("account_number");
        String user_name = request.getParameter("user_name");
        String admin_Password = request.getParameter("password");
        System.out.println(admin_Id + " " + admin_Password);

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "1234");
            String query = "SELECT * FROM pin WHERE  acc_no = ? AND password = ? AND user_name = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, admin_Id);
            ps.setString(2, admin_Password);
            ps.setString(3, user_name);
            rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("account_number", admin_Id);
                session.setAttribute("user_name", user_name);
                response.sendRedirect("customerDashboard.jsp");
            } else {
                response.sendRedirect("customerLogin.jsp");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println(e.getMessage());
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
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }
}