<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-container {
            padding: 30px;
            border-radius: 8px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        footer {
            background-color: #343a40;
            color: white;
            padding: 10px 0;
            width: 100%;
            position: relative;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <a class="navbar-brand" href="#">Student Profile</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="student-home.jsp?usn=<%= request.getParameter("usn") %>">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container profile-container">
    <h1>Student Profile</h1>
    <%
        String usn = request.getParameter("usn");
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        PreparedStatement eventStmt = null;
        ResultSet eventRs = null;

        try {
            String dbURL = "jdbc:mysql://localhost:3306/atms";
            String dbUser = "root";
            String dbPassword = "ROOT";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Query to fetch student details
            String query = "SELECT * FROM STUDENT WHERE USN = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, usn);
            rs = stmt.executeQuery();

            if (rs.next()) {
                out.println("<table class='table table-bordered table-striped'>");
                out.println("<thead class='table-light'><tr><th>Field</th><th>Value</th></tr></thead>");
                out.println("<tbody>");
                out.println("<tr><td>USN</td><td>" + rs.getString("USN") + "</td></tr>");
                out.println("<tr><td>Name</td><td>" + rs.getString("Student_Name") + "</td></tr>");
                out.println("<tr><td>Date of Birth</td><td>" + rs.getDate("Student_DOB") + "</td></tr>");
                out.println("<tr><td>Gender</td><td>" + rs.getString("Student_Gender") + "</td></tr>");
                out.println("<tr><td>Email</td><td>" + rs.getString("Student_Email") + "</td></tr>");
                out.println("<tr><td>Phone Number</td><td>" + rs.getString("Student_Phone_Number") + "</td></tr>");
                out.println("<tr><td>Date of Admission</td><td>" + rs.getDate("Date_Of_Admission") + "</td></tr>");
                out.println("<tr><td>Qualification</td><td>" + rs.getString("Student_Qualification") + "</td></tr>");
                out.println("<tr><td>Address</td><td>" + rs.getString("Student_Address") + "</td></tr>");
                out.println("<tr><td>Branch ID</td><td>" + rs.getInt("Branch_Id") + "</td></tr>");
                out.println("<tr><td>Year of Study</td><td>" + rs.getString("Year_Of_Study") + "</td></tr>");
                out.println("</tbody></table>");
            } else {
                out.println("<div class='alert alert-danger'>No student found with USN: " + usn + "</div>");
            }

            // Query to fetch student's event involvement details
            String eventQuery = "SELECT E.Event_Name, SI.Student_Involvement_Type, SI.Student_Involvement_Date " +
                                "FROM STUDENT_INVOLVEMENT SI " +
                                "JOIN EVENT E ON SI.Event_Id = E.Event_Id " +
                                "WHERE SI.USN = ?";
            eventStmt = conn.prepareStatement(eventQuery);
            eventStmt.setString(1, usn);
            eventRs = eventStmt.executeQuery();

            out.println("<div class='d-flex justify-content-between align-items-center mt-3'>");
            out.println("<h2>Event Involvements</h2>");
            out.println("<a href='generate_student_event_report.jsp?usn=" + request.getParameter("usn") + "' class='btn btn-primary'>Download Event Participation Report</a>");
            out.println("</div>");

            if (eventRs.next()) {
                out.println("<table class='table table-bordered table-striped'>");
                out.println("<thead class='table-light'><tr><th>Event Name</th><th>Involvement Type</th><th>Date</th></tr></thead>");
                out.println("<tbody>");
                do {
                    out.println("<tr><td>" + eventRs.getString("Event_Name") + "</td>");
                    out.println("<td>" + eventRs.getString("Student_Involvement_Type") + "</td>");
                    out.println("<td>" + eventRs.getDate("Student_Involvement_Date") + "</td></tr>");
                } while (eventRs.next());
                out.println("</tbody></table>");
            } else {
                out.println("<div class='alert alert-warning'>No events found for this student.</div>");
            }

            // Query to fetch allocated subjects for the student
            PreparedStatement subjectStmt = null;
            ResultSet subjectRs = null;

            try {
                String subjectQuery = "SELECT S.Subject_Code, S.Subject_Name, S.Credits, S.Semester, S.Syllabus " +
                                      "FROM STUDENT_ALLOCATED SA " +
                                      "JOIN SUBJECT S ON SA.Subject_Code = S.Subject_Code " +
                                      "WHERE SA.USN = ?";
                subjectStmt = conn.prepareStatement(subjectQuery);
                subjectStmt.setString(1, usn);
                subjectRs = subjectStmt.executeQuery();

                out.println("<div class='d-flex justify-content-between align-items-center mt-3'>");
                out.println("<h2>Allocated Subjects</h2>");
                out.println("<a href='generate_student_subject_report.jsp?usn=" + usn + "' class='btn btn-primary'>Download Subject Allocation Report</a>");
                out.println("</div>");

                if (subjectRs.next()) {
                    out.println("<table class='table table-bordered table-striped'>");
                    out.println("<thead class='table-light'><tr><th>Subject Code</th><th>Subject Name</th><th>Credits</th><th>Semester</th><th>Syllabus</th></tr></thead>");
                    out.println("<tbody>");
                    do {
                        out.println("<tr><td>" + subjectRs.getString("Subject_Code") + "</td>");
                        out.println("<td>" + subjectRs.getString("Subject_Name") + "</td>");
                        out.println("<td>" + subjectRs.getInt("Credits") + "</td>");
                        out.println("<td>" + subjectRs.getInt("Semester") + "</td>");
                        out.println("<td>" + subjectRs.getString("Syllabus") + "</td></tr>");
                    } while (subjectRs.next());
                    out.println("</tbody></table>");
                } else {
                    out.println("<div class='alert alert-warning'>No subjects allocated for this student.</div>");
                }
            } finally {
                if (subjectRs != null) subjectRs.close();
                if (subjectStmt != null) subjectStmt.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (eventRs != null) eventRs.close();
            if (eventStmt != null) eventStmt.close();
            if (conn != null) conn.close();
        }
    %>
</div>

<footer>
    <div class="text-center">© 2024 ATMS - All Rights Reserved</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
