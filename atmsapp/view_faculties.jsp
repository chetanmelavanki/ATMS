<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Faculty Users</title>
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
                        <a class="nav-link" href="delete_faculty.jsp">Delete Faculty</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="update_faculty.jsp">Update Faculty</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="create_faculty.jsp">Create Faculty</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Faculty Users</h4>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Faculty ID</th>
                    <th>Password</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database connection details
                    String dbUrl = "jdbc:mysql://localhost:3306/atms"; // Update with your DB name
                    String dbUser = "root"; // Update with your DB username
                    String dbPassword = "ROOT"; // Update with your DB password

                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        // Load the MySQL JDBC driver
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                        // Query to fetch faculty users
                        String sql = "SELECT Faculty_Id, Pw FROM FACULTY_USER";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();

                        // Loop through the result set and display each faculty user in the table
                        while (rs.next()) {
                            String facultyId = rs.getString("Faculty_Id");
                            String password = rs.getString("Pw"); // Fetch the password
                %>
                            <tr>
                                <td><%= facultyId != null ? facultyId : "N/A" %></td>
                                <td><%= password != null ? password : "N/A" %></td> <!-- Display the password -->
                            </tr>
                <%
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace();
                    } finally {
                        // Close the database resources
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
