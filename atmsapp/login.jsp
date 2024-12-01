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
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .login-box {
            border: 1px solid #ccc;
            padding: 20px;
            background-color: #fff;
            width: 100%;
            max-width: 400px;
            margin: auto;
        }
        footer {
            background-color: #343a40;
            color: #ffffff;
            text-align: center;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
    <script>
        function showFields() {
            var role = document.getElementById("userRole").value;
            document.getElementById("studentFields").style.display = (role === "Student") ? "block" : "none";
            document.getElementById("facultyFields").style.display = (role === "Faculty") ? "block" : "none";
            document.getElementById("adminFields").style.display = (role === "Admin") ? "block" : "none";
        }

        function validateForm() {
            var role = document.getElementById("userRole").value;
            if (role === "Student") {
                var usn = document.getElementById("usn").value;
                var prefix = "2BA23MC";
                var regex = new RegExp("^" + prefix + "(\\d{3})$"); // Ensure prefix and 3 digits
                var match = usn.match(regex);

                if (!match) {
                    alert("USN should start with '2BA23MC' followed by 001 to 060.");
                    return false;
                }

                var number = parseInt(match[1]);
                if (number < 1 || number > 60) {
                    alert("The last three digits of the USN should be between 001 and 060.");
                    return false;
                }
            }
            return true;
        }
    </script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">ATMS</a>
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
            <form method="post" onsubmit="return validateForm();">
                <div class="mb-3">
                    <label for="userRole" class="form-label">Role</label>
                    <select id="userRole" name="userRole" class="form-select" required onchange="showFields()">
                        <option value="" disabled selected>Select your role</option>
                        <option value="Admin">Admin</option>
                        <option value="Student">Student</option>
                        <option value="Faculty">Faculty</option>
                    </select>
                </div>

                <div id="adminFields" style="display:none;">
                    <div class="mb-3">
                        <label for="email" class="form-label">Admin Email</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Enter admin email">
                    </div>
                </div>

                <div id="studentFields" style="display:none;">
                    <div class="mb-3">
                        <label for="usn" class="form-label">USN</label>
                        <input type="text" class="form-control" id="usn" name="usn" placeholder="Enter your USN">
                    </div>
                </div>

                <div id="facultyFields" style="display:none;">
                    <div class="mb-3">
                        <label for="facultyId" class="form-label">Faculty ID</label>
                        <input type="text" class="form-control" id="facultyId" name="facultyId" placeholder="Enter your Faculty ID">
                    </div>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                </div>

                <button type="submit" class="btn btn-primary w-100">Login</button>

                <%
                    String role = request.getParameter("userRole");
                    String password = request.getParameter("password");
                    String email = request.getParameter("email");
                    String usn = request.getParameter("usn");
                    String facultyId = request.getParameter("facultyId");

                    if (password != null && role != null) {
                        Connection conn = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;

                        try {
                            String dbURL = "jdbc:mysql://localhost:3306/atms";
                            String dbUser = "root";
                            String dbPassword = "ROOT";
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                            boolean validUser = false;

                            if (role.equals("Admin")) {
                                String query = "SELECT * FROM ADMIN WHERE Email = ? AND Password = ?";
                                stmt = conn.prepareStatement(query);
                                stmt.setString(1, email);
                                stmt.setString(2, password);
                                rs = stmt.executeQuery();
                                if (rs.next()) {
                                    validUser = true;
                                }
                            } else if (role.equals("Student")) {
                                String query = "SELECT * FROM STUDENT_USER WHERE USN = ? AND Pw = ?";
                                stmt = conn.prepareStatement(query);
                                stmt.setString(1, usn);
                                stmt.setString(2, password);
                                rs = stmt.executeQuery();
                                if (rs.next()) {
                                    validUser = true;
                                }
                            } else if (role.equals("Faculty")) {
                                String query = "SELECT * FROM FACULTY_USER WHERE Faculty_Id = ? AND Pw = ?";
                                stmt = conn.prepareStatement(query);
                                stmt.setString(1, facultyId);
                                stmt.setString(2, password);
                                rs = stmt.executeQuery();
                                if (rs.next()) {
                                    validUser = true;
                                }
                            }

                            if (validUser) {
                                if (role.equals("Admin")) {
                                    response.sendRedirect("admin-home.jsp");
                                } else if (role.equals("Student")) {
                                    response.sendRedirect("student-home.jsp?usn=" + usn);
                                } else if (role.equals("Faculty")) {
                                    response.sendRedirect("faculty-home.jsp?facultyId=" + facultyId);
                                }
                            } else {
                                out.println("<div class='alert alert-danger'>Invalid credentials or role</div>");
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                        }
                    }
                %>
            </form>
        </div>
    </div>

    <footer>
        <div>© 2024 ATMS - All Rights Reserved</div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
