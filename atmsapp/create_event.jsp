<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Event - Academic Task Management System</title>
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
            padding: 20px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            background-color: #ffffff;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
        }
        .row {
            display: flex;
            justify-content: space-between;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-control {
            width: 100%;
        }
        footer {
            background-color: #343a40;
            color: #ffffff;
            padding: 10px 0;
            text-align: center;
            width: 100%;
            position: relative;
            bottom: 0;
            margin-top: 20px;
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
                        <a class="nav-link" href="update_event.jsp">Update Event</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view_events.jsp">View Events</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="delete_event.jsp">Delete Event</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Create New Event</h4>
        <%
            String message = "";
            if (request.getMethod().equalsIgnoreCase("POST")) {
                // Retrieve form data
                String eventName = request.getParameter("eventName");
                String eventType = request.getParameter("eventType");
                String eventVenue = request.getParameter("eventVenue");
                String branchId = request.getParameter("branchId");
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                String semester = request.getParameter("semester");

                // Convert datetime-local to proper Timestamp format
                startDate = startDate.replace("T", " ") + ":00";
                endDate = endDate.replace("T", " ") + ":00";

                Connection conn = null;
                PreparedStatement ps = null;

                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/atms", "root", "ROOT");

                    String sql = "INSERT INTO event (Event_Name, Event_Type, Event_Venue, Branch_Id, Start_Date, End_Date, Semester) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, eventName);
                    ps.setString(2, eventType);
                    ps.setString(3, eventVenue);
                    ps.setInt(4, Integer.parseInt(branchId));
                    ps.setTimestamp(5, Timestamp.valueOf(startDate));
                    ps.setTimestamp(6, Timestamp.valueOf(endDate));
                    ps.setInt(7, Integer.parseInt(semester));

                    int result = ps.executeUpdate();

                    if (result > 0) {
                        message = "Event created successfully!";
                    } else {
                        message = "Failed to create the event.";
                    }

                } catch (Exception e) {
                    message = "Error: " + e.getMessage();
                } finally {
                    try {
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>

        <!-- Display Feedback -->
        <%
            if (!message.isEmpty()) {
        %>
            <div class="alert <%= message.contains("successfully") ? "alert-success" : "alert-danger" %>" role="alert">
                <%= message %>
            </div>
        <%
            }
        %>

        <form action="create_event.jsp" method="POST" id="createEventForm">
            <div class="form-group">
                <label for="eventName" class="form-label">Event Name</label>
                <input type="text" id="eventName" name="eventName" class="form-control" placeholder="Event Name" required>
            </div>
            <div class="form-group">
                <label for="eventType" class="form-label">Event Type</label>
                <input type="text" id="eventType" name="eventType" class="form-control" placeholder="Event Type" required>
            </div>
            <div class="form-group">
                <label for="eventVenue" class="form-label">Event Venue</label>
                <input type="text" id="eventVenue" name="eventVenue" class="form-control" placeholder="Event Venue" required>
            </div>
            <div class="form-group">
                <label for="branchId" class="form-label">Branch ID</label>
                <input type="number" id="branchId" name="branchId" class="form-control" placeholder="Branch ID" required>
            </div>
            <div class="row">
                <div class="form-group col-md-6">
                    <label for="startDate" class="form-label">Start Date and Time</label>
                    <input type="datetime-local" id="startDate" name="startDate" class="form-control" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="endDate" class="form-label">End Date and Time</label>
                    <input type="datetime-local" id="endDate" name="endDate" class="form-control" required>
                </div>
            </div>
            <div class="form-group">
                <label for="semester" class="form-label">Semester</label>
                <input type="number" id="semester" name="semester" class="form-control" placeholder="Semester" required>
            </div>
            <button type="submit" class="btn btn-primary">Create Event</button>
        </form>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
