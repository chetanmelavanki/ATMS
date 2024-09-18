<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Branch</title>
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
                        <a class="nav-link" href="create_branch.jsp">Create Branch</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view_branches.jsp">View Branches</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="delete_branch.jsp">Delete Branch</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Update Branch</h4>
        <form method="post" action="update_branch.jsp">
            <div class="mb-3">
                <label for="branchId" class="form-label">Branch ID</label>
                <input type="number" id="branchId" name="branchId" class="form-control" placeholder="Branch ID" required>
            </div>
            <div class="mb-3">
                <label for="branchName" class="form-label">Branch Name</label>
                <input type="text" id="branchName" name="branchName" class="form-control" placeholder="Branch Name" required>
            </div>
            <div class="mb-3">
                <label for="course" class="form-label">Course</label>
                <input type="text" id="course" name="course" class="form-control" placeholder="Course" required>
            </div>
            <button type="submit" class="btn btn-primary">Update Branch</button>
        </form>

        <% 
        // Database connection details
        String jdbcUrl = "jdbc:mysql://localhost:3306/atms";
        String jdbcUser = "root";
        String jdbcPassword = "ROOT";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load database driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish connection
            conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

            // Check if the form has been submitted
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                // Retrieve form parameters
                int branchId = Integer.parseInt(request.getParameter("branchId"));
                String branchName = request.getParameter("branchName");
                String course = request.getParameter("course");

                // Update branch in the database
                String updateQuery = "UPDATE BRANCH SET Branch_Name = ?, Course = ? WHERE Branch_Id = ?";
                pstmt = conn.prepareStatement(updateQuery);
                pstmt.setString(1, branchName);
                pstmt.setString(2, course);
                pstmt.setInt(3, branchId);

                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<div class='alert alert-success' role='alert'>Branch updated successfully!</div>");
                } else {
                    out.println("<div class='alert alert-danger' role='alert'>Branch not found!</div>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger' role='alert'>Error: " + e.getMessage() + "</div>");
        } finally {
            // Close resources
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
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
