<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    // Retrieve the form parameters
    String facultyId = request.getParameter("facultyId");
    String eventId = request.getParameter("eventId");
    String involvementType = request.getParameter("involvement_type");
    String involvementDetails = request.getParameter("involvement_details");
    
    // Get the current date as default for Faculty_Involvement_Date if not provided
    String involvementDateStr = request.getParameter("involvement_date");
    if (involvementDateStr == null || involvementDateStr.isEmpty()) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        involvementDateStr = sdf.format(new Date());  // Default to today's date
    }

    // Check if eventId is null or empty
    if (eventId == null || eventId.isEmpty()) {
        out.println("<h2>Error: Event ID cannot be null!</h2>");
        return;
    }

    // Initialize database connection variables
    Connection connection = null;
    PreparedStatement insertStatement = null;

    try {
        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/atms";
        String dbUser = "root";
        String dbPass = "ROOT";

        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection to the database
        connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // SQL query to insert the faculty event application into the database
        String insertQuery = "INSERT INTO FACULTY_INVOLVEMENT (Faculty_Id, Event_Id, Faculty_Involvement_Date, Faculty_Involvement_Type, Faculty_Involvement_Details) VALUES (?, ?, ?, ?, ?)";
        insertStatement = connection.prepareStatement(insertQuery);

        // Set the values for the PreparedStatement
        insertStatement.setString(1, facultyId);
        insertStatement.setString(2, eventId);  // Ensure eventId is not null
        insertStatement.setDate(3, java.sql.Date.valueOf(involvementDateStr));  // Convert String to Date
        insertStatement.setString(4, involvementType);
        insertStatement.setString(5, involvementDetails);

        // Execute the insert query
        int result = insertStatement.executeUpdate();

        // Provide feedback based on the result
        if (result > 0) {
            // Print success message
            out.println("<h2>Application Submitted Successfully!</h2>");
            
            // Redirect after a brief delay (using JavaScript)
            out.println("<script type=\"text/javascript\">");
            out.println("setTimeout(function(){");
            out.println("window.location.href = 'faculty_events.jsp?facultyId=" + facultyId + "';");
            out.println("}, 2000);");  // Delay 2 seconds before redirection
            out.println("</script>");
        } else {
            out.println("<h2>Application Failed. Please try again.</h2>");
        }
    } catch (SQLException e) {
        // Handle SQL errors
        e.printStackTrace();
        out.println("<h2>Database Error. Please try again.</h2>");
    } catch (Exception e) {
        // Handle other exceptions
        e.printStackTrace();
        out.println("<h2>Unexpected Error. Please try again.</h2>");
    } finally {
        // Close database resources
        try {
            if (insertStatement != null) insertStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
