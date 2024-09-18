<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Student Profile</title>
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
                        <a class="nav-link" href="update_student_profile.jsp">Update Student</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="delete_student_profile.jsp">Delete Student</a>
                    </li>
        
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">View Student Profile</h4>
        <form action="view_students_profile.jsp" method="get">
            <div class="mb-3">
                <label for="usn" class="form-label">USN</label>
                <input type="text" name="usn" id="usn" class="form-control" placeholder="Enter USN" required>
            </div>
            <button type="submit" class="btn btn-primary">View Profile</button>
        </form>

        <!-- JSP Logic for displaying student profile -->
        <%
            String usn = request.getParameter("usn");
            if (usn != null && !usn.isEmpty()) {
                String dbUrl = "jdbc:mysql://localhost:3306/atms"; // Update with your DB name
                String dbUser = "root"; // Update with your DB username
                String dbPassword = "ROOT"; // Update with your DB password

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                    String sql = "SELECT * FROM STUDENT WHERE USN = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, usn);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        %>
                        <table class="table table-bordered">
                            <tr><th>USN</th><td><%= rs.getString("USN") %></td></tr>
                            <tr><th>Student Name</th><td><%= rs.getString("Student_Name") %></td></tr>
                            <tr><th>Date of Birth</th><td><%= rs.getDate("Student_DOB") %></td></tr>
                            <tr><th>Gender</th><td><%= rs.getString("Student_Gender") %></td></tr>
                            <tr><th>Email</th><td><%= rs.getString("Student_Email") %></td></tr>
                            <tr><th>Phone Number</th><td><%= rs.getString("Student_Phone_Number") %></td></tr>
                            <tr><th>Date of Admission</th><td><%= rs.getDate("Date_Of_Admission") %></td></tr>
                            <tr><th>Qualification</th><td><%= rs.getString("Student_Qualification") %></td></tr>
                            <tr><th>Address</th><td><%= rs.getString("Student_Address") %></td></tr>
                            <tr><th>Branch ID</th><td><%= rs.getInt("Branch_Id") %></td></tr>
                            <tr><th>Year of Study</th><td><%= rs.getString("Year_Of_Study") %></td></tr>
                        </table>
                        <%
                    } else {
                        %>
                        <div class="alert alert-warning">Student with USN <%= usn %> not found.</div>
                        <%
                    }

                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (SQLException | ClassNotFoundException e) {
                    %>
                    <div class="alert alert-danger">Error: <%= e.getMessage() %></div>
                    <%
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
