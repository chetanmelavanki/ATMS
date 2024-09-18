<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Event - Academic Task Management System</title>
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
        }
        .form-container {
            border: 2px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            background-color: #ffffff;
            margin-bottom: 60px; /* Ensures there's space for the footer */
        }
        .footer-fixed {
            background-color: #343a40;
            color: #ffffff;
            padding: 10px 0;
            text-align: center;
            width: 100%;
            position: relative;
            bottom: 0;
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
                        <a class="nav-link" href="create_event.jsp">Create Event</a>
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
        <h4 class="mb-4">Update Event</h4>
        <div class="form-container">
            <form method="POST">
                <div class="mb-3">
                    <label for="eventId" class="form-label">Event ID</label>
                    <input type="number" id="eventId" name="eventId" class="form-control" placeholder="Event ID" required>
                </div>
                <div class="mb-3">
                    <label for="eventName" class="form-label">Event Name</label>
                    <input type="text" id="eventName" name="eventName" class="form-control" placeholder="Event Name" required>
                </div>
                <div class="mb-3">
                    <label for="eventType" class="form-label">Event Type</label>
                    <input type="text" id="eventType" name="eventType" class="form-control" placeholder="Event Type" required>
                </div>
                <div class="mb-3">
                    <label for="eventVenue" class="form-label">Event Venue</label>
                    <input type="text" id="eventVenue" name="eventVenue" class="form-control" placeholder="Event Venue" required>
                </div>
                <div class="mb-3">
                    <label for="branchId" class="form-label">Branch ID</label>
                    <input type="number" id="branchId" name="branchId" class="form-control" placeholder="Branch ID" required>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="startDate" class="form-label">Start Date</label>
                        <input type="datetime-local" id="startDate" name="startDate" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label for="endDate" class="form-label">End Date</label>
                        <input type="datetime-local" id="endDate" name="endDate" class="form-control" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="semester" class="form-label">Semester</label>
                    <input type="number" id="semester" name="semester" class="form-control" placeholder="Semester" required>
                </div>
                <button type="submit" class="btn btn-primary">Update Event</button>
            </form>

            <% 
            // Database connection details
            String jdbcUrl = "jdbc:mysql://localhost:3306/atms";
            String jdbcUser = "root";
            String jdbcPassword = "ROOT";
            Connection conn = null;
            PreparedStatement pstmt = null;
            String message = "";
            
            // Check if the form is submitted
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String eventId = request.getParameter("eventId");
                String eventName = request.getParameter("eventName");
                String eventType = request.getParameter("eventType");
                String eventVenue = request.getParameter("eventVenue");
                String branchId = request.getParameter("branchId");
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                String semester = request.getParameter("semester");
                
                try {
                    // Load the database driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    // Establish the connection
                    conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
                    // Prepare SQL query
                    String sql = "UPDATE EVENT SET Event_Name = ?, Event_Type = ?, Event_Venue = ?, Branch_Id = ?, Start_Date = ?, End_Date = ?, Semester = ? WHERE Event_Id = ?";

                    pstmt = conn.prepareStatement(sql);
                    
                    // Convert datetime-local to SQL timestamp format
                    java.util.Date startUtilDate = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(startDate);
                    java.util.Date endUtilDate = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(endDate);
                    java.sql.Timestamp startTimestamp = new java.sql.Timestamp(startUtilDate.getTime());
                    java.sql.Timestamp endTimestamp = new java.sql.Timestamp(endUtilDate.getTime());

                    pstmt.setString(1, eventName);
                    pstmt.setString(2, eventType);
                    pstmt.setString(3, eventVenue);
                    pstmt.setInt(4, Integer.parseInt(branchId));
                    pstmt.setTimestamp(5, startTimestamp);
                    pstmt.setTimestamp(6, endTimestamp);
                    pstmt.setInt(7, Integer.parseInt(semester));
                    pstmt.setInt(8, Integer.parseInt(eventId));

                    // Execute the update
                    int rowsUpdated = pstmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        message = "<div class='alert alert-success'>Event updated successfully!</div>";
                    } else {
                        message = "<div class='alert alert-warning'>No event found with the given ID.</div>";
                    }
                } catch (Exception e) {
                    message = "<div class='alert alert-danger'>Error updating event: " + e.getMessage() + "</div>";
                } finally {
                    try {
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
            %>

            <!-- Display the message -->
            <%= message %>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer-fixed">
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
