<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Subjects - Academic Task Management System</title>
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
            padding: 20px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            background-color: #ffffff;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
        }
        footer {
            background-color: #343a40;
            color: #ffffff;
            padding: 10px 0;
            text-align: center;
            width: 100%;
            position: relative;
            bottom: 0;
            margin-top: 20px;
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
                        <a class="nav-link" href="create_subject.jsp">Create Subject</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="update_subject.jsp">Update Subject</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="delete_subject.jsp">Delete Subject</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">View Subjects</h4>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/atms", "root", "ROOT");

                String sql = "SELECT * FROM SUBJECT";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                if (rs.next()) {
        %>
            <table class="table table-striped">
                <thead>
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
                        do {
                    %>
                        <tr>
                            <td><%= rs.getString("Subject_Code") %></td>
                            <td><%= rs.getString("Subject_Name") %></td>
                            <td><%= rs.getInt("Credits") %></td>
                            <td><%= rs.getInt("Semester") %></td>
                            <td><%= rs.getInt("Branch_Id") %></td>
                            <td><%= rs.getString("Faculty_Id") %></td>
                            <td><%= rs.getString("Syllabus") %></td>
                        </tr>
                    <%
                        } while (rs.next());
                    %>
                </tbody>
            </table>
        <%
                } else {
        %>
            <div class="alert alert-info" role="alert">
                No subjects found.
            </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
            <div class="alert alert-danger" role="alert">
                Error: <%= e.getMessage() %>
            </div>
        <%
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
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
