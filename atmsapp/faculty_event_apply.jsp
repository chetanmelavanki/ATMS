<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String facultyId = request.getParameter("facultyId");
    String eventId = request.getParameter("eventId");  // Ensure this is not null

    if (eventId == null || eventId.isEmpty()) {
        out.println("Error: Event ID is missing!");
        return; // Prevent further execution if eventId is null
    }
    Connection connection = null;
    PreparedStatement eventStatement = null;
    PreparedStatement checkStatement = null;
    PreparedStatement insertStatement = null;
    ResultSet eventResultSet = null;
    ResultSet checkResultSet = null;

    String eventName = "";
    String eventType = "";
    String eventVenue = "";
    String startDate = "";
    String endDate = "";
    boolean alreadyApplied = false;

    try {
        String dbURL = "jdbc:mysql://localhost:3306/atms";
        String dbUser = "root";
        String dbPass = "ROOT";
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Fetch event details
        String fetchEventQuery = "SELECT Event_Name, Event_Type, Event_Venue, Start_Date, End_Date FROM EVENT WHERE Event_Id = ?";
        eventStatement = connection.prepareStatement(fetchEventQuery);
        eventStatement.setString(1, eventId);
        eventResultSet = eventStatement.executeQuery();

        if (eventResultSet.next()) {
            eventName = eventResultSet.getString("Event_Name");
            eventType = eventResultSet.getString("Event_Type");
            eventVenue = eventResultSet.getString("Event_Venue");
            startDate = eventResultSet.getString("Start_Date");
            endDate = eventResultSet.getString("End_Date");
        }

        // Check if the faculty has already applied for this event
        String checkApplicationQuery = "SELECT COUNT(*) FROM FACULTY_INVOLVEMENT WHERE Faculty_Id = ? AND Event_Id = ?";
        checkStatement = connection.prepareStatement(checkApplicationQuery);
        checkStatement.setString(1, facultyId);
        checkStatement.setString(2, eventId);
        checkResultSet = checkStatement.executeQuery();

        if (checkResultSet.next()) {
            alreadyApplied = checkResultSet.getInt(1) > 0;
        }

        // Handle form submission
        String action = request.getParameter("action");
        if ("apply".equals(action) && !alreadyApplied) {
            String insertApplicationQuery = "INSERT INTO FACULTY_INVOLVEMENT (Faculty_Id, Event_Id, Faculty_Involvement_Date, Faculty_Involvement_Type, Faculty_Involvement_Details) VALUES (?, ?, CURDATE(), ?, ?)";
            insertStatement = connection.prepareStatement(insertApplicationQuery);
            insertStatement.setString(1, facultyId);
            insertStatement.setString(2, eventId);
            insertStatement.setString(3, request.getParameter("involvement_type"));
            insertStatement.setString(4, request.getParameter("involvement_details"));
            insertStatement.executeUpdate();
            response.sendRedirect("application_success.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (eventResultSet != null) eventResultSet.close();
            if (checkResultSet != null) checkResultSet.close();
            if (eventStatement != null) eventStatement.close();
            if (checkStatement != null) checkStatement.close();
            if (insertStatement != null) insertStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apply for Event</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .footer {
            position: relative; 
            bottom: 0;
            width: 100%;
            background-color: #343a40;
            padding: 1rem 0;
            text-align: center;
            color: white;
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .content {
            flex: 1;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light" style="background-color: #007bff;">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">ATMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="faculty_events.jsp?facultyId=<%= facultyId %>">Back</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="faculty-home.jsp?facultyId=<%= facultyId %>">Home</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5 content">
        <h1 class="text-center">Apply for <%= eventName %></h1>

        <div class="card mt-4">
            <div class="card-body">
                <h5 class="card-title">Event Details</h5>
                <p><strong>Type:</strong> <%= eventType %></p>
                <p><strong>Venue:</strong> <%= eventVenue %></p>
                <p><strong>Start Date:</strong> <%= startDate %></p>
                <p><strong>End Date:</strong> <%= endDate %></p>
            </div>
        </div>

        <form id="applicationForm" action="apply_faculty_event.jsp?facultyId=<%= facultyId %>" method="post" class="mt-4">
            <input type="hidden" name="facultyId" value="<%= facultyId %>" />
            <input type="hidden" name="eventId" value="<%= eventId %>" />

            <input type="hidden" name="action" value="apply" /> <!-- Hidden input for action -->

            <div class="mb-3">
                <label for="involvement_type" class="form-label">Select Involvement Type</label>
                <select class="form-select" name="involvement_type" id="involvement_type" required>
                    <option value="">-- Select Involvement Type --</option>
                    <option value="Organizer">Organizer</option>
                    <option value="Speaker">Speaker</option>
                    <option value="Participant">Participant</option>
                    <option value="Judge">Judge</option>
                    <option value="Coordinator">Coordinator</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="involvement_details" class="form-label">Involvement Details (Optional)</label>
                <textarea class="form-control" name="involvement_details" id="involvement_details" rows="3"></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Apply</button>
        </form>
    </div>

    <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="errorModalLabel">Application Error</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    You have already applied for this event.
                </div>
                <div class="modal-footer">
                    <a href="faculty_events.jsp?facultyId=<%= facultyId %>" class="btn btn-primary">Back to Events</a>
                </div>
            </div>
        </div>
    </div>

    <% if (alreadyApplied) { %>
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                var myModal = new bootstrap.Modal(document.getElementById('errorModal'), {});
                myModal.show();
            });
        </script>
    <% } %>

    <footer class="footer mt-auto">
        <div class="container">
            <span>&copy; 2024 ATMS. All Rights Reserved.</span>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
