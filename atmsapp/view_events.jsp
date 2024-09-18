<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Events - Academic Task Management System</title>
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
                        <a class="nav-link" href="create_event.jsp">Create Events</a>
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
        <h4 class="mb-4">View All Events</h4>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Event ID</th>
                    <th>Event Name</th>
                    <th>Event Type</th>
                    <th>Event Venue</th>
                    <th>Branch ID</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Semester</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        // Database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/atms", "root", "ROOT");

                        String sql = "SELECT * FROM EVENT";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            int eventId = rs.getInt("Event_Id");
                            String eventName = rs.getString("Event_Name");
                            String eventType = rs.getString("Event_Type");
                            String eventVenue = rs.getString("Event_Venue");
                            int branchId = rs.getInt("Branch_Id");
                            Timestamp startDate = rs.getTimestamp("Start_Date");
                            Timestamp endDate = rs.getTimestamp("End_Date");
                            int semester = rs.getInt("Semester");
                %>
                <tr>
                    <td><%= eventId %></td>
                    <td><%= eventName %></td>
                    <td><%= eventType %></td>
                    <td><%= eventVenue %></td>
                    <td><%= branchId %></td>
                    <td><%= startDate %></td>
                    <td><%= endDate %></td>
                    <td><%= semester %></td>
                </tr>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
