<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Subject - Academic Task Management System</title>
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
                        <a class="nav-link" href="view_subjects.jsp">View Subjects</a>
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
        <h4 class="mb-4">Update Subject</h4>
        <%
            String message = "";
            String subjectCode = request.getParameter("subjectCode");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            if (request.getMethod().equalsIgnoreCase("POST") && subjectCode != null && !subjectCode.isEmpty()) {
                String subjectName = request.getParameter("subjectName");
                int credits = Integer.parseInt(request.getParameter("credits"));
                int semester = Integer.parseInt(request.getParameter("semester"));
                int branchId = Integer.parseInt(request.getParameter("branchId"));
                String facultyId = request.getParameter("facultyId");
                String syllabus = request.getParameter("syllabus");

                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/atms", "root", "ROOT");

                    String sql = "UPDATE SUBJECT SET Subject_Name=?, Credits=?, Semester=?, Branch_Id=?, Faculty_Id=?, Syllabus=? WHERE Subject_Code=?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, subjectName);
                    ps.setInt(2, credits);
                    ps.setInt(3, semester);
                    ps.setInt(4, branchId);
                    ps.setString(5, facultyId);
                    ps.setString(6, syllabus);
                    ps.setString(7, subjectCode);

                    int result = ps.executeUpdate();

                    if (result > 0) {
                        message = "Subject updated successfully!";
                    } else {
                        message = "Failed to update the subject. Please ensure the Subject Code is correct.";
                    }

                } catch (Exception e) {
                    message = "Error: " + e.getMessage();
                } finally {
                    try {
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }

            // Fetch the subject details if Subject Code is provided
            if (subjectCode != null && !subjectCode.isEmpty()) {
                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/atms", "root", "ROOT");

                    String sql = "SELECT * FROM SUBJECT WHERE Subject_Code=?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, subjectCode);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        request.setAttribute("subjectName", rs.getString("Subject_Name"));
                        request.setAttribute("credits", rs.getInt("Credits"));
                        request.setAttribute("semester", rs.getInt("Semester"));
                        request.setAttribute("branchId", rs.getInt("Branch_Id"));
                        request.setAttribute("facultyId", rs.getString("Faculty_Id"));
                        request.setAttribute("syllabus", rs.getString("Syllabus"));
                    } else {
                        message = "No subject found with the provided Subject Code.";
                    }

                } catch (Exception e) {
                    message = "Error: " + e.getMessage();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>

        <!-- Display Feedback -->
        <%
            if (!message.isEmpty()) {
        %>
        <div class="alert <%= message.contains("successfully") ? "alert-success" : "alert-danger" %>" role="alert">
            <%= message %>
        </div>
        <% 
            }
        %>

        <!-- Update Subject Form -->
        <form action="update_subject.jsp" method="POST">
            <div class="form-group">
                <label for="subjectCode" class="form-label">Subject Code</label>
                <input type="text" id="subjectCode" name="subjectCode" class="form-control" placeholder="Enter Subject Code to Update" required >
            </div>
            <div class="form-group">
                <label for="subjectName" class="form-label">Subject Name</label>
                <input type="text" id="subjectName" name="subjectName" class="form-control" placeholder="Subject Name" required>
            </div>
            <div class="form-group">
                <label for="credits" class="form-label">Credits</label>
                <input type="number" id="credits" name="credits" class="form-control" placeholder="Credits"  required>
            </div>
            <div class="form-group">
                <label for="semester" class="form-label">Semester</label>
                <input type="number" id="semester" name="semester" class="form-control" placeholder="Semester"  required>
            </div>
            <div class="form-group">
                <label for="branchId" class="form-label">Branch ID</label>
                <input type="number" id="branchId" name="branchId" class="form-control" placeholder="Branch ID"  required>
            </div>
            <div class="form-group">
                <label for="facultyId" class="form-label">Faculty ID</label>
                <input type="text" id="facultyId" name="facultyId" class="form-control" placeholder="Faculty ID" >
            </div>
            <div class="form-group">
                <label for="syllabus" class="form-label">Syllabus</label>
                <input type="text" id="syllabus" name="syllabus" class="form-control" placeholder="Syllabus"  required>
            </div>
            <button type="submit" class="btn btn-primary mt-3">Update Subject</button>
        </form>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
