<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Branches</title>
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
                        <a class="nav-link" href="admin-home.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="create_branch.jsp">Create Branch</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="update_branch.jsp">Update Branch</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="delete_branch.jsp">Delete Branch</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">View Branches</h4>

        <%
            String jdbcUrl = "jdbc:mysql://localhost:3306/atms";
            String jdbcUser = "root";
            String jdbcPassword = "ROOT";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            int branchCount = 0;

            try {
                // Establish connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

                // Query to get branch count
                String countSql = "SELECT COUNT(*) AS count FROM BRANCH";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(countSql);

                if (rs.next()) {
                    branchCount = rs.getInt("count");
                }

                // Query to get branch details
                String detailsSql = "SELECT Branch_Id, Branch_Name, Course FROM BRANCH";
                rs = stmt.executeQuery(detailsSql);
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

        <!-- Display the total number of branches -->
        <div class="mb-3">
            <strong>Total Number of Branches:</strong> <span id="branchCount"><%= branchCount %></span>
        </div>

        <!-- Table for displaying branches -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Branch ID</th>
                    <th>Branch Name</th>
                    <th>Course</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("Branch_Id") %></td>
                    <td><%= rs.getString("Branch_Name") %></td>
                    <td><%= rs.getString("Course") %></td>
                </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>

    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
