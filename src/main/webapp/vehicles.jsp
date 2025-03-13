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
        const driverUrl = "http://localhost:8080/api/user/role/drivers";

        document.addEventListener("DOMContentLoaded", function () {
            const user = JSON.parse(sessionStorage.getItem("user"));
            if (!user || user.role !== "ADMIN") {
                alert("Access denied. Only admins can manage vehicles.");
                window.location.href = "dashboard.jsp";
                return;
            }
            loadVehicles();
            loadDrivers();
        });

        function loadVehicles() {
            fetch(url)
                .then(res => res.json())
                .then(data => {
                    let vehicleTable = document.getElementById("vehicleTable");
                    vehicleTable.innerHTML = ""; // Clear existing content

                    data.forEach(vehicle => {
                        let row = document.createElement("tr");

                        // ✅ Model Column
                        let modelCell = document.createElement("td");
                        modelCell.textContent = vehicle.model || "N/A";
                        row.appendChild(modelCell);

                        // ✅ Number Plate Column
                        let plateCell = document.createElement("td");
                        plateCell.textContent = vehicle.numberPlate || "N/A";
                        row.appendChild(plateCell);

                        // ✅ Status Column with Dropdown
                        let statusCell = document.createElement("td");
                        let statusSelect = document.createElement("select");
                        statusSelect.className = "form-select form-select-sm";
                        statusSelect.setAttribute("data-assigned-driver", vehicle.assignedDriverId || "");

                        const statuses = [
                            { value: "NOT_AVAILABLE", label: "NOT_AVAILABLE" },
                            { value: "AVAILABLE", label: "AVAILABLE", disabled: !vehicle.assignedDriverId }, // Disable if no driver assigned
                            { value: "MAINTENANCE", label: "MAINTENANCE" }
                        ];

                        statuses.forEach(status => {
                            let option = document.createElement("option");
                            option.value = status.value;
                            option.textContent = status.label;

                            if (vehicle.status === status.value) {
                                option.selected = true;
                            }

                            if (status.disabled) {
                                option.disabled = true;
                            }

                            statusSelect.appendChild(option);
                        });

                        statusSelect.onchange = function () {
                            updateVehicleStatus(vehicle.id, statusSelect.value);
                        };

                        statusCell.appendChild(statusSelect);
                        row.appendChild(statusCell);

                        // ✅ Assign Driver Column with Dropdown
                        let driverCell = document.createElement("td");
                        let driverSelect = document.createElement("select");
                        driverSelect.className = "form-select form-select-sm driver-select";
                        driverSelect.id = "driver-select-" + vehicle.id;
                        driverSelect.setAttribute("data-assigned-driver", vehicle.assignedDriverId || "");
                        driverSelect.innerHTML = `<option value="">Assign Driver</option>`;

                        driverSelect.onchange = function () {
                            assignDriver(vehicle.id, driverSelect.value);
                        };

                        driverCell.appendChild(driverSelect);
                        row.appendChild(driverCell);

                        // ✅ Actions Column (Delete Button)
                        let actionCell = document.createElement("td");
                        let deleteButton = document.createElement("button");
                        deleteButton.className = "btn btn-danger btn-sm";
                        deleteButton.textContent = "Delete";
                        deleteButton.onclick = function () {
                            deleteVehicle(vehicle.id);
                        };
                        actionCell.appendChild(deleteButton);
                        row.appendChild(actionCell);

                        vehicleTable.appendChild(row);
                    });

                    // ✅ Load Drivers AFTER Vehicles are Loaded
                    loadDrivers();
                })
                .catch(error => console.error("Error loading vehicles:", error));
        }


        function loadDrivers() {
            fetch(driverUrl)
                .then(res => res.json())
                .then(data => {
                    console.log("Drivers Data Received:", data); // Debugging

                    if (!data.length) {
                        console.warn("No drivers found!");
                        return;
                    }

                    document.querySelectorAll(".driver-select").forEach(select => {
                        let assignedDriverId = select.getAttribute("data-assigned-driver") || ""; // Fetch assigned driver ID
                        select.innerHTML = `<option value="">Assign Driver</option>`; // Reset options
                        console.log(assignedDriverId)
                        data.forEach(driver => {
                            console.log("Driver:", driver); // Debugging
                            if (driver.name) {  // Ensure driver has a valid name
                                let option = document.createElement("option");
                                option.value = driver.id;
                                option.textContent = driver.name;

                                if (driver.id == assignedDriverId) {
                                    option.selected = true;
                                }

                                select.appendChild(option);
                            }
                        });
                    });
                })
                .catch(error => console.error("Error loading drivers:", error));
        }

        function addVehicle() {
            const vehicle = {
                "model": document.getElementById("txtModel").value,
                "numberPlate": document.getElementById("txtNumberPlate").value,
                "status": "NOT_AVAILABLE"
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

        function assignDriver(vehicleId, driverId) {
            if (!driverId) return;
            fetch(url + "/assignDriver", {
                method: "PUT",
                headers: { "content-type": "application/json" },
                body: JSON.stringify({ id: vehicleId, assignedDriverId: driverId })
            }).then(() => {
                showToast("success", "Driver assigned successfully!");
                loadVehicles();
            }).catch(() => showToast("danger", "Failed to assign driver!"));
        }

        function updateVehicleStatus(vehicleId, status) {
            fetch(url + "/updateStatus", {
                method: "PUT",
                headers: { "content-type": "application/json" },
                body: JSON.stringify({ id: vehicleId, status: status })
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
                <th>Assign Driver</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="vehicleTable"></tbody>
        </table>
    </div>
</div>

<!-- Bootstrap Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
