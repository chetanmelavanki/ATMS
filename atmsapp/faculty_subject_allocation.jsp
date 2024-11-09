<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String facultyId = request.getParameter("facultyId");  // Retrieve 'facultyId' parameter
    String facultyName = "";
    String message = "";

    if (facultyId != null && !facultyId.isEmpty()) {
        try {
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/atms";  // Update with your DB name
            String dbUser = "root";  // Update with your DB username
            String dbPass = "ROOT";  // Update with your DB password

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
                facultyName = resultSet.getString("Faculty_Name");  // Use correct column name
            }

            // Close the result set and statement
            resultSet.close();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred while fetching faculty details.";
        }
    } else {
        message = "Faculty ID not found!";
    }

    // Handling subject allocation form submission
    if (request.getMethod().equalsIgnoreCase("POST") && facultyId != null && !facultyId.isEmpty()) {
        String subjectCode = request.getParameter("subjectCode");
        String academicYear = request.getParameter("academicYear");
        String allocationDate = request.getParameter("allocationDate");
        String semester = request.getParameter("semester");

        try {
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/atms";
            String dbUser = "root";
            String dbPass = "ROOT";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Insert query for faculty subject allocation
            String insertQuery = "INSERT INTO FACULTY_ALLOCATION (Faculty_Id, Subject_Code, Allocation_Date, Academic_Year, Sem) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(insertQuery);
            statement.setString(1, facultyId);
            statement.setString(2, subjectCode);
            statement.setString(3, allocationDate);
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
            message = "An error occurred during faculty subject allocation.";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Subject Allocation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .faculty-dashboard {
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
            <a class="navbar-brand" href="#">Faculty Subject Allocation</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="faculty-home.jsp?facultyId=<%= facultyId %>">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="text-center">Subject Allocation for <%= facultyName %> (<%= facultyId %>)</h2>
        <p class="text-center text-success"><%= message %></p>
        
        <form method="post" class="mt-4">
            <input type="hidden" name="facultyId" value="<%= facultyId %>">
            
            <div class="mb-3">
                <label for="subjectCode" class="form-label">Subject Code</label>
                <input type="text" class="form-control" id="subjectCode" name="subjectCode" required>
            </div>

            <div class="mb-3">
                <label for="academicYear" class="form-label">Academic Year</label>
                <input type="text" class="form-control" id="academicYear" name="academicYear" placeholder="e.g., 2023-2024" required>
            </div>

            <div class="mb-3">
                <label for="allocationDate" class="form-label">Allocation Date</label>
                <input type="date" class="form-control" id="allocationDate" name="allocationDate" required>
            </div>

            <div class="mb-3">
                <label for="semester" class="form-label">Semester</label>
                <input type="number" class="form-control" id="semester" name="semester" min="1" max="8" required>
            </div>

            <button type="submit" class="btn btn-primary">Allocate Subject</button>
        </form>
    </div>

    <!-- Footer -->
    <footer>
        <div class="text-center">© 2024 ATMS - All Rights Reserved</div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
