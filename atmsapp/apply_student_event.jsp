<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Get the submitted form data
    String usn = request.getParameter("usn");
    String eventId = request.getParameter("event_id");
    String involvementType = request.getParameter("involvement_type");
    String involvementDetails = request.getParameter("involvement_details");

    // Get the current date for the involvement
    java.util.Date date = new java.util.Date();
    java.sql.Date involvementDate = new java.sql.Date(date.getTime());

    Connection connection = null;
    PreparedStatement insertStatement = null;

    try {
        String dbURL = "jdbc:mysql://localhost:3306/atms";  // Adjust to your database details
        String dbUser = "root";  // Adjust to your database username
        String dbPass = "ROOT";  // Adjust to your database password
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Insert the student's involvement in the event
        String insertQuery = "INSERT INTO STUDENT_INVOLVEMENT (USN, Event_Id, Student_Involvement_Date, Student_Involvement_Type, Student_Involvement_Details) VALUES (?, ?, ?, ?, ?)";
        insertStatement = connection.prepareStatement(insertQuery);
        insertStatement.setString(1, usn);
        insertStatement.setString(2, eventId);
        insertStatement.setDate(3, involvementDate);
        insertStatement.setString(4, involvementType);
        insertStatement.setString(5, involvementDetails != null ? involvementDetails : "");

        int rowsInserted = insertStatement.executeUpdate();

        if (rowsInserted > 0) {
            out.println("<h2>Application submitted successfully!</h2>");
            out.println("<a href='events.jsp?usn=" + usn + "'>Return to Events</a>");
        } else {
            out.println("<h2>Failed to submit the application. Please try again.</h2>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error occurred: " + e.getMessage() + "</h2>");
    } finally {
        if (insertStatement != null) insertStatement.close();
        if (connection != null) connection.close();
    }
%>
