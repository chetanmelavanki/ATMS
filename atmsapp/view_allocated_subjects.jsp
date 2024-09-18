<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Allocated Subjects</title>
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
                        <a class="nav-link" href="student-home.jsp">Home</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">View Allocated Subjects</h4>
        <form action="view_allocated_subjects.jsp" method="post">
            <div class="mb-3">
                <label for="usn" class="form-label">USN</label>
                <input type="text" name="usn" id="usn" class="form-control" placeholder="Enter USN" required>
            </div>
            <button type="submit" class="btn btn-primary">Fetch Details</button>
        </form>

        <!-- JSP Logic for handling form submission -->
        <%
            String usn = request.getParameter("usn");
            String message = "";
            ResultSet rs = null;

            String dbUrl = "jdbc:mysql://localhost:3306/atms"; // Update with your DB name
            String dbUser = "root"; // Update with your DB username
            String dbPassword = "ROOT"; // Update with your DB password

            if (usn != null && !usn.isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                    // SQL query to fetch allocated subjects for the given USN
                    String sql = "SELECT sa.USN, sa.Subject_Code, s.Subject_Name, s.Credits, s.Semester, sa.Date_Of_Admission, sa.Academic_Year, sa.Sem " +
                                 "FROM STUDENT_ALLOCATED sa " +
                                 "JOIN SUBJECT s ON sa.Subject_Code = s.Subject_Code " +
                                 "WHERE sa.USN = ?";
                    
                    PreparedStatement stmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    stmt.setString(1, usn);
                    rs = stmt.executeQuery();

                    if (!rs.next()) {
                        message = "No subjects allocated for the given USN.";
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    message = "Error: " + e.getMessage();
                }
            }
        %>

        <!-- Display the result -->
        <%
            if (rs != null) {
                rs.beforeFirst(); // Move cursor to the start
        %>
                <table class="table table-striped mt-4">
                    <thead>
                        <tr>
                            <th>USN</th>
                            <th>Subject Code</th>
                            <th>Subject Name</th>
                            <th>Credits</th>
                            <th>Semester</th>
                            <th>Date of Admission</th>
                            <th>Academic Year</th>
                            <th>Semester</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while (rs.next()) {
                                String subjectCode = rs.getString("Subject_Code");
                                String subjectName = rs.getString("Subject_Name");
                                int credits = rs.getInt("Credits");
                                int semester = rs.getInt("Semester");
                                Date dateOfAdmission = rs.getDate("Date_Of_Admission");
                                String academicYear = rs.getString("Academic_Year");
                                int allocatedSem = rs.getInt("Sem");
                        %>
                                <tr>
                                    <td><%= usn %></td>
                                    <td><%= subjectCode %></td>
                                    <td><%= subjectName %></td>
                                    <td><%= credits %></td>
                                    <td><%= semester %></td>
                                    <td><%= dateOfAdmission %></td>
                                    <td><%= academicYear %></td>
                                    <td><%= allocatedSem %></td>
                                </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
        <%
            } else if (!message.isEmpty()) {
        %>
                <div class="alert alert-info mt-4"><%= message %></div>
        <%
            }
            if (rs != null) rs.close();
        %>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
