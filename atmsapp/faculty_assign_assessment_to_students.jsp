<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Assessment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="#">Assign Assessment</a>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <!-- Use request.getParameter("facultyId") here -->
                        <a class="nav-link" href="faculty-home.jsp?facultyId=<%= request.getParameter("facultyId") %>">Back to Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="text-center">Assign Assessment to Student</h2>

        <!-- Check if the form is submitted -->
        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                // Capture form data
                String usn = request.getParameter("usn");
                String assessmentType = request.getParameter("assessmentType");
                String subjectCode = request.getParameter("subjectCode");
                String assessmentDate = request.getParameter("assessmentDate");
                int totalMarks = Integer.parseInt(request.getParameter("totalMarks"));
                String status = request.getParameter("status");
                String facultyId = request.getParameter("facultyId"); // This comes from the parameter

                // Database connection details
                String dbURL = "jdbc:mysql://localhost:3306/atms";  // Change this to your database name
                String dbUser = "root";  // Change to your database username
                String dbPass = "ROOT";  // Change to your database password

                try {
                    // Load JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish connection
                    Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

                    // Query to insert assessment details into the database
                    String query = "INSERT INTO ASSESSMENT (Assessment_Type, Date_Of_Assessment, USN, Subject_Code, Total_Marks, Faculty_Id, Status) " +
                                   "VALUES (?, ?, ?, ?, ?, ?, ?)";

                    // Prepare the statement
                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setString(1, assessmentType);
                    ps.setString(2, assessmentDate);
                    ps.setString(3, usn);
                    ps.setString(4, subjectCode);
                    ps.setInt(5, totalMarks);
                    ps.setString(6, facultyId);
                    ps.setString(7, status);

                    // Execute the insert query
                    int rowsAffected = ps.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<div class='alert alert-success'>Assessment assigned successfully!</div>");
                    } else {
                        out.println("<div class='alert alert-danger'>Error assigning assessment. Please try again.</div>");
                    }

                    // Close all connections
                    ps.close();
                    connection.close();

                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                }
            }
        %>

        <!-- Form to assign assessment -->
        <form action="faculty_assign_assessment_to_students.jsp" method="post">
            <div class="mb-3">
                <label for="usn" class="form-label">Student USN</label>
                <input type="text" class="form-control" id="usn" name="usn" required>
            </div>

            <div class="mb-3">
                <label for="assessmentType" class="form-label">Assessment Type</label>
                <select class="form-select" id="assessmentType" name="assessmentType" required>
                    <option value="CIE1">CIE1</option>
                    <option value="CIE2">CIE2</option>
                    <option value="CIE3">CIE3</option>
                    <option value="SEE">SEE</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="subjectCode" class="form-label">Subject Code</label>
                <input type="text" class="form-control" id="subjectCode" name="subjectCode" required>
            </div>

            <div class="mb-3">
                <label for="assessmentDate" class="form-label">Assessment Date</label>
                <input type="date" class="form-control" id="assessmentDate" name="assessmentDate" required>
            </div>

            <div class="mb-3">
                <label for="totalMarks" class="form-label">Total Marks</label>
                <input type="number" class="form-control" id="totalMarks" name="totalMarks" required min="0" max="100">
            </div>

            <div class="mb-3">
                <label for="status" class="form-label">Status</label>
                <select class="form-select" id="status" name="status" required>
                    <option value="Pass">Pass</option>
                    <option value="Fail">Fail</option>
                </select>
            </div>

            <!-- Auto-fill Faculty ID from request parameter -->
            <div class="mb-3">
                <label for="facultyId" class="form-label">Faculty ID</label>
                <input type="text" class="form-control" id="facultyId" name="facultyId" value="<%= request.getParameter("facultyId") %>" readonly>
            </div>

            <button type="submit" class="btn btn-primary">Assign Assessment</button>
        </form>
    </div>

    <footer class="text-center mt-4">
        <p>© 2024 ATMS - All Rights Reserved</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
