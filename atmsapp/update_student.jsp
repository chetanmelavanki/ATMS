<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Student User</title>
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
                        <a class="nav-link" href="create_student.jsp">Create Student</a>
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
        <h4 class="mb-4">Update Student User</h4>

        <form action="update_student.jsp" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="user@example.com" required>
            </div>
            <div class="mb-3">
                <label for="studentRole" class="form-label">Role</label>
                <select id="studentRole" class="form-select" disabled>
                    <option value="Student" selected>Student</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="usn" class="form-label">USN</label>
                <input type="text" id="usn" name="usn" class="form-control" placeholder="USN" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control">
                <small class="form-text text-muted">Leave blank to keep the current password.</small>
            </div>
            <button type="submit" class="btn btn-primary">Update Student User</button>
        </form>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%
    // Handle form submission and database update
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String email = request.getParameter("email");
        String usn = request.getParameter("usn");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/atms";
            String dbUser = "root";
            String dbPassword = "ROOT";
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Check if the student exists
            String checkSql = "SELECT Pw FROM STUDENT_USER WHERE Email = ?";
            stmt = conn.prepareStatement(checkSql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Get the current password
                String currentPassword = rs.getString("Pw");

                // If no new password provided, keep the current password
                if (password == null || password.isEmpty()) {
                    password = currentPassword;
                }

                // Update student details
                String updateSql = "UPDATE STUDENT_USER SET Pw = ?, USN = ? WHERE Email = ?";
                stmt = conn.prepareStatement(updateSql);
                stmt.setString(1, password);
                stmt.setString(2, usn);
                stmt.setString(3, email);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<div class='alert alert-success'>Student user updated successfully!</div>");
                } else {
                    out.println("<div class='alert alert-danger'>Error updating student user.</div>");
                }
            } else {
                out.println("<div class='alert alert-danger'>Student with email " + email + " not found.</div>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger'>An error occurred while updating the student user.</div>");
        } finally {
            // Close resources
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>
