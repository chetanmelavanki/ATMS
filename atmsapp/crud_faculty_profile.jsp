<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRUD Operations - Faculty Profile</title>
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
                        <a class="nav-link" href="create_faculty_profile.jsp">Back</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h4 class="mb-4">Manage Faculty Profile</h4>
        <div class="row">
            <!-- Create Faculty Profile -->
            <div class="col-md-6 mb-4">
                <div class="card" onclick="window.location.href='create_faculty_profile.jsp';">
                    <div class="card-body">
                        <h5 class="card-title">Create Faculty Profile</h5>
                        <p class="card-text">Click here to create a new faculty profile.</p>
                    </div>
                </div>
            </div>
            <!-- View Faculty Profiles -->
            <div class="col-md-6 mb-4">
                <div class="card" onclick="window.location.href='view_faculties_profile.jsp';">
                    <div class="card-body">
                        <h5 class="card-title">View Faculty Profiles</h5>
                        <p class="card-text">Click here to view existing faculty profiles.</p>
                    </div>
                </div>
            </div>
            <!-- Update Faculty Profile -->
            <div class="col-md-6 mb-4">
                <div class="card" onclick="window.location.href='update_faculty_profile.jsp';">
                    <div class="card-body">
                        <h5 class="card-title">Update Faculty Profile</h5>
                        <p class="card-text">Click here to update details of a faculty profile.</p>
                    </div>
                </div>
            </div>
            <!-- Delete Faculty Profile -->
            <div class="col-md-6 mb-4">
                <div class="card" onclick="window.location.href='delete_faculty_profile.jsp';">
                    <div class="card-body">
                        <h5 class="card-title">Delete Faculty Profile</h5>
                        <p class="card-text">Click here to delete a faculty profile.</p>
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
