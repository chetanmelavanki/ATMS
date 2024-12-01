<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String usn = request.getParameter("usn");
    String studentName = "";

    try {
        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/atms";  // Change this to your database name
        String dbUser = "root";  // Change to your database username
        String dbPass = "ROOT";  // Change to your database password

        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Query to fetch student name
        String query = "SELECT Student_Name FROM STUDENT WHERE USN = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, usn);

        // Execute query and fetch student name
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            studentName = resultSet.getString("Student_Name");  // Use correct column name
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
    <title>Student Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .student-dashboard {
            padding: 30px;
        }
        .card {
            margin-bottom: 20px;
        }
        footer {
            background-color: #343a40;
            color: white;
            padding: 10px 0;
        }
        .nav-link {
            font-weight: bold;
        }
        .nav-link:hover {
            color: #007bff;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="#">Student Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="student_profile.jsp?usn=<%= usn %>">Student Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Dashboard Content -->
    <div class="container student-dashboard">
        <h1 class="text-center">Welcome, <%= studentName %></h1>  <!-- Displaying the fetched student name -->
        <p class="text-center">Manage your courses, view your assessments, and access other resources below.</p>

        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Manage Subjects</h5>
                        <p class="card-text">View and manage your enrolled courses. Update your preferences and more.</p>
                        <a href="subject-allocation.jsp?usn=<%= usn %>" class="btn btn-primary">Go to Subjects</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">View Assessments</h5>
                        <p class="card-text">Check your upcoming assessments and track your performance.</p>
                        <a href="view_students_assessments.jsp?usn=<%= usn %>" class="btn btn-primary">View Assessments</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Upcoming Events</h5>
                        <p class="card-text">Stay updated with the latest events and activities in your institution.</p>
                        <!-- Add the student USN as a parameter -->
                        <a href="events.jsp?usn=<%= usn %>" class="btn btn-primary">View Events</a>
                    </div>
                </div>
            </div>
            
        </div>
    </div>

    <footer>
        <div class="text-center">© 2024 ATMS - All Rights Reserved</div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
