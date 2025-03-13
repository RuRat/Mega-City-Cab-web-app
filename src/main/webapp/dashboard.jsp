<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootswatch Theme -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/litera/bootstrap.min.css">

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const user = JSON.parse(sessionStorage.getItem("user"));
            if (!user || user.status !== "ACTIVE") {
                showAlert("danger", "You must be logged in with an active account.");
                sessionStorage.removeItem("user");
                setTimeout(() => window.location.href = "login.jsp", 3000);
                return;
            }

            document.getElementById("welcomeMessage").innerText = "Welcome, " + user.name + "!";
            const role = user.role;

            if (role === "ADMIN") {
                document.getElementById("adminNav").style.display = "block";
            }
            if (role === "OPERATOR" || role === "ADMIN") {
                document.getElementById("operatorNav").style.display = "block";
            }
        });

        function logout() {
            sessionStorage.removeItem("user");
            window.location.href = "login.jsp";
        }

        function showAlert(type, message) {
            const alertBox = document.getElementById("alertBox");
            alertBox.innerHTML = `<div class="alert alert-${type} alert-dismissible fade show mt-2" role="alert">
                                    ${message}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                  </div>`;
        }
    </script>
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
                    <a class="nav-link active" href="#">Dashboard</a>
                </li>

                <!-- Admin Dropdown -->
                <li class="nav-item dropdown" id="adminNav" style="display:none;">
                    <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown">
                        Admin Panel
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="vehicles.jsp">Manage Vehicles</a></li>
                        <li><a class="dropdown-item" href="users.jsp">Manage Users</a></li>
                        <li><a class="dropdown-item" href="invoices.jsp">View Invoices</a></li>
                    </ul>
                </li>

                <!-- Operator Dropdown -->
                <li class="nav-item dropdown" id="operatorNav" style="display:none;">
                    <a class="nav-link dropdown-toggle" href="#" id="operatorDropdown" role="button" data-bs-toggle="dropdown">
                        Operator Panel
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="reservations.jsp">Manage Reservations</a></li>
                    </ul>
                </li>

                <!-- Operator Dropdown -->
                <li class="nav-item dropdown" id="supportNav">
                    <a class="nav-link dropdown-toggle" href="#" id="supportDropdown" role="button" data-bs-toggle="dropdown">
                        User Support
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="guide.jsp">Guide</a></li>
                    </ul>
                </li>
            </ul>

            <span id="alertBox"></span> <!-- Alerts appear here -->
            <button class="btn btn-danger ms-3" onclick="logout()">Logout</button>
        </div>
    </div>
</nav>

<!-- Dashboard Content -->
<div class="container mt-4">
    <h2 id="welcomeMessage" class="text-center mb-4"></h2>

    <div class="row">
        <div class="col-md-4">
            <div class="card border-primary text-center">
                <div class="card-body">
                    <h5 class="card-title">Make a Reservation</h5>
                    <p class="card-text">Easily book your ride with us.</p>
                    <a href="reservation.jsp" class="btn btn-primary">Book Now</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
