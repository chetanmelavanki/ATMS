<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Event - Academic Task Management System</title>
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
        footer {
            background-color: #343a40;
            color: #ffffff;
            padding: 10px 0;
            text-align: center;
            position: fixed;
            width: 100%;
            bottom: 0;
        }
        .alert-container {
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
                        <a class="nav-link" href="admin-home.html">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="update_event.jsp">Update Event</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view_events.jsp">View Events</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="create_event.jsp">Create Event</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Delete Event</h4>
        
        <form method="POST">
            <div class="mb-3">
                <label for="eventId" class="form-label">Event ID</label>
                <input type="number" id="eventId" name="eventId" class="form-control" placeholder="Event ID" required>
            </div>
            <button type="submit" class="btn btn-danger">Delete Event</button>
        </form>

        <div class="alert-container">
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

                try {
                    // Load the database driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    // Establish the connection
                    conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
                    // Prepare SQL query
                    String sql = "DELETE FROM EVENT WHERE Event_Id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(eventId));

                    // Execute the deletion
                    int rowsDeleted = pstmt.executeUpdate();

                    if (rowsDeleted > 0) {
                        message = "<div class='alert alert-success'>Event deleted successfully!</div>";
                    } else {
                        message = "<div class='alert alert-warning'>No event found with the given ID.</div>";
                    }
                } catch (Exception e) {
                    message = "<div class='alert alert-danger'>Error deleting event: " + e.getMessage() + "</div>";
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
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
