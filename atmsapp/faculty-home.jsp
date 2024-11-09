<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String facultyId = request.getParameter("facultyId");
    String facultyName = "";

    try {
        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/atms";  // Change this to your database name
        String dbUser = "root";  // Change to your database username
        String dbPass = "ROOT";  // Change to your database password

        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Query to fetch faculty name
        String query = "SELECT Faculty_Name FROM FACULTY WHERE Faculty_Id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, facultyId);

        // Execute query and fetch faculty name
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            facultyName = resultSet.getString("Faculty_Name");  // Fetch the faculty name from the correct column
        }

        // Close all connections
        resultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .faculty-dashboard {
            padding: 20px;
        }
        .card {
            margin: 10px 0;
        }
        /* Custom navbar color */
        .navbar-custom {
            background-color: #007bff; /* Change this color as needed */
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light navbar-custom">
        <div class="container">
            <a class="navbar-brand text-white" href="#">Faculty Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="faculty_profile.jsp?facultyId=<%= facultyId %>">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="index.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="faculty-dashboard container mt-4">
        <h2>Welcome, <%= facultyName %>!</h2>
        <p>Your Faculty ID is: <strong><%= facultyId %></strong></p>

        <div class="row">
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Manage Events</h5>
                        <p class="card-text">Create, update, and delete events.</p>
                        <a href="faculty_events.jsp?facultyId=<%= facultyId %>" class="btn btn-primary">Go to Events</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Manage Subjects</h5>
                        <p class="card-text">View and edit subject details.</p>
                        <a href="manage-subjects.jsp?facultyId=<%= facultyId %>" class="btn btn-primary">Go to Subjects</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Manage Students</h5>
                        <p class="card-text">View and manage student profiles.</p>
                        <a href="manage-students.jsp?facultyId=<%= facultyId %>" class="btn btn-primary">Go to Students</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
