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
    String facultyId = request.getParameter("faculty_id");
    String facultyName = "";
    int subjectCount = 0;

    // Set response type for PDF
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=faculty_subject_report.pdf");

    ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
    Connection connection = null;

    try {
        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/atms"; // Update with your DB name
        String dbUser = "root";  // Change as per your DB username
        String dbPassword = "ROOT";  // Change as per your DB password

        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to fetch faculty name
        String facultyQuery = "SELECT Faculty_Name FROM FACULTY WHERE Faculty_Id = ?";
        PreparedStatement facultyStatement = connection.prepareStatement(facultyQuery);
        facultyStatement.setString(1, facultyId);
        
        ResultSet facultyResultSet = facultyStatement.executeQuery();
        
        if (facultyResultSet.next()) {
            facultyName = facultyResultSet.getString("Faculty_Name");
        } else {
            throw new Exception("Faculty not found for ID: " + facultyId);
        }

        // Query to fetch subject allocation details for the faculty
        String subjectQuery = "SELECT S.Subject_Code, S.Subject_Name, S.Credits, FA.Sem, FA.Academic_Year, FA.Allocation_Date " +
                              "FROM FACULTY_ALLOCATION FA " +
                              "JOIN SUBJECT S ON FA.Subject_Code = S.Subject_Code " +
                              "WHERE FA.Faculty_Id = ?";
        
        PreparedStatement subjectStatement = connection.prepareStatement(subjectQuery);
        subjectStatement.setString(1, facultyId);
        
        ResultSet subjectResultSet = subjectStatement.executeQuery();
        
        // Create PDF document
        PdfWriter pdfWriter = new PdfWriter(byteArrayOutputStream);
        PdfDocument pdfDocument = new PdfDocument(pdfWriter);
        Document document = new Document(pdfDocument);

        // Add content to the PDF
        document.add(new Paragraph("Faculty Subject Allocation Report").setFontSize(20));
        document.add(new Paragraph("Faculty ID: " + facultyId));
        document.add(new Paragraph("Faculty Name: " + facultyName));
        document.add(new Paragraph("\n"));

        // Create a table for subject details
        Table table = new Table(5); // 5 columns for Subject Code, Subject Name, Credits, Semester, and Academic Year
        table.addHeaderCell(new Cell().add(new Paragraph("Subject Code")));
        table.addHeaderCell(new Cell().add(new Paragraph("Subject Name")));
        table.addHeaderCell(new Cell().add(new Paragraph("Credits")));
        table.addHeaderCell(new Cell().add(new Paragraph("Semester")));
        table.addHeaderCell(new Cell().add(new Paragraph("Academic Year")));

        // Populate the table with subject data
        while (subjectResultSet.next()) {
            String subjectCode = subjectResultSet.getString("Subject_Code");
            String subjectName = subjectResultSet.getString("Subject_Name");
            String credits = subjectResultSet.getString("Credits");
            String semester = subjectResultSet.getString("Sem");
            String academicYear = subjectResultSet.getString("Academic_Year");
            String allocationDate = subjectResultSet.getString("Allocation_Date");

            // Adding cells to the table
            table.addCell(new Cell().add(new Paragraph(subjectCode)));
            table.addCell(new Cell().add(new Paragraph(subjectName)));
            table.addCell(new Cell().add(new Paragraph(credits)));
            table.addCell(new Cell().add(new Paragraph(semester)));
            table.addCell(new Cell().add(new Paragraph(academicYear)));
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
