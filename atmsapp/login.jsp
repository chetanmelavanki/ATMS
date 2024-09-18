<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .login-box {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            width: 100%;
            max-width: 400px;
            margin: 20px auto;
        }
        .login-box h3 {
            font-size: 1.5rem;
        }
        .login-box .form-label {
            font-weight: 500;
        }
        .login-box .btn-primary {
            font-size: 1rem;
        }
        .login-box .alert {
            margin-top: 10px;
        }
        footer {
            background-color: #343a40;
            color: #ffffff;
            padding: 10px 0;
            text-align: center;
            width: 100%;
            position: relative;
            bottom: 0;
            margin-top: auto;
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
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container d-flex justify-content-center align-items-center flex-grow-1">
        <div class="login-box">
            <h3 class="text-center mb-4">Login</h3>

            <form method="post">
                <div class="mb-3">
                    <label for="email" class="form-label">Email address</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                </div>
                <div class="mb-3">
                    <label for="userRole" class="form-label">Role</label>
                    <select id="userRole" name="userRole" class="form-select" required>
                        <option value="" disabled selected>Select your role</option>
                        <option value="Admin">Admin</option>
                        <option value="Student">Student</option>
                        <option value="Faculty">Faculty</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary w-100">Login</button>
                <%
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    String role = request.getParameter("userRole");

                    if (email != null && password != null && role != null) {
                        Connection conn = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;

                        try {
                            // Database connection details
                            String dbURL = "jdbc:mysql://localhost:3306/atms";
                            String dbUser = "root";
                            String dbPassword = "ROOT";

                            // Load the database driver (MySQL in this case)
                            Class.forName("com.mysql.cj.jdbc.Driver");

                            // Establish the connection
                            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                            boolean validUser = false;
                            String dbRole = "";

                            if (role.equals("Admin")) {
                                // Query to check admin credentials
                                String query = "SELECT * FROM ADMIN WHERE Email = ? AND Password = ?";
                                stmt = conn.prepareStatement(query);
                                stmt.setString(1, email);
                                stmt.setString(2, password);
                                rs = stmt.executeQuery();

                                if (rs.next()) {
                                    validUser = true;
                                    dbRole = rs.getString("Role");
                                }
                            } else if (role.equals("Student")) {
                                // Query to check student credentials
                                String query = "SELECT * FROM STUDENT_USER WHERE Email = ? AND Pw = ?";
                                stmt = conn.prepareStatement(query);
                                stmt.setString(1, email);
                                stmt.setString(2, password);
                                rs = stmt.executeQuery();

                                if (rs.next()) {
                                    validUser = true;
                                    dbRole = "Student"; // For students, the role is fixed as 'Student'
                                }
                            } else if (role.equals("Faculty")) {
                                // Query to check faculty credentials (assuming a similar table exists for faculty)
                                String query = "SELECT * FROM FACULTY WHERE Email = ? AND Pw = ?";
                                stmt = conn.prepareStatement(query);
                                stmt.setString(1, email);
                                stmt.setString(2, password);
                                rs = stmt.executeQuery();

                                if (rs.next()) {
                                    validUser = true;
                                    dbRole = rs.getString("Role");
                                }
                            }

                            if (validUser) {
                                // Redirect to the appropriate home page based on the role
                                if (role.equals("Admin")) {
                                    response.sendRedirect("admin-home.jsp");
                                } else if (role.equals("Student")) {
                                    response.sendRedirect("student-home.jsp");
                                } else if (role.equals("Faculty")) {
                                    response.sendRedirect("faculty-home.jsp");
                                }
                            } else {
                                out.println("<div class='alert alert-danger'>Invalid email, password, or role</div>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<div class='alert alert-danger'>Error occurred: " + e.getMessage() + "</div>");
                        } finally {
                            // Close resources
                            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    }
                %>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
