<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Faculty Profile</title>
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
                        <a class="nav-link" href="delete_faculty_profike.jsp">Delete Faculty</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="update_faculty_profile.jsp">Update Faculty</a>
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
        <h4 class="mb-4">Create New Faculty Profile</h4>

        <!-- JSP Logic to handle form submission and DB insertion -->
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

            if (facultyId != null && facultyName != null && facultyDob != null && facultyAddress != null &&
                branchId != null && designation != null && qualification != null && experience != null &&
                facultyEmail != null && facultyPhoneNo != null && salary != null && joiningDate != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                    String sql = "INSERT INTO FACULTY (Faculty_Id, Faculty_Name, Faculty_DOB, Faculty_Address, Branch_Id, Designation, Qualification, Experience, Faculty_Email, Faculty_Phone_No, Salary, Joining_Date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, facultyId);
                    stmt.setString(2, facultyName);
                    stmt.setDate(3, java.sql.Date.valueOf(facultyDob));
                    stmt.setString(4, facultyAddress);
                    stmt.setInt(5, Integer.parseInt(branchId));
                    stmt.setString(6, designation);
                    stmt.setString(7, qualification);
                    stmt.setInt(8, Integer.parseInt(experience));
                    stmt.setString(9, facultyEmail);
                    stmt.setString(10, facultyPhoneNo);
                    stmt.setInt(11, Integer.parseInt(salary));
                    stmt.setDate(12, java.sql.Date.valueOf(joiningDate));

                    int rowsInserted = stmt.executeUpdate();
                    if (rowsInserted > 0) {
                        message = "Faculty profile created successfully!";
                    }

                    stmt.close();
                    conn.close();
                } catch (SQLException | ClassNotFoundException e) {
                    message = "Error: " + e.getMessage();
                }
            }
        %>

        <!-- Display the result message -->
        <div class="alert alert-info"><%= message %></div>

        <!-- Form to Create Faculty Profile -->
        <form action="create_faculty_profile.jsp" method="post">
            <!-- Faculty ID -->
            <div class="mb-3">
                <label for="facultyId" class="form-label">Faculty ID</label>
                <input type="text" name="facultyId" id="facultyId" class="form-control" placeholder="Faculty ID" required>
            </div>

            <!-- Faculty Name -->
            <div class="mb-3">
                <label for="facultyName" class="form-label">Name</label>
                <input type="text" name="facultyName" id="facultyName" class="form-control" placeholder="Full Name" required>
            </div>

            <!-- Date of Birth -->
            <div class="mb-3">
                <label for="facultyDob" class="form-label">Date of Birth</label>
                <input type="date" name="facultyDob" id="facultyDob" class="form-control" required>
            </div>

            <!-- Address -->
            <div class="mb-3">
                <label for="facultyAddress" class="form-label">Address</label>
                <textarea name="facultyAddress" id="facultyAddress" class="form-control" placeholder="Address" required></textarea>
            </div>

            <!-- Branch ID -->
            <div class="mb-3">
                <label for="branchId" class="form-label">Branch ID</label>
                <input type="number" name="branchId" id="branchId" class="form-control" placeholder="Branch ID" required>
            </div>

            <!-- Designation -->
            <div class="mb-3">
                <label for="designation" class="form-label">Designation</label>
                <input type="text" name="designation" id="designation" class="form-control" placeholder="Designation" required>
            </div>

            <!-- Qualification -->
            <div class="mb-3">
                <label for="qualification" class="form-label">Qualification</label>
                <input type="text" name="qualification" id="qualification" class="form-control" placeholder="Qualification" required>
            </div>

            <!-- Experience -->
            <div class="mb-3">
                <label for="experience" class="form-label">Experience (Years)</label>
                <input type="number" name="experience" id="experience" class="form-control" placeholder="Years of Experience" required>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label for="facultyEmail" class="form-label">Email Address</label>
                <input type="email" name="facultyEmail" id="facultyEmail" class="form-control" placeholder="user@example.com" required>
            </div>

            <!-- Phone Number -->
            <div class="mb-3">
                <label for="facultyPhoneNo" class="form-label">Phone Number</label>
                <input type="text" name="facultyPhoneNo" id="facultyPhoneNo" class="form-control" placeholder="Phone Number" required>
            </div>

            <!-- Salary -->
            <div class="mb-3">
                <label for="salary" class="form-label">Salary</label>
                <input type="number" name="salary" id="salary" class="form-control" placeholder="Salary" required>
            </div>

            <!-- Joining Date -->
            <div class="mb-3">
                <label for="joiningDate" class="form-label">Joining Date</label>
                <input type="date" name="joiningDate" id="joiningDate" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary">Create Faculty Profile</button>
        </form>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
