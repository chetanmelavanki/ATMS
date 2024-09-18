<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Subject Management - Academic Task Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            background-color: #f8f9fa; /* Light gray background */
        }
        .container {
            flex: 1;
            max-width: 800px;
            margin-top: 20px;
        }
        footer {
            background-color: #343a40; /* Dark background for footer */
            color: #ffffff;
            padding: 10px 0;
            text-align: center;
        }
        .card {
            cursor: pointer;
            transition: transform 0.2s; /* Smooth scaling on hover */
        }
        .card:hover {
            transform: scale(1.05); /* Slightly increase size on hover */
        }
        .card-title {
            font-weight: bold;
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
                        <a class="nav-link" href="<%= request.getContextPath() %>/admin-home.jsp">Home</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Subject Management</h4>
        <div class="row">
            <!-- Create Subject -->
            <div class="col-md-3 mb-4">
                <div class="card border-primary" onclick="window.location.href='<%= request.getContextPath() %>/create_subject.jsp';">
                    <div class="card-body">
                        <h5 class="card-title">Create Subject</h5>
                        <p class="card-text">Click here to create a new subject.</p>
                    </div>
                </div>
            </div>
            <!-- View Subjects -->
            <div class="col-md-3 mb-4">
                <div class="card border-primary" onclick="window.location.href='<%= request.getContextPath() %>/view_subjects.jsp';">
                    <div class="card-body">
                        <h5 class="card-title">View Subjects</h5>
                        <p class="card-text">Click here to view all subjects.</p>
                    </div>
                </div>
            </div>
            <!-- Update Subject -->
            <div class="col-md-3 mb-4">
                <div class="card border-primary" onclick="window.location.href='<%= request.getContextPath() %>/update_subject.jsp';">
                    <div class="card-body">
                        <h5 class="card-title">Update Subject</h5>
                        <p class="card-text">Click here to update an existing subject.</p>
                    </div>
                </div>
            </div>
            <!-- Delete Subject -->
            <div class="col-md-3 mb-4">
                <div class="card border-primary" onclick="window.location.href='<%= request.getContextPath() %>/delete_subject.jsp';">
                    <div class="card-body">
                        <h5 class="card-title">Delete Subject</h5>
                        <p class="card-text">Click here to delete a subject.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Academic Task Management System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
