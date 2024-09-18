<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Student Profile</title>
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
                        <a class="nav-link" href="create_student_profile.jsp">Create Student</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view_students_profile.jsp">View Student</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="update_student_profile.jsp">Update Student</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view_students_profile.jsp">View Students</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Delete Student Profile</h4>
        <form action="delete_student_profile.jsp" method="post">
            <div class="mb-3">
                <label for="usn" class="form-label">USN</label>
                <input type="text" name="usn" id="usn" class="form-control" placeholder="Enter USN" required>
            </div>
            <button type="submit" class="btn btn-danger">Delete Profile</button>
        </form>

        <!-- JSP Logic for handling form submission -->
        <%
            String usn = request.getParameter("usn");
            String message = "";

            if (usn != null && !usn.isEmpty()) {
                String dbUrl = "jdbc:mysql://localhost:3306/atms"; // Update with your DB name
                String dbUser = "root"; // Update with your DB username
                String dbPassword = "ROOT"; // Update with your DB password

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                    String sql = "DELETE FROM STUDENT WHERE USN = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, usn);
                    int rowsDeleted = stmt.executeUpdate();
                    
                    if (rowsDeleted > 0) {
                        message = "Student profile deleted successfully!";
                    } else {
                        message = "Error: Student profile deletion failed.";
                    }

                    stmt.close();
                    conn.close();
                } catch (SQLException | ClassNotFoundException e) {
                    message = "Error: " + e.getMessage();
                }
            }

            if (!message.isEmpty()) {
        %>
                <div class="alert alert-info"><%= message %></div>
        <%
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
