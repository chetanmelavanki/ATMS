<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Branch Management - Academic Task Management System</title>
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
        .card {
            cursor: pointer;
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
        <h4 class="mb-4">Branch Management</h4>
        <div class="row">
            <!-- Create Branch -->
            <div class="col-md-3 mb-4">
                <div class="card" onclick="window.location.href='<%= request.getContextPath() %>/create_branch.jsp';">
                    <div class="card-body">
                        <h5 class="card-title">Create Branch</h5>
                        <p class="card-text">Click here to create a new branch.</p>
                    </div>
                </div>
            </div>
            <!-- View Branches -->
            <div class="col-md-3 mb-4">
                <div class="card" onclick="window.location.href='<%= request.getContextPath() %>/view_branches.jsp';">
                    <div class="card-body">
                        <h5 class="card-title">View Branches</h5>
                        <p class="card-text">Click here to view all branches.</p>
                    </div>
                </div>
            </div>
            <!-- Update Branch -->
            <div class="col-md-3 mb-4">
                <div class="card" onclick="window.location.href='<%= request.getContextPath() %>/update_branch.jsp';">
                    <div class="card-body">
                        <h5 class="card-title">Update Branch</h5>
                        <p class="card-text">Click here to update an existing branch.</p>
                    </div>
                </div>
            </div>
            <!-- Delete Branch -->
            <div class="col-md-3 mb-4">
                <div class="card" onclick="window.location.href='<%= request.getContextPath() %>/delete_branch.jsp';">
                    <div class="card-body">
                        <h5 class="card-title">Delete Branch</h5>
                        <p class="card-text">Click here to delete a branch.</p>
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