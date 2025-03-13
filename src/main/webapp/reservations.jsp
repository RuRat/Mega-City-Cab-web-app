<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Reservations</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootswatch Theme -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/litera/bootstrap.min.css">

    <script>
        const url = "http://localhost:8080/api/reservation";

        document.addEventListener("DOMContentLoaded", function() {
            const user = JSON.parse(sessionStorage.getItem("user"));
            if (!user) {
                showToast("danger", "You must be logged in to access this page.");
                setTimeout(() => window.location.href = "login.jsp", 3000);
                return;
            }
            loadReservations();
        });

        function loadReservations() {
            fetch(url)
                .then(res => res.json())
                .then(data => {
                    let reservationTable = document.getElementById("reservationTable");
                    reservationTable.innerHTML = ""; // Clear existing content

                    data.forEach(reservation => {
                        let row = document.createElement("tr");

                        // Customer ID Column
                        let customerCell = document.createElement("td");
                        customerCell.textContent = reservation.customerId;
                        row.appendChild(customerCell);

                        // Vehicle ID Column
                        let vehicleCell = document.createElement("td");
                        vehicleCell.textContent = reservation.vehicleId;
                        row.appendChild(vehicleCell);

                        // Pickup Location Column
                        let pickupCell = document.createElement("td");
                        pickupCell.textContent = reservation.pickupLocation;
                        row.appendChild(pickupCell);

                        // Destination Column
                        let destinationCell = document.createElement("td");
                        destinationCell.textContent = reservation.destinationLocation;
                        row.appendChild(destinationCell);

                        // Start Time Column
                        let startTimeCell = document.createElement("td");
                        startTimeCell.textContent = new Date(reservation.startTime).toLocaleString();
                        row.appendChild(startTimeCell);

                        // End Time Column
                        let endTimeCell = document.createElement("td");
                        endTimeCell.textContent = reservation.endTime ? new Date(reservation.endTime).toLocaleString() : "N/A";
                        row.appendChild(endTimeCell);

                        // Status Dropdown Column
                        let statusCell = document.createElement("td");
                        let statusSelect = document.createElement("select");
                        statusSelect.className = "form-select form-select-sm";

                        let statuses = ["PENDING", "CONFIRMED", "CANCELLED"];
                        statuses.forEach(status => {
                            let option = document.createElement("option");
                            option.value = status;
                            option.textContent = status;
                            if (reservation.status === status) {
                                option.selected = true;
                            }
                            statusSelect.appendChild(option);
                        });

                        statusSelect.onchange = function () {
                            updateReservationStatus(reservation.id, statusSelect.value);
                        };

                        statusCell.appendChild(statusSelect);
                        row.appendChild(statusCell);

                        // Invoice Button Column
                        let actionCell = document.createElement("td");
                        let invoiceButton = document.createElement("button");
                        invoiceButton.className = "btn btn-info btn-sm";
                        invoiceButton.textContent = "Invoice";
                        invoiceButton.onclick = function () {
                            viewInvoice(
                                reservation.id, reservation.customerId, reservation.vehicleId,
                                reservation.startTime, reservation.endTime,
                                reservation.pickupLocation, reservation.destinationLocation, reservation.status
                            );
                        };

                        actionCell.appendChild(invoiceButton);
                        row.appendChild(actionCell);

                        // Append row to table
                        reservationTable.appendChild(row);
                    });
                })
                .catch(error => console.error("Error loading reservations:", error));
        }


        function updateReservationStatus(reservationId, newStatus) {
            fetch(url + "/updateStatus", {
                method: "PUT",
                headers: { "content-type": "application/json" },
                body: JSON.stringify({ id: reservationId, status: newStatus })
            }).then(() => {
                showToast("success", "Reservation status updated successfully!");
                loadReservations();
            }).catch(() => showToast("danger", "Failed to update reservation status!"));
        }

        function viewInvoice(id, customerId, vehicleId, startTime, endTime, pickup, destination, status) {
            console.log("Viewing invoice for reservation ID:", id);

            // Create an invoice object
            const invoiceData = {
                id,
                customerId,
                vehicleId,
                startTime,
                endTime,
                pickup,
                destination,
                status
            };

            // Store the invoice data in sessionStorage
            sessionStorage.setItem("invoiceData", JSON.stringify(invoiceData));

            // Redirect to the invoice page
            window.location.href = "invoice.jsp";
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
                    <a class="nav-link active" href="#">Manage Reservations</a>
                </li>
            </ul>
            <button class="btn btn-danger ms-3" onclick="logout()">Logout</button>
        </div>
    </div>
</nav>

<!-- Manage Reservations Section -->
<div class="container mt-4">
    <h2 class="text-center">Manage Reservations</h2>

    <div class="table-responsive">
        <table class="table table-bordered mt-3">
            <thead class="table-dark">
            <tr>
                <th>Customer ID</th>
                <th>Vehicle ID</th>
                <th>Pickup Location</th>
                <th>Destination</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="reservationTable"></tbody>
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
