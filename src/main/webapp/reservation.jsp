<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book a Ride</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootswatch Theme -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/litera/bootstrap.min.css">

    <script>
        const vehicleUrl = "http://localhost:8080/api/vehicle";
        const reservationUrl = "http://localhost:8080/api/reservation";

        document.addEventListener("DOMContentLoaded", function () {
            const user = JSON.parse(sessionStorage.getItem("user"));
            if (!user || user.role !== "CUSTOMER") {
                showToast("danger", "Access denied. Only customers can book rides.");
                setTimeout(() => window.location.href = "dashboard.jsp", 3000);
                return;
            }
            loadVehicles();
        });

        function loadVehicles() {
            fetch(vehicleUrl)
                .then(res => res.json())
                .then(data => {
                    let vehicleDropdown = document.getElementById("vehicleSelect");
                    vehicleDropdown.innerHTML = "<option value=''>Select a vehicle</option>";

                    data.forEach(vehicle => {
                        if (vehicle.status === "AVAILABLE") {
                            let model = vehicle["model"] ? vehicle["model"] : "Unknown Model";
                            let numberPlate = vehicle["numberPlate"] ? vehicle["numberPlate"] : "Unknown Plate";

                            let option = document.createElement("option");
                            option.value = vehicle.id;
                            option.textContent = model + " - " + numberPlate;
                            vehicleDropdown.appendChild(option);
                        }
                    });
                })
                .catch(error => console.error("Error loading vehicles:", error));
        }

        function bookRide() {
            const user = JSON.parse(sessionStorage.getItem("user"));
            const pickupTime = document.getElementById("pickupTime").value;
            const formattedTime = new Date(pickupTime).toISOString();

            const reservation = {
                "customerId": user.id,
                "vehicleId": document.getElementById("vehicleSelect").value,
                "pickupLocation": document.getElementById("pickupLocation").value,
                "destinationLocation": document.getElementById("destinationLocation").value,
                "startTime": formattedTime,
                "status": "PENDING"
            };


            if (!reservation.vehicleId || !reservation.pickupLocation || !reservation.destinationLocation || !reservation.startTime) {
                showToast("danger", "All fields are required!");
                return;
            }

            fetch(reservationUrl, {
                method: "POST",
                headers: { "content-type": "application/json" },
                body: JSON.stringify(reservation)
            }).then(() => {
                showToast("success", "Ride booked successfully!");
                document.getElementById("reservationForm").reset();
            }).catch(() => showToast("danger", "Failed to book ride!"));
        }

        function showToast(type, message) {
            const toastElement = document.getElementById("liveToast");
            const toastBody = document.getElementById("toastMessage");
            toastBody.innerText = message;
            toastElement.className = `toast align-items-center text-bg-${type} border-0 show`;
            const toast = new bootstrap.Toast(toastElement);
            toast.show();
        }

        function logout() {
            sessionStorage.removeItem("user");
            window.location.href = "login.jsp";
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
                    <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#">Book a Ride</a>
                </li>
            </ul>
            <button class="btn btn-danger ms-3" onclick="logout()">Logout</button>
        </div>
    </div>
</nav>

<!-- Book a Ride Section -->
<div class="container mt-4">
    <h2 class="text-center">Book a Ride</h2>

    <!-- Reservation Form -->
    <div class="card p-4 mb-4">
        <h4>Ride Details</h4>
        <form id="reservationForm">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="vehicleSelect" class="form-label">Select Vehicle</label>
                    <select id="vehicleSelect" class="form-select">
                        <option>Loading vehicles...</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="pickupLocation" class="form-label">Pickup Location</label>
                    <input type="text" id="pickupLocation" class="form-control" placeholder="Enter pickup location">
                </div>
                <div class="col-md-6">
                    <label for="destinationLocation" class="form-label">Destination</label>
                    <input type="text" id="destinationLocation" class="form-control" placeholder="Enter destination">
                </div>
                <div class="col-md-6">
                    <label for="pickupTime" class="form-label">Pickup Time</label>
                    <input type="datetime-local" id="pickupTime" class="form-control">
                </div>
                <div class="col-md-12">
                    <button type="button" onclick="bookRide()" class="btn btn-success w-100 mt-3">Book Ride</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap Toast Notification -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="liveToast" class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body" id="toastMessage">Success message</div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>

<!-- Bootstrap Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
