<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Faculty Profile</title>
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
                        <a class="nav-link" href="update_faculty_profile.jsp">Update Faculty</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="create_faculty_profile.jsp">Create Faculty</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view_faculties_profile.jsp">View Faculties</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Delete Faculty Profile</h4>
        <form action="delete_faculty_profile.jsp" method="post">
            <div class="mb-3">
                <label for="facultyId" class="form-label">Faculty ID</label>
                <input type="text" name="facultyId" id="facultyId" class="form-control" placeholder="Faculty ID" required>
            </div>
            <button type="submit" class="btn btn-danger">Delete Faculty Profile</button>
        </form>

        <!-- JSP Logic for handling form submission -->
        <%
            String facultyId = request.getParameter("facultyId");
            String message = "";

            String dbUrl = "jdbc:mysql://localhost:3306/atms"; // Update with your DB name
            String dbUser = "root"; // Update with your DB username
            String dbPassword = "ROOT"; // Update with your DB password

            if (facultyId != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                    // Prepare SQL statement for deleting faculty details
                    String sql = "DELETE FROM FACULTY WHERE Faculty_Id = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, facultyId);

                    int rowsDeleted = stmt.executeUpdate();
                    if (rowsDeleted > 0) {
                        message = "Faculty profile deleted successfully!";
                    } else {
                        message = "Error: Faculty not found or delete failed.";
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
