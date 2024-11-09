<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String facultyId = request.getParameter("facultyId");
    if (facultyId == null || facultyId.isEmpty()) {
        out.println("Faculty ID is missing.");
        return; // Stop execution if facultyId is missing
    }

    Connection connection = null;
    Statement statement = null;
    ResultSet eventResultSet = null;

    try {
        String dbURL = "jdbc:mysql://localhost:3306/atms";
        String dbUser = "root";
        String dbPass = "ROOT";
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
    <title>Available Events for Faculty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Available Events for Faculty</h1>

        <div class="table-responsive mt-4">
            <table class="table table-bordered">
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
                            <form action="faculty_event_apply.jsp" method="get">
                                <input type="hidden" name="facultyId" value="<%= facultyId %>">
                                <!-- Hidden input for passing eventId -->
                                <input type="hidden" name="eventId" value="<%= eventId %>">

                                <button type="submit" class="btn btn-primary">Apply</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

<%
    if (eventResultSet != null) eventResultSet.close();
    if (statement != null) statement.close();
    if (connection != null) connection.close();
%>
