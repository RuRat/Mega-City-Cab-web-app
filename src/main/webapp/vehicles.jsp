<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Vehicles</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootswatch Theme -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/litera/bootstrap.min.css">

    <script>
        const url = "http://localhost:8080/api/vehicle";

        document.addEventListener("DOMContentLoaded", function () {
            const user = JSON.parse(sessionStorage.getItem("user"));
            if (!user || user.role !== "ADMIN") {
                showToast("danger", "Access denied. Only admins can manage vehicles.");
                setTimeout(() => window.location.href = "dashboard.jsp", 3000);
                return;
            }
            loadVehicles();
        });

        function loadVehicles() {
            fetch(url)
                .then(res => res.json())
                .then(data => {
                    console.log("Vehicle Data Received:", data);
                    let vehicleTable = document.getElementById("vehicleTable");
                    vehicleTable.innerHTML = "";

                    data.forEach(vehicle => {
                        let row = document.createElement("tr");

                        // Model Column
                        let modelCell = document.createElement("td");
                        modelCell.textContent = vehicle.model || "N/A";
                        row.appendChild(modelCell);

                        // Number Plate Column
                        let plateCell = document.createElement("td");
                        plateCell.textContent = vehicle.numberPlate || "N/A";
                        row.appendChild(plateCell);

                        // Status Column
                        let statusCell = document.createElement("td");
                        statusCell.textContent = vehicle.status;
                        row.appendChild(statusCell);

                        // Actions Column
                        let actionCell = document.createElement("td");

                        // Status Toggle Button
                        let toggleButton = document.createElement("button");
                        let buttonClass = vehicle.status === "AVAILABLE" ? "btn-warning" : "btn-success";
                        toggleButton.className = `btn ${buttonClass} btn-sm`;
                        toggleButton.textContent = vehicle.status === "AVAILABLE" ? "Mark as Booked" : "Mark as Available";
                        toggleButton.onclick = function () {
                            toggleVehicleStatus(vehicle.id, vehicle.status);
                        };
                        actionCell.appendChild(toggleButton);

                        // Delete Button
                        let deleteButton = document.createElement("button");
                        deleteButton.className = "btn btn-danger btn-sm ms-2";
                        deleteButton.textContent = "Delete";
                        deleteButton.onclick = function () {
                            deleteVehicle(vehicle.id);
                        };
                        actionCell.appendChild(deleteButton);

                        row.appendChild(actionCell);
                        vehicleTable.appendChild(row);
                    });
                })
                .catch(error => console.error("Error loading vehicles:", error));
        }

        function addVehicle() {
            const vehicle = {
                "model": document.getElementById("txtModel").value,
                "numberPlate": document.getElementById("txtNumberPlate").value,
                "status": "AVAILABLE"
            };

            fetch(url, {
                method: "POST",
                headers: { "content-type": "application/json" },
                body: JSON.stringify(vehicle)
            }).then(() => {
                showToast("success", "Vehicle added successfully!");
                loadVehicles();
                document.getElementById("txtModel").value = "";
                document.getElementById("txtNumberPlate").value = "";
            }).catch(() => showToast("danger", "Failed to add vehicle!"));
        }

        function toggleVehicleStatus(vehicleId, currentStatus) {
            const newStatus = currentStatus === "AVAILABLE" ? "BOOKED" : "AVAILABLE";
            fetch(url + "/updateStatus", {
                method: "PUT",
                headers: { "content-type": "application/json" },
                body: JSON.stringify({ id: vehicleId, status: newStatus })
            }).then(() => {
                showToast("success", "Vehicle status updated successfully!");
                loadVehicles();
            }).catch(() => showToast("danger", "Failed to update vehicle status!"));
        }

        function deleteVehicle(vehicleId) {
            fetch(url + "/" + vehicleId, { method: "DELETE" })
                .then(() => {
                    showToast("success", "Vehicle deleted successfully!");
                    loadVehicles();
                }).catch(() => showToast("danger", "Failed to delete vehicle!"));
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
                    <a class="nav-link active" href="#">Manage Vehicles</a>
                </li>
            </ul>
            <button class="btn btn-danger ms-3" onclick="logout()">Logout</button>
        </div>
    </div>
</nav>

<!-- Manage Vehicles Section -->
<div class="container mt-4">
    <h2 class="text-center">Manage Vehicles</h2>

    <!-- Add Vehicle Form -->
    <div class="card p-4 mb-4">
        <h4>Add New Vehicle</h4>
        <div class="row g-3">
            <div class="col-md-5">
                <input type="text" id="txtModel" class="form-control" placeholder="Vehicle Model">
            </div>
            <div class="col-md-5">
                <input type="text" id="txtNumberPlate" class="form-control" placeholder="Number Plate">
            </div>
            <div class="col-md-2">
                <button onclick="addVehicle()" class="btn btn-success w-100">Add Vehicle</button>
            </div>
        </div>
    </div>

    <!-- Vehicles Table -->
    <div class="table-responsive">
        <table class="table table-bordered mt-3">
            <thead class="table-dark">
            <tr>
                <th>Model</th>
                <th>Number Plate</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="vehicleTable"></tbody>
        </table>
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
