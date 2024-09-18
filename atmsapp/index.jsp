<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Task Management System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html {
            scroll-behavior: smooth; /* Smooth scrolling */
        }
        .hero-section {
            background: url('hero-background.jpg') no-repeat center center;
            background-size: cover;
        }
        .card-body img {
            max-width: 100%;
            height: auto;
        }
        .section-header {
            margin-bottom: 2rem;
        }
        @media (max-width: 768px) {
            .about-text h4 {
                margin-top: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">ATMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#departments">Departments</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-primary text-black" href="login.jsp">Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <header class="hero-section bg-primary text-white text-center py-5">
        <div class="container">
            <h1 class="display-4">Academic Task Management System</h1>
            <p class="lead">Organize your academic tasks efficiently and achieve your goals.</p>
            <a href="login.jsp" class="btn btn-light btn-lg mt-3">Get Started</a>
        </div>
    </header>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h5 class="card-title">Event Management</h5>
                            <p class="card-text">Track events organized by faculty or students and identify participants throughout the academic year.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h5 class="card-title">Academic Performance</h5>
                            <p class="card-text">Monitor student pass/fail rates in CIE and SEE, along with the total marks scored in SEE.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h5 class="card-title">Subject Registration</h5>
                            <p class="card-text">View which faculty taught which subjects and which students registered for specific subjects.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="bg-light py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-4 mb-lg-0 about-text">
                    <h2>About Our System</h2>
                    <p>The Academic Task Management System (ATMS) is a comprehensive solution designed to streamline and enhance the management of academic activities within educational institutions. The system is built with the aim of fostering a more organized, efficient, and data-driven academic environment. Below are the core functionalities and benefits that ATMS provides:</p>

                    <h4>Event Management</h4>
                    <p>ATMS provides a robust platform for managing academic events, whether they are organized by faculty or students. The system allows you to track all events conducted during the academic year, including details about participants, organizers, and outcomes. This feature ensures that no event goes unrecorded and helps in analyzing the impact of these events on the academic community.</p>

                    <h4>Academic Performance Tracking</h4>
                    <p>One of the key functionalities of ATMS is its ability to monitor and analyze student performance. The system tracks the number of students who pass or fail in Continuous Internal Evaluation (CIE) and Semester End Examinations (SEE). Additionally, it records the total marks scored in SEE, providing a comprehensive view of academic performance across different subjects and courses. This data is crucial for identifying areas where students may need additional support and for evaluating the effectiveness of teaching methods.</p>

                    <h4>Subject and Faculty Management</h4>
                    <p>ATMS offers detailed insights into the academic ecosystem by tracking which faculty members are teaching which subjects, and which students are registered for these subjects. This feature ensures that both faculty and student activities are well-coordinated and that resources are allocated efficiently. It also helps in understanding the distribution of academic responsibilities among faculty and the interests and performance of students in various subjects.</p>

                    <h4>Data-Driven Decision Making</h4>
                    <p>With ATMS, institutions can harness the power of data to make informed decisions. The system's analytics and reporting tools provide valuable insights into various aspects of academic management, from event participation to student performance. This data-driven approach helps in identifying trends, forecasting future performance, and optimizing the academic processes to better meet the needs of both faculty and students.</p>

                    <h4>Enhanced Collaboration and Communication</h4>
                    <p>By centralizing the management of academic tasks, ATMS fosters better collaboration between faculty, students, and administrative staff. The system ensures that everyone involved is on the same page, with real-time access to information about events, assessments, and subject registrations. This transparency and accessibility help in reducing misunderstandings, improving communication, and enhancing the overall academic experience.</p>
                </div>
                <div class="col-lg-6">
                    <img src="index.png" alt="About Us" class="img-fluid rounded">
                </div>
            </div>
        </div>
    </section>

    <!-- Departments Section -->
    <section id="departments" class="py-5">
        <div class="container">
            <h2 class="text-center mb-4">Our Departments</h2>
            <div class="row">
                <!-- MCA Department -->
                <div class="col-md-4 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h5 class="card-title">Master of Computer Applications (MCA)</h5>
                            <p class="card-text">Focused on advanced computer applications, software development, and IT management.</p>
                        </div>
                    </div>
                </div>
                <!-- MBA Department -->
                <div class="col-md-4 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h5 class="card-title">Master of Business Administration (MBA)</h5>
                            <p class="card-text">Offering courses in management, leadership, and strategic planning for future business leaders.</p>
                        </div>
                    </div>
                </div>
                <!-- MTech Department -->
                <div class="col-md-4 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h5 class="card-title">Master of Technology (MTech)</h5>
                            <p class="card-text">Specializing in advanced technical skills and research in various engineering fields.</p>
                        </div>
                    </div>
                </div>
                <!-- Additional Departments -->
                
                <div class="col-md-4 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h5 class="card-title">Electrical Engineering</h5>
                            <p class="card-text">Focused on electrical systems, power generation, and emerging energy technologies.</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h5 class="card-title">Civil Engineering</h5>
                            <p class="card-text">Offering studies in construction, urban development, and environmental engineering.</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body text-center">
                            <h5 class="card-title">Mechanical Engineering</h5>
                            <p class="card-text">Focused on the design, production, and operation of mechanical systems.</p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-4 mt-auto">
        <div class="container">
            <p>&copy; 2023 Academic Task Management System. All Rights Reserved.</p>
            <ul class="list-unstyled">
                <li><a href="#" class="text-white">Privacy Policy</a></li>
                <li><a href="#" class="text-white">Terms of Service</a></li>
            </ul>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
