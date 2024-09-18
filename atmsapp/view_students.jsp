<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Student Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            background-color: #f8f9fa;
        }
        .container {
            flex: 1;
            max-width: 800px;
            margin-top: 20px;
        }
        footer {
            background-color: #343a40;
            color: #ffffff;
            padding: 10px 0;
            text-align: center;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">ATMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="admin-home.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="delete_student.jsp">Delete Student</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="update_student.jsp">Update Student</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="create_student.jsp">Create Students</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Student Users</h4>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Email</th>
                    <th>Password</th>
                    <th>Role</th>
                    <th>USN</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Database connection variables
                    String dbUrl = "jdbc:mysql://localhost:3306/atms";
                    String dbUser = "root";
                    String dbPassword = "ROOT";
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        // Load MySQL JDBC Driver
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Establish the connection
                        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                        // Create a statement to execute SQL queries
                        stmt = conn.createStatement();

                        // SQL query to fetch data from STUDENT_USER table
                        String sql = "SELECT Email, Pw, Student_Role, USN FROM STUDENT_USER";

                        // Execute the query and get the result set
                        rs = stmt.executeQuery(sql);

                        // Loop through the result set and display data in the table
                        while (rs.next()) {
                            String email = rs.getString("Email");
                            String password = rs.getString("Pw");
                            String role = rs.getString("Student_Role");
                            String usn = rs.getString("USN");

                            // Output each row in the table
                            out.println("<tr><td>" + email + "</td><td>" + password + "</td><td>" + role + "</td><td>" + usn + "</td></tr>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        // Close the result set, statement, and connection
                        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
