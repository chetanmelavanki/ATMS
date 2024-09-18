<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Faculty User</title>
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
                        <a class="nav-link" href="create_faculty.jsp">Create Faculty</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view_faculties.jsp">View Faculties</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Update Faculty User</h4>
        <form action="update_faculty.jsp" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" name="email" id="email" class="form-control" placeholder="user@example.com" required>
            </div>
            <div class="mb-3">
                <label for="facultyId" class="form-label">Faculty ID</label>
                <input type="text" name="facultyId" id="facultyId" class="form-control" placeholder="Faculty ID" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" name="password" id="password" class="form-control">
                <small class="form-text text-muted">Leave blank to keep the current password.</small>
            </div>
            <button type="submit" class="btn btn-primary">Update Faculty User</button>
        </form>

        <!-- JSP Logic for handling form submission -->
        <%
            // Handling form submission
            String email = request.getParameter("email");
            String facultyId = request.getParameter("facultyId");
            String password = request.getParameter("password");
            String message = "";

            // Database connection details
            String dbUrl = "jdbc:mysql://localhost:3306/atms"; // Update with your DB name
            String dbUser = "root"; // Update with your DB username
            String dbPassword = "ROOT"; // Update with your DB password

            if (email != null && facultyId != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                    // Update query to change faculty details
                    String sql = "UPDATE FACULTY_USER SET Faculty_Id = ?, Pw = IF(? = '', Pw, ?) WHERE Email = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, facultyId);

                    if (password == null || password.isEmpty()) {
                        stmt.setNull(2, Types.VARCHAR); // If password is not provided, leave unchanged
                        stmt.setNull(3, Types.VARCHAR);
                    } else {
                        stmt.setString(2, password); // Set new password if provided
                        stmt.setString(3, password);
                    }
                    stmt.setString(4, email);

                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        message = "Faculty user updated successfully!";
                    } else {
                        message = "Error: Faculty user not found or update failed.";
                    }

                    stmt.close();
                    conn.close();
                } catch (SQLException | ClassNotFoundException e) {
                    message = "Error: " + e.getMessage();
                }
            }

            // Display the result message
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
