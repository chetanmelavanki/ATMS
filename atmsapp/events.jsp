<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String usn = request.getParameter("usn");
    Connection connection = null;
    Statement statement = null;
    ResultSet eventResultSet = null;

    try {
        String dbURL = "jdbc:mysql://localhost:3306/atms";  // Adjust to your database details
        String dbUser = "root";  // Adjust to your database username
        String dbPass = "ROOT";  // Adjust to your database password
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Fetch all events
        String fetchEventsQuery = "SELECT Event_Id, Event_Name, Event_Type, Event_Venue, Start_Date, End_Date, Branch_Id, Semester FROM EVENT";
        statement = connection.createStatement();
        eventResultSet = statement.executeQuery(fetchEventsQuery);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Additional styles for table border and shadow */
        .table-container {
            border: 1px solid #dee2e6; /* Border around the table */
            border-radius: 0.25rem; /* Rounded corners */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Shadow effect */
            padding: 1.5rem; /* Padding around the table */
            background-color: #fff; /* White background */
        }

        /* Navigation Bar styles */
        .navbar {
            background-color: #007bff; /* Blue background for the navbar */
        }

        .navbar .nav-link {
            color: white; /* White text for the nav links */
        }

        .navbar .nav-link:hover {
            color: #ffc107; /* Gold color on hover */
        }

        /* Footer styles */
        .footer {
            position: relative; 
            bottom: 0;
            width: 100%;
            background-color: #343a40; /* Dark background for the footer */
            padding: 1rem 0; /* Padding */
            text-align: center; /* Centered text */
            color: white; /* White text for footer */
        }

        /* Body styles to push footer down */
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensure footer stays at the bottom */
        }

        .content {
            flex: 1; /* Allows content to take the remaining space */
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">ATMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto"> <!-- 'ms-auto' for right alignment -->
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="student-home.jsp?usn=<%= usn %>">Home</a>
                    </li>
                    
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5 content">
        <h1 class="text-center">Available Events</h1>

        <div class="table-container mt-4">
            <table class="table table-bordered table-responsive">
                <thead>
                    <tr>
                        <th>Event Name</th>
                        <th>Type</th>
                        <th>Venue</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Branch ID</th>
                        <th>Semester</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        while(eventResultSet != null && eventResultSet.next()) { 
                            String eventId = eventResultSet.getString("Event_Id");
                            String eventName = eventResultSet.getString("Event_Name");
                            String eventType = eventResultSet.getString("Event_Type");
                            String eventVenue = eventResultSet.getString("Event_Venue");
                            String startDate = eventResultSet.getString("Start_Date");
                            String endDate = eventResultSet.getString("End_Date");
                            String branchId = eventResultSet.getString("Branch_Id");
                            String semester = eventResultSet.getString("Semester");
                    %>
                    <tr>
                        <td><%= eventName %></td>
                        <td><%= eventType %></td>
                        <td><%= eventVenue %></td>
                        <td><%= startDate %></td>
                        <td><%= endDate %></td>
                        <td><%= branchId %></td>
                        <td><%= semester %></td>
                        <td>
                            <!-- Link to the application form, passing the USN and event ID as parameters -->
                            <a href="student_event_apply.jsp?usn=<%= usn %>&event_id=<%= eventId %>" class="btn btn-primary">Apply</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Footer -->
<footer class="footer">
    <div class="container">
        <span style="color: white;">© 2024 Academic Task Management System. All rights reserved.</span>
    </div>
</footer>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%
    if (eventResultSet != null) eventResultSet.close();
    if (statement != null) statement.close();
    if (connection != null) connection.close();
%>
