<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String usn = request.getParameter("usn");
    String eventId = request.getParameter("event_id");
    Connection connection = null;
    PreparedStatement eventStatement = null;
    PreparedStatement checkStatement = null; // For checking existing applications
    PreparedStatement insertStatement = null; // For inserting new application
    ResultSet eventResultSet = null;    
    ResultSet checkResultSet = null; // For checking existing applications

    String eventName = "";
    String eventType = "";
    String eventVenue = "";
    String startDate = "";
    String endDate = "";
    boolean alreadyApplied = false; // Flag to check if already applied

    try {
        String dbURL = "jdbc:mysql://localhost:3306/atms";  // Adjust to your database details
        String dbUser = "root";  // Adjust to your database username
        String dbPass = "ROOT";  // Adjust to your database password
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Fetch selected event details
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

        // Check if the user has already applied for this event
        String checkApplicationQuery = "SELECT COUNT(*) FROM student_involvement WHERE USN = ? AND Event_Id = ?";
        checkStatement = connection.prepareStatement(checkApplicationQuery);
        checkStatement.setString(1, usn);
        checkStatement.setString(2, eventId);
        checkResultSet = checkStatement.executeQuery();

        if (checkResultSet.next()) {
            alreadyApplied = checkResultSet.getInt(1) > 0; // Check if the count is greater than 0
        }

        // Handle form submission
        String action = request.getParameter("action");
        if ("apply".equals(action)) {
            // Insert new application only if not already applied
            if (!alreadyApplied) {
                String insertApplicationQuery = "INSERT INTO student_involvement (USN, Event_Id, Involvement_Type, Involvement_Details) VALUES (?, ?, ?, ?)";
                insertStatement = connection.prepareStatement(insertApplicationQuery);
                insertStatement.setString(1, usn);
                insertStatement.setString(2, eventId);
                insertStatement.setString(3, request.getParameter("involvement_type"));
                insertStatement.setString(4, request.getParameter("involvement_details"));
                insertStatement.executeUpdate();
                response.sendRedirect("application_success.jsp"); // Redirect to success page or similar
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (eventResultSet != null) eventResultSet.close();
        if (checkResultSet != null) checkResultSet.close(); // Close the check result set
        if (eventStatement != null) eventStatement.close();
        if (checkStatement != null) checkStatement.close(); // Close the check statement
        if (insertStatement != null) insertStatement.close(); // Close the insert statement
        if (connection != null) connection.close();
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
        /* Footer styles */
        .footer {
            position: relative; 
            bottom: 0;
            width: 100%;
            background-color: #343a40; /* Dark background for the footer */
            padding: 1rem 0; /* Padding */
            text-align: center; /* Centered text */
            color: white; /* Ensure footer text is white */
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
    <nav class="navbar navbar-expand-lg navbar-light" style="background-color: #007bff;">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">ATMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto"> <!-- 'ms-auto' for right alignment -->
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="events.jsp">Back</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="student-home.jsp">Home</a>
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

        <!-- Application Form -->
        <form id="applicationForm" action="apply_event.jsp" method="post" class="mt-4">
            <input type="hidden" name="usn" value="<%= usn %>" />
            <input type="hidden" name="event_id" value="<%= eventId %>" />
            <input type="hidden" name="action" value="apply" /> <!-- Hidden input for action -->

            <!-- Involvement Type Dropdown -->
            <div class="mb-3">
                <label for="involvement_type" class="form-label">Select Involvement Type</label>
                <select class="form-select" name="involvement_type" id="involvement_type" required>
                    <option value="">-- Select Involvement Type --</option>
                    <option value="Participant">Participant</option>
                    <option value="Volunteer">Volunteer</option>
                    <option value="Organizer">Organizer</option>
                    <option value="Speaker">Speaker</option>
                    <option value="Judge">Judge</option>
                </select>
            </div>

            <!-- Additional Details Text Area -->
            <div class="mb-3">
                <label for="involvement_details" class="form-label">Involvement Details (Optional)</label>
                <textarea class="form-control" name="involvement_details" id="involvement_details" rows="3"></textarea>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary">Apply</button>
        </form>
    </div>

    <!-- Modal for Error Message -->
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
                    <!--<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>-->
                    <a href="events.jsp?usn=<%= usn %>" class="btn btn-primary">Back to Events</a> <!-- Back to Events button -->
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <span>&copy; 2024 ATMS. All rights reserved.</span>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Show the error modal if the user has already applied
        <%
            if (alreadyApplied) {
        %>
            var myModal = new bootstrap.Modal(document.getElementById('errorModal'));
            myModal.show();
        <%
            }
        %>
    </script>
</body>
</html>
