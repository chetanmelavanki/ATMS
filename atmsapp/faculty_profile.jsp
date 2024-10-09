<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa; /* Light background color */
        }
        .navbar-custom {
            background-color: #007bff; /* Custom navbar color */
        }
        .table {
            background-color: white; /* White background for the table */
            border-radius: 5px; /* Rounded corners */
        }
        .container {
            padding: 20px; /* Padding for the container */
            margin-top: 20px; /* Margin for the top */
        }
        .alert {
            margin-top: 20px; /* Margin for alert messages */
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light navbar-custom">
        <div class="container">
            <a class="navbar-brand text-white" href="#">Faculty Profile</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="faculty-home.jsp?facultyId=<%= request.getParameter("facultyId") %>">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="index.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h3>Faculty Profile</h3>
        <%
            String facultyId = request.getParameter("facultyId");

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                String dbURL = "jdbc:mysql://localhost:3306/atms";
                String dbUser = "root";
                String dbPassword = "ROOT";
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                String query = "SELECT * FROM FACULTY WHERE Faculty_Id = ?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, facultyId);
                rs = stmt.executeQuery();

                if (rs.next()) {
        %>
        <table class="table table-bordered">
            <tr>
                <th>Name</th>
                <td><%= rs.getString("Faculty_Name") %></td>
            </tr>
            <tr>
                <th>Email</th>
                <td><%= rs.getString("Faculty_Email") %></td>
            </tr>
            <tr>
                <th>Department</th>
                <td><%= rs.getString("Branch_Id") %></td>
            </tr>
            <tr>
                <th>Phone Number</th>
                <td><%= rs.getString("Faculty_Phone_No") %></td>
            </tr>
            <tr>
                <th>Designation</th>
                <td><%= rs.getString("Designation") %></td>
            </tr>
            <tr>
                <th>Joining Date</th>
                <td><%= rs.getDate("Joining_Date") %></td>
            </tr>
        </table>
        <%
                } else {
                    out.println("<div class='alert alert-danger'>Faculty not found.</div>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
