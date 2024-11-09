<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String usn = request.getParameter("usn");
    String studentName = "";

    try {
        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/atms";  // Adjust to your database name
        String dbUser = "root";  // Adjust to your database username
        String dbPass = "ROOT";  // Adjust to your database password

        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Query to fetch student name
        String queryStudent = "SELECT Student_Name FROM STUDENT WHERE USN = ?";
        PreparedStatement studentStatement = connection.prepareStatement(queryStudent);
        studentStatement.setString(1, usn);

        ResultSet studentResult = studentStatement.executeQuery();
        if (studentResult.next()) {
            studentName = studentResult.getString("Student_Name");
        }
        studentResult.close();
        studentStatement.close();

        // Query to fetch subject data
        String querySubjects = "SELECT Subject_Code, Subject_Name, Credits, Semester, Branch_Id, Faculty_Id, Syllabus FROM SUBJECT";
        Statement subjectStatement = connection.createStatement();
        ResultSet subjectResultSet = subjectStatement.executeQuery(querySubjects);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Assessments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Welcome, <%= studentName %></h2>
        <h4 class="text-center">Your Enrolled Subjects</h4>

        <!-- Table to display subject data -->
        <table class="table table-bordered table-striped mt-3">
            <thead class="table-dark">
                <tr>
                    <th>Subject Code</th>
                    <th>Subject Name</th>
                    <th>Credits</th>
                    <th>Semester</th>
                    <th>Branch ID</th>
                    <th>Faculty ID</th>
                    <th>Syllabus</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Display each row of subject data
                    while (subjectResultSet.next()) {
                %>
                <tr>
                    <td><%= subjectResultSet.getString("Subject_Code") %></td>
                    <td><%= subjectResultSet.getString("Subject_Name") %></td>
                    <td><%= subjectResultSet.getInt("Credits") %></td>
                    <td><%= subjectResultSet.getInt("Semester") %></td>
                    <td><%= subjectResultSet.getInt("Branch_Id") %></td>
                    <td><%= subjectResultSet.getString("Faculty_Id") %></td>
                    <td><%= subjectResultSet.getString("Syllabus") %></td>
                </tr>
                <%
                    }
                    // Close resources
                    subjectResultSet.close();
                    subjectStatement.close();
                    connection.close();
                %>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
