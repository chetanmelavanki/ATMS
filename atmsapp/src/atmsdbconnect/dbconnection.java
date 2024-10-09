 package atmsdbconnect;// Make sure to replace 'yourpackage' with the actual package name

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/atms";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "ROOT";
    private static Connection conn = null;

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        if (conn == null || conn.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            } catch (SQLException e) {
                e.printStackTrace();
                throw e;
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                throw e;
            }
        }
        return conn;
    }

    public static void closeConnection() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
