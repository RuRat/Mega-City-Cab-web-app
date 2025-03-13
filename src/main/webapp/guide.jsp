<!DOCTYPE html>
<html lang="en">
<head>
    <title>Mega City Cab - User Guide</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & Bootswatch Theme -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/litera/bootstrap.min.css">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .accordion-button {
            font-size: 18px;
        }
        .guide-section {
            max-width: 800px;
            margin: auto;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="#">Mega City Cab</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#">User Guide</a>
                </li>
            </ul>
            <button class="btn btn-danger ms-3" onclick="window.history.back()">Back</button>
        </div>
    </div>
</nav>

<!-- User Guide Section -->
<div class="container mt-4 guide-section">
    <h2 class="text-center">Mega City Cab - User Guide</h2>
    <p class="text-center text-muted">A step-by-step guide to help you navigate and use Mega City Cab efficiently.</p>

    <div class="accordion mt-4" id="userGuideAccordion">

        <!-- Step 1: Register & Login -->
        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#stepOne">
                    <i class="bi bi-person-plus-fill me-2"></i> Step 1: Registering & Logging In
                </button>
            </h2>
            <div id="stepOne" class="accordion-collapse collapse show">
                <div class="accordion-body">
                    <p>Visit the <strong>registration page</strong> and fill in your details.</p>
                    <p>After registering, use your credentials to <strong>log in</strong> to access the dashboard.</p>
                    <p>If you forget your password, use the <strong>password recovery</strong> option.</p>
                </div>
            </div>
        </div>

        <!-- Step 2: Booking a Ride -->
        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#stepTwo">
                    <i class="bi bi-car-front-fill me-2"></i> Step 2: Booking a Ride (For Customers)
                </button>
            </h2>
            <div id="stepTwo" class="accordion-collapse collapse">
                <div class="accordion-body">
                    <p>Select an <strong>available vehicle</strong> from the booking page.</p>
                    <p>Enter the <strong>pickup and destination</strong> locations.</p>
                    <p>Choose a <strong>ride time</strong> and confirm the booking.</p>
                </div>
            </div>
        </div>

        <!-- Step 3: Managing Vehicles -->
        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#stepThree">
                    <i class="bi bi-tools me-2"></i> Step 3: Managing Vehicles (For Admins)
                </button>
            </h2>
            <div id="stepThree" class="accordion-collapse collapse">
                <div class="accordion-body">
                    <p>Admins can <strong>add, edit, or remove</strong> vehicles from the system.</p>
                    <p>Assign <strong>drivers</strong> to vehicles from the dashboard.</p>
                    <p>Keep track of vehicle <strong>status and availability</strong>.</p>
                </div>
            </div>
        </div>

        <!-- Step 4: Generating & Printing Invoices -->
        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#stepFour">
                    <i class="bi bi-receipt me-2"></i> Step 4: Generating & Printing Invoices
                </button>
            </h2>
            <div id="stepFour" class="accordion-collapse collapse">
                <div class="accordion-body">
                    <p>After completing a ride, an <strong>invoice</strong> is automatically generated.</p>
                    <p>View invoices from the <strong>Reservations</strong> page.</p>
                    <p>Click the <strong>Print Invoice</strong> button to download or print a copy.</p>
                </div>
            </div>
        </div>

        <!-- FAQ -->
        <div class="accordion-item">
            <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#stepFive">
                    <i class="bi bi-question-circle me-2"></i> Frequently Asked Questions (FAQ)
                </button>
            </h2>
            <div id="stepFive" class="accordion-collapse collapse">
                <div class="accordion-body">
                    <p><strong>How do I change my password?</strong><br>Go to <em>Settings</em> and click <em>Change Password</em>.</p>
                    <p><strong>Can I cancel a ride?</strong><br>Yes, customers can cancel a ride before the driver arrives.</p>
                    <p><strong>What payment methods are accepted?</strong><br>Currently, we support <strong>cash</strong> and <strong>credit card</strong> payments.</p>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Bootstrap Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
