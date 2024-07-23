package Database;

import java.sql.*;

public class Database {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    public double fetchBalance(int account_no) throws SQLException {
        PreparedStatement statement = null;
        ResultSet rs = statement.executeQuery(
                "SELECT balance from customers where account_no = " + account_no
        );
        rs.next();
        return rs.getDouble("balance");
    }
}
