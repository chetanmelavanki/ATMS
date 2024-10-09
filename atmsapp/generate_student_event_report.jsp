<%@ page language="java" contentType="application/pdf" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.itextpdf.kernel.pdf.PdfWriter" %>
<%@ page import="com.itextpdf.kernel.pdf.PdfDocument" %>
<%@ page import="com.itextpdf.layout.Document" %>
<%@ page import="com.itextpdf.layout.element.Paragraph" %>
<%@ page import="com.itextpdf.layout.element.Table" %>
<%@ page import="com.itextpdf.layout.element.Cell" %>
<%@ page import="java.io.*" %>

<%
    String usn = request.getParameter("usn");
    String studentName = "";
    int eventCount = 0;

    // Set response type for PDF
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=event_report.pdf");

    ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
    Connection connection = null;

    try {
        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/atms"; // Update with your DB name
        String dbUser = "root";  // Change as per your DB username
        String dbPassword = "ROOT";  // Change as per your DB password

        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to fetch student name
        String studentQuery = "SELECT Student_Name FROM STUDENT WHERE USN = ?";
        PreparedStatement studentStatement = connection.prepareStatement(studentQuery);
        studentStatement.setString(1, usn);
        
        ResultSet studentResultSet = studentStatement.executeQuery();
        
        if (studentResultSet.next()) {
            studentName = studentResultSet.getString("Student_Name");
        } else {
            throw new Exception("Student not found for USN: " + usn);
        }

        // Query to fetch event details for the student
        String eventQuery = "SELECT E.Event_Name, SI.Student_Involvement_Date, SI.Student_Involvement_Type " +
                            "FROM STUDENT_INVOLVEMENT SI " +
                            "JOIN EVENT E ON SI.Event_Id = E.Event_Id " +
                            "WHERE SI.USN = ?";
        
        PreparedStatement eventStatement = connection.prepareStatement(eventQuery);
        eventStatement.setString(1, usn);
        
        ResultSet eventResultSet = eventStatement.executeQuery();
        
        // Create PDF document
        PdfWriter pdfWriter = new PdfWriter(byteArrayOutputStream);
        PdfDocument pdfDocument = new PdfDocument(pdfWriter);
        Document document = new Document(pdfDocument);

        // Add content to the PDF
        document.add(new Paragraph("Event Participation Report").setFontSize(20));
        document.add(new Paragraph("USN: " + usn));
        document.add(new Paragraph("Name: " + studentName));
        document.add(new Paragraph("\n"));

        // Create a table for event details
        Table table = new Table(3); // 3 columns for Event Name, Date, and Involvement Type
        table.addHeaderCell(new Cell().add(new Paragraph("Event Name")));
        table.addHeaderCell(new Cell().add(new Paragraph("Involvement Date")));
        table.addHeaderCell(new Cell().add(new Paragraph("Involvement Type")));

        // Populate the table with event data
        while (eventResultSet.next()) {
            String eventName = eventResultSet.getString("Event_Name");
            String involvementDate = eventResultSet.getString("Student_Involvement_Date");
            String involvementType = eventResultSet.getString("Student_Involvement_Type");

            // Adding cells to the table
            table.addCell(new Cell().add(new Paragraph(eventName)));
            table.addCell(new Cell().add(new Paragraph(involvementDate)));
            table.addCell(new Cell().add(new Paragraph(involvementType)));
            eventCount++; // Increment the count for each event added
        }

        // Add the table to the document
        document.add(table);
        document.add(new Paragraph("Number of Events Participated: " + eventCount));

        // Close the document
        document.close();

        // Write the PDF to the response output stream
        byte[] pdfBytes = byteArrayOutputStream.toByteArray();
        response.getOutputStream().write(pdfBytes);
        response.getOutputStream().flush();
        
    } catch (Exception e) {
        e.printStackTrace(); // Print the stack trace for debugging
        response.getWriter().write("Error generating PDF: " + e.getMessage());
    } finally {
        // Clean up resources
        try {
            if (byteArrayOutputStream != null) byteArrayOutputStream.close();
            if (connection != null) connection.close();
        } catch (IOException | SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
