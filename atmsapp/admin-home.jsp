<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Academic Task Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"> <!-- Google Font -->
    <style>
        html, body {
            height: 100%;
            margin: 0;
            font-family: 'Roboto', sans-serif;
        }
        body {
            background-color: #f8f9fa; /* Light gray background */
        }
        .navbar {
            background-color: #343a40; /* Dark gray navbar */
        }
        .navbar-brand {
            color: #ffffff;
            font-weight: 700;
        }
        .navbar-nav .nav-link {
            color: #ffffff;
        }
        .navbar-nav .nav-link:hover {
            color: #dcdcdc; /* Light gray on hover */
        }
        .card {
            transition: transform 0.3s ease, box-shadow 0.3s ease, background-color 0.3s ease;
            border-radius: 0.75rem; /* Slightly more rounded corners */
            background-color: #ffffff; /* White background for card */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }
        .card:hover {
            transform: translateY(-10px) scale(1.05); /* Move up and scale */
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* Enhanced shadow on hover */
            background-color: #e9ecef; /* Light gray background on hover */
        }
        .card-body {
            background-color: #f1f3f5; /* Light gray for card body */
            transition: background-color 0.3s ease; /* Smooth background color transition */
        }
        .btn-primary {
            background-color: #007bff; /* Blue */
            border: none;
            font-weight: 500;
        }
        .btn-primary:hover {
            background-color: #0056b3; /* Darker blue */
        }
        .btn-secondary {
            background-color: #6c757d; /* Gray */
            border: none;
            font-weight: 500;
        }
        .btn-secondary:hover {
            background-color: #5a6268; /* Darker gray */
        }
        footer {
            background-color: #212529; /* Very dark gray */
            color: #ffffff;
            text-align: center;
            padding: 1rem;
            margin-top: auto; /* Pushes the footer to the bottom */
        }
        h1, h2, h3, h4, h5 {
            font-weight: 700; /* Bold headings */
        }
        .container {
            max-width: 1200px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">ATMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Main Content -->
    <div class="container mt-5 mb-5">
        <div class="text-center mb-4">
            <h1 class="mb-3">Admin Dashboard</h1>
            <p class="mb-4">Welcome to the Admin dashboard. Manage key academic details efficiently.</p>
        </div>
        
        <!-- Section: Quick Actions -->
        <div class="row justify-content-center">
            <!-- Branch Creation/Add Branch Details -->
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-primary">
                    <div class="card-body">
                        <h5 class="card-title">Branch Management</h5>
                        <p class="card-text">Add new branches or update existing branch details.</p>
                        <a href="crud_branch.jsp" class="btn btn-primary">Manage Branch</a>
                    </div>
                </div>
            </div>
            <!-- Create Faculty Profile -->
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-primary">
                    <div class="card-body">
                        <h5 class="card-title">Create Faculty Profile</h5>
                        <p class="card-text">Add new faculty profiles to the system.</p>
                        <a href="crud_faculty_profile.jsp" class="btn btn-primary">Create Faculty</a>
                    </div>
                </div>
            </div>
            <!-- Create Student Profile -->
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-primary">
                    <div class="card-body">
                        <h5 class="card-title">Create Student Profile</h5>
                        <p class="card-text">Add new student profiles to the system.</p>
                        <a href="create_student_profile.jsp" class="btn btn-primary">Create Student</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Additional Section: More Actions -->
        <div class="row justify-content-center">
            <!-- Event Creation -->
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-primary">
                    <div class="card-body">
                        <h5 class="card-title">Event Creation</h5>
                        <p class="card-text">Create and manage events within the academic system.</p>
                        <a href="crud_event.jsp" class="btn btn-primary">Create Event</a>
                    </div>
                </div>
            </div>
            <!-- Manage Subjects -->
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-primary">
                    <div class="card-body">
                        <h5 class="card-title">Manage Subjects</h5>
                        <p class="card-text">Add or update subjects offered in the academic system.</p>
                        <a href="crud_subject.jsp" class="btn btn-primary">Manage Subjects</a>
                    </div>
                </div>
            </div>
            <!-- Create User -->
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="card border-primary">
                    <div class="card-body">
                        <h5 class="card-title">Create User</h5>
                        <p class="card-text">Add new users to the system, including faculty and students.</p>
                        <a href="create_user.jsp" class="btn btn-primary">Create User</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer>
        <div class="container">
            <p class="mb-0">&copy; 2024 Academic Task Management System. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
