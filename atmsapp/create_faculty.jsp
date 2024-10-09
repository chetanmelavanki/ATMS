<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Faculty User</title>
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
                        <a class="nav-link" href="view_faculties.jsp">View Faculties</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Create New Faculty User</h4>
        
        <!-- JSP Logic to handle form submission and DB insertion -->
        <%
            String password = request.getParameter("password");
            String facultyId = request.getParameter("facultyId");
            String facultyRole = request.getParameter("facultyRole"); // Role selected by the user

            String dbUrl = "jdbc:mysql://localhost:3306/atms"; // Update with your DB name
            String dbUser = "root"; // Update with your DB username
            String dbPassword = "ROOT"; // Update with your DB password
            String message = "";

            if (password != null && facultyId != null && facultyRole != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                    String sql = "INSERT INTO FACULTY_USER (Pw, Faculty_Role, Faculty_Id) VALUES (?, ?, ?)";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, password);
                    stmt.setString(2, facultyRole);
                    stmt.setString(3, facultyId);

                    int rowsInserted = stmt.executeUpdate();
                    if (rowsInserted > 0) {
                        message = "Faculty user created successfully!";
                    }

                    stmt.close();
                    conn.close();
                } catch (SQLException | ClassNotFoundException e) {
                    message = "Error: " + e.getMessage();
                }
            }
        %>

        <!-- Display the result message -->
        <div class="alert alert-info"><%= message %></div>

        <!-- Form to Create Faculty User -->
        <form action="create_faculty.jsp" method="post">
             <!-- Faculty Role -->
             <div class="mb-3">
                <label for="facultyRole" class="form-label">Role</label>
                <select name="facultyRole" id="facultyRole" class="form-select" required>
                    <option value="Faculty" selected>Faculty</option>
                </select>
            </div>
            
            <!-- Faculty ID -->
            <div class="mb-3">
                <label for="facultyId" class="form-label">Faculty ID</label>
                <input type="text" name="facultyId" id="facultyId" class="form-control" placeholder="Faculty ID" required>
            </div>
            
           
            
            <!-- Password -->
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" name="password" id="password" class="form-control" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Create Faculty User</button>
        </form>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
