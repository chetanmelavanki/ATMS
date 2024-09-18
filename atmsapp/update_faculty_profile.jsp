<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Faculty Details</title>
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
                        <a class="nav-link" href="delete_faculty_profile.jsp">Delete Faculty</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="create_faculty_profile.jsp">Create Faculty</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view_faculties_profile.jsp">View Faculties</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Update Faculty Details</h4>
        <form action="update_faculty_profile.jsp" method="post">
            <div class="mb-3">
                <label for="facultyId" class="form-label">Faculty ID</label>
                <input type="text" name="facultyId" id="facultyId" class="form-control" placeholder="Faculty ID" required>
            </div>
            <div class="mb-3">
                <label for="facultyName" class="form-label">Faculty Name</label>
                <input type="text" name="facultyName" id="facultyName" class="form-control" placeholder="Faculty Name" required>
            </div>
            <div class="mb-3">
                <label for="facultyDob" class="form-label">Date of Birth</label>
                <input type="date" name="facultyDob" id="facultyDob" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="facultyAddress" class="form-label">Address</label>
                <input type="text" name="facultyAddress" id="facultyAddress" class="form-control" placeholder="Address" required>
            </div>
            <div class="mb-3">
                <label for="branchId" class="form-label">Branch ID</label>
                <input type="number" name="branchId" id="branchId" class="form-control" placeholder="Branch ID">
            </div>
            <div class="mb-3">
                <label for="designation" class="form-label">Designation</label>
                <input type="text" name="designation" id="designation" class="form-control" placeholder="Designation" required>
            </div>
            <div class="mb-3">
                <label for="qualification" class="form-label">Qualification</label>
                <input type="text" name="qualification" id="qualification" class="form-control" placeholder="Qualification" required>
            </div>
            <div class="mb-3">
                <label for="experience" class="form-label">Experience (years)</label>
                <input type="number" name="experience" id="experience" class="form-control" placeholder="Experience in years">
            </div>
            <div class="mb-3">
                <label for="facultyEmail" class="form-label">Email Address</label>
                <input type="email" name="facultyEmail" id="facultyEmail" class="form-control" placeholder="user@example.com" required>
            </div>
            <div class="mb-3">
                <label for="facultyPhoneNo" class="form-label">Phone Number</label>
                <input type="text" name="facultyPhoneNo" id="facultyPhoneNo" class="form-control" placeholder="Phone Number" required>
            </div>
            <div class="mb-3">
                <label for="salary" class="form-label">Salary</label>
                <input type="number" name="salary" id="salary" class="form-control" placeholder="Salary">
            </div>
            <div class="mb-3">
                <label for="joiningDate" class="form-label">Joining Date</label>
                <input type="date" name="joiningDate" id="joiningDate" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Update Faculty Details</button>
        </form>

        <!-- JSP Logic for handling form submission -->
        <%
            String facultyId = request.getParameter("facultyId");
            String facultyName = request.getParameter("facultyName");
            String facultyDob = request.getParameter("facultyDob");
            String facultyAddress = request.getParameter("facultyAddress");
            String branchId = request.getParameter("branchId");
            String designation = request.getParameter("designation");
            String qualification = request.getParameter("qualification");
            String experience = request.getParameter("experience");
            String facultyEmail = request.getParameter("facultyEmail");
            String facultyPhoneNo = request.getParameter("facultyPhoneNo");
            String salary = request.getParameter("salary");
            String joiningDate = request.getParameter("joiningDate");
            String message = "";

            String dbUrl = "jdbc:mysql://localhost:3306/atms"; // Update with your DB name
            String dbUser = "root"; // Update with your DB username
            String dbPassword = "ROOT"; // Update with your DB password

            if (facultyId != null && facultyName != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                    // Prepare SQL statement for updating faculty details
                    String sql = "UPDATE FACULTY SET Faculty_Name = ?, Faculty_DOB = ?, Faculty_Address = ?, Branch_Id = ?, Designation = ?, Qualification = ?, Experience = ?, Faculty_Email = ?, Faculty_Phone_No = ?, Salary = ?, Joining_Date = ? WHERE Faculty_Id = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, facultyName);
                    stmt.setDate(2, java.sql.Date.valueOf(facultyDob));
                    stmt.setString(3, facultyAddress);
                    stmt.setInt(4, branchId != null && !branchId.isEmpty() ? Integer.parseInt(branchId) : 0);
                    stmt.setString(5, designation);
                    stmt.setString(6, qualification);
                    stmt.setInt(7, experience != null && !experience.isEmpty() ? Integer.parseInt(experience) : 0);
                    stmt.setString(8, facultyEmail);
                    stmt.setString(9, facultyPhoneNo);
                    stmt.setInt(10, salary != null && !salary.isEmpty() ? Integer.parseInt(salary) : 0);
                    stmt.setDate(11, java.sql.Date.valueOf(joiningDate));
                    stmt.setString(12, facultyId);

                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        message = "Faculty details updated successfully!";
                    } else {
                        message = "Error: Faculty not found or update failed.";
                    }

                    stmt.close();
                    conn.close();
                } catch (SQLException | ClassNotFoundException e) {
                    message = "Error: " + e.getMessage();
                }
            }

            if (!message.isEmpty()) {
        %>
                <div class="alert alert-info"><%= message %></div>
        <%
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
