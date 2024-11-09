<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String usn = request.getParameter("usn");  // Retrieve 'usn' parameter
    String studentName = "";
    String message = "";

    if (usn != null && !usn.isEmpty()) {
        try {
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/atms";  // Update with your DB name
            String dbUser = "root";  // Update with your DB username
            String dbPass = "ROOT";  // Update with your DB password

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

            // Close the result set and statement
            resultSet.close();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred while fetching student details.";
        }
    } else {
        message = "Student USN not found!";
    }

    // Handling subject allocation form submission
    if (request.getMethod().equalsIgnoreCase("POST") && usn != null && !usn.isEmpty()) {
        String subjectCode = request.getParameter("subjectCode");
        String academicYear = request.getParameter("academicYear");
        String dateOfAdmission = request.getParameter("dateOfAdmission");
        String semester = request.getParameter("semester");

        try {
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/atms";
            String dbUser = "root";
            String dbPass = "ROOT";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Insert query for subject allocation
            String insertQuery = "INSERT INTO STUDENT_ALLOCATED (USN, Subject_Code, Date_Of_Admission, Academic_Year, Sem) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(insertQuery);
            statement.setString(1, usn);
            statement.setString(2, subjectCode);
            statement.setString(3, dateOfAdmission);
            statement.setString(4, academicYear);
            statement.setInt(5, Integer.parseInt(semester));

            int result = statement.executeUpdate();
            if (result > 0) {
                message = "Subject allocated successfully!";
            } else {
                message = "Failed to allocate subject.";
            }

            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred during subject allocation.";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Subject Allocation</title>
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
            <a class="navbar-brand" href="#">Student Subject Allocate</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="student-home.jsp?usn=<%= usn %>">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
<div class="container mt-4">
    <h2 class="text-center">Subject Allocation for <%= studentName %> (<%= usn %>)</h2>
    <p class="text-center text-success"><%= message %></p>
    
    <form method="post" class="mt-4">
        <input type="hidden" name="usn" value="<%= usn %>">
        
        <div class="mb-3">
            <label for="subjectCode" class="form-label">Subject Code</label>
            <input type="text" class="form-control" id="subjectCode" name="subjectCode" required>
        </div>

        <div class="mb-3">
            <label for="academicYear" class="form-label">Academic Year</label>
            <input type="text" class="form-control" id="academicYear" name="academicYear" placeholder="e.g., 2023-2024" required>
        </div>

        <div class="mb-3">
            <label for="dateOfAdmission" class="form-label">Date of Admission</label>
            <input type="date" class="form-control" id="dateOfAdmission" name="dateOfAdmission" required>
        </div>

        <div class="mb-3">
            <label for="semester" class="form-label">Semester</label>
            <input type="number" class="form-control" id="semester" name="semester" min="1" max="8" required>
        </div>

        <button type="submit" class="btn btn-primary">Allocate Subject</button>
    </form>
</div>
<footer>
    <div class="text-center">© 2024 ATMS - All Rights Reserved</div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
