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
        h1 {
            margin-bottom: 20px;
        }
        footer {
            background-color: #343a40;
            color: white;
            padding: 10px 0;
            position: relative;
            bottom: 0;
            width: 100%;
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

                // New placement for the button
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

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (eventRs != null) try { eventRs.close(); } catch (SQLException ignore) {}
                if (eventStmt != null) try { eventStmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </div>

    <footer>
        <div class="text-center">© 2024 ATMS - All Rights Reserved</div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
