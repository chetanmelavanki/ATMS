<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Student Profile</title>
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
                        <a class="nav-link" href="create_student_profile.jsp">Create Student</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view_students_profile.jsp">View Student</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="delete_student_profile.jsp">Delete Student</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view_students_profile.jsp">View Students</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Update Student Profile</h4>
        <form action="update_student_profile.jsp" method="post">
            <div class="mb-3">
                <label for="usn" class="form-label">USN</label>
                <input type="text" name="usn" id="usn" class="form-control" placeholder="USN" required>
            </div>
            <div class="mb-3">
                <label for="studentName" class="form-label">Student Name</label>
                <input type="text" name="studentName" id="studentName" class="form-control" placeholder="Student Name">
            </div>
            <div class="mb-3">
                <label for="dob" class="form-label">Date of Birth</label>
                <input type="date" name="dob" id="dob" class="form-control">
            </div>
            <div class="mb-3">
                <label for="gender" class="form-label">Gender</label>
                <select name="gender" id="gender" class="form-select">
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" name="email" id="email" class="form-control" placeholder="student@example.com">
            </div>
            <div class="mb-3">
                <label for="phoneNumber" class="form-label">Phone Number</label>
                <input type="text" name="phoneNumber" id="phoneNumber" class="form-control" placeholder="1234567890">
            </div>
            <div class="mb-3">
                <label for="admissionDate" class="form-label">Date of Admission</label>
                <input type="date" name="admissionDate" id="admissionDate" class="form-control">
            </div>
            <div class="mb-3">
                <label for="qualification" class="form-label">Qualification</label>
                <input type="text" name="qualification" id="qualification" class="form-control" placeholder="Qualification">
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <input type="text" name="address" id="address" class="form-control" placeholder="Address">
            </div>
            <div class="mb-3">
                <label for="branchId" class="form-label">Branch ID</label>
                <input type="number" name="branchId" id="branchId" class="form-control" placeholder="Branch ID">
            </div>
            <div class="mb-3">
                <label for="yearOfStudy" class="form-label">Year of Study</label>
                <input type="text" name="yearOfStudy" id="yearOfStudy" class="form-control" placeholder="Year of Study">
            </div>
            <button type="submit" class="btn btn-primary">Update Profile</button>
        </form>

        <!-- JSP Logic for handling form submission -->
        <%
            String usn = request.getParameter("usn");
            String studentName = request.getParameter("studentName");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String admissionDate = request.getParameter("admissionDate");
            String qualification = request.getParameter("qualification");
            String address = request.getParameter("address");
            String branchId = request.getParameter("branchId");
            String yearOfStudy = request.getParameter("yearOfStudy");
            String message = "";

            String dbUrl = "jdbc:mysql://localhost:3306/atms"; // Update with your DB name
            String dbUser = "root"; // Update with your DB username
            String dbPassword = "ROOT"; // Update with your DB password

            if (usn != null && !usn.isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

                    // Prepare SQL statement for updating a student record
                    StringBuilder sql = new StringBuilder("UPDATE STUDENT SET ");
                    if (studentName != null && !studentName.isEmpty()) sql.append("Student_Name = ?, ");
                    if (dob != null && !dob.isEmpty()) sql.append("Student_DOB = ?, ");
                    if (gender != null && !gender.isEmpty()) sql.append("Student_Gender = ?, ");
                    if (email != null && !email.isEmpty()) sql.append("Student_Email = ?, ");
                    if (phoneNumber != null && !phoneNumber.isEmpty()) sql.append("Student_Phone_Number = ?, ");
                    if (admissionDate != null && !admissionDate.isEmpty()) sql.append("Date_Of_Admission = ?, ");
                    if (qualification != null && !qualification.isEmpty()) sql.append("Student_Qualification = ?, ");
                    if (address != null && !address.isEmpty()) sql.append("Student_Address = ?, ");
                    if (branchId != null && !branchId.isEmpty()) sql.append("Branch_Id = ?, ");
                    if (yearOfStudy != null && !yearOfStudy.isEmpty()) sql.append("Year_Of_Study = ? ");
                    sql.append("WHERE USN = ?");

                    PreparedStatement stmt = conn.prepareStatement(sql.toString());
                    int index = 1;

                    if (studentName != null && !studentName.isEmpty()) stmt.setString(index++, studentName);
                    if (dob != null && !dob.isEmpty()) stmt.setDate(index++, java.sql.Date.valueOf(dob));
                    if (gender != null && !gender.isEmpty()) stmt.setString(index++, gender);
                    if (email != null && !email.isEmpty()) stmt.setString(index++, email);
                    if (phoneNumber != null && !phoneNumber.isEmpty()) stmt.setString(index++, phoneNumber);
                    if (admissionDate != null && !admissionDate.isEmpty()) stmt.setDate(index++, java.sql.Date.valueOf(admissionDate));
                    if (qualification != null && !qualification.isEmpty()) stmt.setString(index++, qualification);
                    if (address != null && !address.isEmpty()) stmt.setString(index++, address);
                    if (branchId != null && !branchId.isEmpty()) stmt.setInt(index++, Integer.parseInt(branchId));
                    if (yearOfStudy != null && !yearOfStudy.isEmpty()) stmt.setString(index++, yearOfStudy);

                    stmt.setString(index, usn);

                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        message = "Student profile updated successfully!";
                    } else {
                        message = "Error: Student profile update failed.";
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
