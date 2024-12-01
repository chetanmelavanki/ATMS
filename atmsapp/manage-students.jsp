<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<%
    // Retrieve facultyId from request parameters
    String facultyId = request.getParameter("facultyId");

    // Handle the update request
    String message = null;
    String error = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String usn = request.getParameter("usn");
        String name = request.getParameter("name");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String year = request.getParameter("year");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/atms", "root", "ROOT")) {
            String updateQuery = "UPDATE STUDENT SET Student_Name = ?, Student_DOB = ?, Student_Gender = ?, Student_Email = ?, Student_Phone_Number = ?, Year_Of_Study = ? WHERE USN = ?";
            try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                updateStmt.setString(1, name);
                updateStmt.setString(2, dob);
                updateStmt.setString(3, gender);
                updateStmt.setString(4, email);
                updateStmt.setString(5, phone);
                updateStmt.setString(6, year);
                updateStmt.setString(7, usn);
                updateStmt.executeUpdate();
                message = "Student details updated successfully!";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            error = "Failed to update student details: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Students</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar-custom {
            background-color: #007bff;
            padding: 0.5rem 1rem;
        }
        .navbar-brand, .nav-link {
            color: #ffffff !important;
            font-weight: 500;
        }
        .container {
            margin-top: 5px;
        }
        footer {
            background-color: #343a40;
            padding: 1rem;
            text-align: center;
            margin-top: 30px;
            border-top: 1px solid #ddd;
            font-size: 0.9rem;
            color: white;
        }
        h3 {
            color: #004085;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="#">Faculty Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="faculty-home.jsp?facultyId=<%= facultyId %>">Home</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <h3>Manage Students</h3>

    <% if (message != null) { %>
        <div class="alert alert-success"><%= message %></div>
    <% } else if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>USN</th>
                <th>Name</th>
                <th>DOB</th>
                <th>Gender</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Year</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    String dbURL = "jdbc:mysql://localhost:3306/atms";
                    String dbUser = "root";
                    String dbPassword = "ROOT";
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String studentQuery = "SELECT * FROM STUDENT WHERE Branch_Id IN (SELECT Branch_Id FROM FACULTY WHERE Faculty_Id = ?)";
                    stmt = conn.prepareStatement(studentQuery);
                    stmt.setString(1, facultyId);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        do {
                            String usn = rs.getString("USN");
            %>
                            <tr>
                                <form method="POST" action="manage-students.jsp?facultyId=<%= facultyId %>">
                                    <td><%= usn %></td>
                                    <td><input type="text" name="name" value="<%= rs.getString("Student_Name") %>" class="form-control"></td>
                                    <td><input type="date" name="dob" value="<%= rs.getDate("Student_DOB") %>" class="form-control"></td>
                                    <td>
                                        <select name="gender" class="form-select">
                                            <option value="Male" <%= rs.getString("Student_Gender").equals("Male") ? "selected" : "" %>>Male</option>
                                            <option value="Female" <%= rs.getString("Student_Gender").equals("Female") ? "selected" : "" %>>Female</option>
                                            <option value="Other" <%= rs.getString("Student_Gender").equals("Other") ? "selected" : "" %>>Other</option>
                                        </select>
                                    </td>
                                    <td><input type="email" name="email" value="<%= rs.getString("Student_Email") %>" class="form-control"></td>
                                    <td><input type="text" name="phone" value="<%= rs.getString("Student_Phone_Number") %>" class="form-control"></td>
                                    <td><input type="text" name="year" value="<%= rs.getString("Year_Of_Study") %>" class="form-control"></td>
                                    <td>
                                        <input type="hidden" name="usn" value="<%= usn %>">
                                        <button type="submit" class="btn btn-success btn-sm">Save</button>
                                    </td>
                                </form>
                            </tr>
            <%
                        } while (rs.next());
                    } else {
            %>
                        <tr>
                            <td colspan="8" class="text-center">No students found.</td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <tr>
                    <td colspan="8" class="text-center text-danger">Error: <%= e.getMessage() %></td>
                </tr>
            <%
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </tbody>
    </table>
</div>

<footer>
    <p>&copy; 2024 Faculty Management System. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
