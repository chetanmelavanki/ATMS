<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Student User</title>
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
                        <a class="nav-link" href="view_students.jsp">View Students</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Create New Student User</h4>
        <form method="post" action="create_student.jsp">
            <div class="mb-3">
                <label for="studentRole" class="form-label">Role</label>
                <select id="studentRole" class="form-select" disabled>
                    <option value="Student" selected>Student</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="usn" class="form-label">USN</label>
                <input type="text" id="usn" name="usn" class="form-control" placeholder="Enter USN" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Create Student User</button>
        </form>

        <%-- Handle form submission --%>
        <%
            String dbUrl = "jdbc:mysql://localhost:3306/atms"; // Change to your database URL
            String dbUser = "root"; // Change to your database username
            String dbPassword = "ROOT"; // Change to your database password

            // Get form parameters
            String usn = request.getParameter("usn");
            String userPassword = request.getParameter("password");

            if (usn != null && userPassword != null) {
                Connection conn = null;
                PreparedStatement stmt = null;
                try {
                    // Establish a connection
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure you have the MySQL JDBC driver
                    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                    // SQL statement to insert data
                    String sql = "INSERT INTO STUDENT_USER (USN, Pw, Student_Role) VALUES (?, ?, 'Student')";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, usn);
                    stmt.setString(2, userPassword);

                    // Execute the insert operation
                    int rowsInserted = stmt.executeUpdate();
                    if (rowsInserted > 0) {
                        out.println("<div class='alert alert-success'>Student user created successfully!</div>");
                    } else {
                        out.println("<div class='alert alert-danger'>Failed to create student user.</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                } finally {
                    try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
