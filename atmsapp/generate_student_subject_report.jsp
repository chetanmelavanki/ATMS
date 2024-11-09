<%@ page language="java" contentType="application/pdf" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.itextpdf.kernel.pdf.PdfWriter" %>
<%@ page import="com.itextpdf.kernel.pdf.PdfDocument" %>
<%@ page import="com.itextpdf.layout.Document" %>
<%@ page import="com.itextpdf.layout.element.Paragraph" %>
<%@ page import="com.itextpdf.layout.element.Table" %>
<%@ page import="com.itextpdf.layout.element.Cell" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.io.IOException" %>

<%
    String usn = request.getParameter("usn");
    String studentName = "";
    int subjectCount = 0;

    // Set response type for PDF
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=subject_report.pdf");

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

        // Query to fetch subject allocation details for the student
        String subjectQuery = "SELECT S.Subject_Code, S.Subject_Name, S.Credits, S.Semester, SA.Date_Of_Admission " +
        "FROM STUDENT_ALLOCATED SA " +
        "JOIN SUBJECT S ON SA.Subject_Code = S.Subject_Code " +
        "WHERE SA.USN = ?";
        
        PreparedStatement subjectStatement = connection.prepareStatement(subjectQuery);
        subjectStatement.setString(1, usn);
        
        ResultSet subjectResultSet = subjectStatement.executeQuery();
        
        // Create PDF document
        PdfWriter pdfWriter = new PdfWriter(byteArrayOutputStream);
        PdfDocument pdfDocument = new PdfDocument(pdfWriter);
        Document document = new Document(pdfDocument);

        // Add content to the PDF
        document.add(new Paragraph("Subject Allocation Report").setFontSize(20));
        document.add(new Paragraph("USN: " + usn));
        document.add(new Paragraph("Name: " + studentName));
        document.add(new Paragraph("\n"));

        // Create a table for subject details
        Table table = new Table(4); // 4 columns for Subject Code, Subject Name, Credits, and Semester
        table.addHeaderCell(new Cell().add(new Paragraph("Subject Code")));
        table.addHeaderCell(new Cell().add(new Paragraph("Subject Name")));
        table.addHeaderCell(new Cell().add(new Paragraph("Credits")));
        table.addHeaderCell(new Cell().add(new Paragraph("Semester")));

        // Populate the table with subject data
        while (subjectResultSet.next()) {
            String subjectCode = subjectResultSet.getString("Subject_Code");
            String subjectName = subjectResultSet.getString("Subject_Name");
            String credits = subjectResultSet.getString("Credits");
            String semester = subjectResultSet.getString("Semester");
            String dateOfAdmission = subjectResultSet.getString("Date_Of_Admission"); // Keep this if you want to include it elsewhere

            // Adding cells to the table
            table.addCell(new Cell().add(new Paragraph(subjectCode)));
            table.addCell(new Cell().add(new Paragraph(subjectName)));
            table.addCell(new Cell().add(new Paragraph(credits)));
            table.addCell(new Cell().add(new Paragraph(semester)));
            subjectCount++; // Increment the count for each subject added
        }

        // Add the table to the document
        document.add(table);
        document.add(new Paragraph("Number of Subjects Allocated: " + subjectCount));

        // Close the document
        document.close();

        // Write the PDF to the response output stream
        byte[] pdfBytes = byteArrayOutputStream.toByteArray();
        response.getOutputStream().write(pdfBytes);
        response.getOutputStream().flush();
        
    } catch (Exception e) {
        e.printStackTrace(); // Print the stack trace for debugging
        response.setContentType("text/plain");
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
