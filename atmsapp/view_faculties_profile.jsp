<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Faculty Profiles</title>
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
            max-width: 1000px;
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
                        <a class="nav-link" href="admin-home.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="create_faculty_profile.jsp">Create Faculty</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="delete_faculty_profile.jsp">Delete Faculty</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="update_faculty_profile.jsp">Update Faculty</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Faculty Profiles</h4>

        <!-- JSP Logic to Fetch and Display Faculty Profiles -->
        <%
            String dbUrl = "jdbc:mysql://localhost:3306/atms"; // Update with your DB name
            String dbUser = "root"; // Update with your DB username
            String dbPassword = "ROOT"; // Update with your DB password
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                stmt = conn.createStatement();
                String sql = "SELECT * FROM FACULTY";
                rs = stmt.executeQuery(sql);
        %>

        <!-- Table to Display Faculty Profiles -->
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Faculty ID</th>
                    <th>Name</th>
                    <th>Date of Birth</th>
                    <th>Address</th>
                    <th>Branch ID</th>
                    <th>Designation</th>
                    <th>Qualification</th>
                    <th>Experience (Years)</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                    <th>Salary</th>
                    <th>Joining Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("Faculty_Id") + "</td>");
                        out.println("<td>" + rs.getString("Faculty_Name") + "</td>");
                        out.println("<td>" + rs.getDate("Faculty_DOB") + "</td>");
                        out.println("<td>" + rs.getString("Faculty_Address") + "</td>");
                        out.println("<td>" + rs.getInt("Branch_Id") + "</td>");
                        out.println("<td>" + rs.getString("Designation") + "</td>");
                        out.println("<td>" + rs.getString("Qualification") + "</td>");
                        out.println("<td>" + rs.getInt("Experience") + "</td>");
                        out.println("<td>" + rs.getString("Faculty_Email") + "</td>");
                        out.println("<td>" + rs.getString("Faculty_Phone_No") + "</td>");
                        out.println("<td>" + rs.getInt("Salary") + "</td>");
                        out.println("<td>" + rs.getDate("Joining_Date") + "</td>");
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>

        <%
            } catch (SQLException | ClassNotFoundException e) {
                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        %>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
