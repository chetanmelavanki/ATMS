<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<%
    // Retrieve facultyId from the request parameters
    String facultyId = request.getParameter("facultyId");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar-custom {
            background-color: #007bff; /* Darker shade of blue */
            padding: 0.5rem 1rem;
        }
        .navbar-brand, .nav-link {
            color: #ffffff !important;
            font-weight: 500;
        }
        .container {
            margin-top: 5px;
        }
        footer {
            background-color: #343a40; /* Lighter grey color for footer */
            padding: 1rem;
            text-align: center;
            margin-top: 30px;
            border-top: 1px solid #ddd;
            font-size: 0.9rem;
            color:white;
        }
        h3, h4 {
            color: #004085;
        }
        hr {
            margin-top: 20px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="#">Faculty Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="faculty-home.jsp?facultyId=<%= facultyId %>">Home</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <h3>Faculty Profile</h3>

    <%
        Connection conn = null;
        PreparedStatement facultyStmt = null, eventStmt = null, subjectStmt = null;
        ResultSet facultyRs = null, eventRs = null, subjectRs = null;

        try {
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/atms";
            String dbUser = "root";
            String dbPassword = "ROOT";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Query to fetch faculty profile details
            String facultyQuery = "SELECT * FROM FACULTY WHERE Faculty_Id = ?";
            facultyStmt = conn.prepareStatement(facultyQuery);
            facultyStmt.setString(1, facultyId);
            facultyRs = facultyStmt.executeQuery();

            if (facultyRs.next()) {
                out.println("<table class='table table-bordered'><tr><th>Name</th><td>" + facultyRs.getString("Faculty_Name") + "</td></tr>");
                out.println("<tr><th>Email</th><td>" + facultyRs.getString("Faculty_Email") + "</td></tr>");
                out.println("<tr><th>Department</th><td>" + facultyRs.getString("Branch_Id") + "</td></tr>");
                out.println("<tr><th>Phone Number</th><td>" + facultyRs.getString("Faculty_Phone_No") + "</td></tr>");
                out.println("<tr><th>Designation</th><td>" + facultyRs.getString("Designation") + "</td></tr></table>");
            } else {
                out.println("<div class='alert alert-danger'>Faculty not found.</div>");
            }

            // Query to fetch event involvement details
            String eventQuery = "SELECT E.Event_Name, FI.Faculty_Involvement_Type, FI.Faculty_Involvement_Date " +
                                "FROM FACULTY_INVOLVEMENT FI " +
                                "JOIN EVENT E ON FI.Event_Id = E.Event_Id " +
                                "WHERE FI.Faculty_Id = ?";
            eventStmt = conn.prepareStatement(eventQuery);
            eventStmt.setString(1, facultyId);
            eventRs = eventStmt.executeQuery();

            out.println("<h4>Event Involvements</h4>");
            out.println("<a href='generate_faculty_event_report.jsp?facultyId=" + facultyId + "' class='btn btn-primary mb-3'>Download Event Involvement Report</a>");

            if (eventRs.next()) {
                out.println("<table class='table table-bordered'><thead><tr><th>Event Name</th><th>Involvement Type</th><th>Date</th></tr></thead><tbody>");
                do {
                    out.println("<tr><td>" + eventRs.getString("Event_Name") + "</td>");
                    out.println("<td>" + eventRs.getString("Faculty_Involvement_Type") + "</td>");
                    out.println("<td>" + eventRs.getDate("Faculty_Involvement_Date") + "</td></tr>");
                } while (eventRs.next());
                out.println("</tbody></table>");
            } else {
                out.println("<div class='alert alert-warning'>No events found for this faculty member.</div>");
            }

            // Query to fetch allocated subjects for the faculty
            String subjectQuery = "SELECT S.Subject_Code, S.Subject_Name, S.Credits, SA.Allocation_Date, SA.Sem " +
                                  "FROM FACULTY_ALLOCATION SA " +
                                  "JOIN SUBJECT S ON SA.Subject_Code = S.Subject_Code " +
                                  "WHERE SA.Faculty_Id = ?";
            subjectStmt = conn.prepareStatement(subjectQuery);
            subjectStmt.setString(1, facultyId);
            subjectRs = subjectStmt.executeQuery();

            out.println("<h4>Allocated Subjects</h4>");
            out.println("<a href='generate_faculty_subject_report.jsp?facultyId=" + facultyId + "' class='btn btn-primary mb-3'>Download Subject Allocation Report</a>");

            if (subjectRs.next()) {
                out.println("<table class='table table-bordered'><thead><tr><th>Subject Code</th><th>Subject Name</th><th>Credits</th><th>Semester</th><th>Allocation Date</th></tr></thead><tbody>");
                do {
                    out.println("<tr><td>" + subjectRs.getString("Subject_Code") + "</td>");
                    out.println("<td>" + subjectRs.getString("Subject_Name") + "</td>");
                    out.println("<td>" + subjectRs.getInt("Credits") + "</td>");
                    out.println("<td>" + subjectRs.getInt("Sem") + "</td>");
                    out.println("<td>" + subjectRs.getDate("Allocation_Date") + "</td></tr>");
                } while (subjectRs.next());
                out.println("</tbody></table>");
            } else {
                out.println("<div class='alert alert-warning'>No subjects allocated for this faculty member.</div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
        } finally {
            if (facultyRs != null) facultyRs.close();
            if (eventRs != null) eventRs.close();
            if (subjectRs != null) subjectRs.close();
            if (facultyStmt != null) facultyStmt.close();
            if (eventStmt != null) eventStmt.close();
            if (subjectStmt != null) subjectStmt.close();
            if (conn != null) conn.close();
        }
    %>
</div>

<!-- Separator Bar -->
<hr>

<!-- Footer -->
<footer>
    <p>&copy; 2024 Faculty Management System. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
