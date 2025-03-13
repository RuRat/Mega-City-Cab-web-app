<!DOCTYPE html>
<html lang="en">
<head>
    <title>Invoice</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootswatch Theme -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/litera/bootstrap.min.css">

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const invoiceData = JSON.parse(sessionStorage.getItem("invoiceData"));

            if (!invoiceData) {
                alert("No invoice data found!");
                window.location.href = "reservations.jsp"; // Redirect back if no data
                return;
            }

            // Populate the invoice details on the page
            document.getElementById("invoiceId").innerText = invoiceData.id;
            document.getElementById("customerId").innerText = invoiceData.customerId;
            document.getElementById("vehicleId").innerText = invoiceData.vehicleId;
            document.getElementById("startTime").innerText = new Date(invoiceData.startTime).toLocaleString();
            document.getElementById("endTime").innerText = invoiceData.endTime ? new Date(invoiceData.endTime).toLocaleString() : "N/A";
            document.getElementById("pickup").innerText = invoiceData.pickup;
            document.getElementById("destination").innerText = invoiceData.destination;
            document.getElementById("status").innerText = invoiceData.status;

            // Randomly generate price, distance, and duration
            const randomDistance = (Math.random() * (20 - 5) + 5).toFixed(2); // 5 to 20 km
            const randomPrice = (randomDistance * 1.5).toFixed(2); // Assume 1.5 per km
            const randomDuration = Math.floor(randomDistance * 2) + " mins"; // Estimate duration

            document.getElementById("distance").innerText = randomDistance + " km";
            document.getElementById("price").innerText = "$" + randomPrice;
            document.getElementById("duration").innerText = randomDuration;
        });

        function printInvoice() {
            window.print();
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
                    <a class="nav-link" href="reservations.jsp">Reservations</a>
                </li>
            </ul>
            <button class="btn btn-danger ms-3" onclick="window.history.back()">Back</button>
        </div>
    </div>
</nav>

<!-- Invoice Section -->
<div class="container mt-4">
    <div class="card p-4">
        <h2 class="text-center">Invoice</h2>
        <hr>

        <div class="row">
            <div class="col-md-6">
                <p><strong>Invoice ID:</strong> <span id="invoiceId"></span></p>
                <p><strong>Customer ID:</strong> <span id="customerId"></span></p>
                <p><strong>Vehicle ID:</strong> <span id="vehicleId"></span></p>
            </div>
            <div class="col-md-6 text-end">
                <p><strong>Date:</strong> <span id="invoiceDate"></span></p>
                <p><strong>Status:</strong> <span id="status"></span></p>
            </div>
        </div>

        <hr>

        <h4>Trip Details</h4>
        <div class="row">
            <div class="col-md-6">
                <p><strong>Pickup Location:</strong> <span id="pickup"></span></p>
                <p><strong>Destination:</strong> <span id="destination"></span></p>
            </div>
            <div class="col-md-6">
                <p><strong>Start Time:</strong> <span id="startTime"></span></p>
                <p><strong>End Time:</strong> <span id="endTime"></span></p>
            </div>
        </div>

        <hr>

        <h4>Billing Details</h4>
        <div class="row">
            <div class="col-md-6">
                <p><strong>Distance Travelled:</strong> <span id="distance"></span></p>
                <p><strong>Estimated Duration:</strong> <span id="duration"></span></p>
            </div>
            <div class="col-md-6 text-end">
                <p><strong>Total Price:</strong> <span id="price"></span></p>
            </div>
        </div>

        <hr>

        <h4>Terms & Conditions</h4>
        <ul>
            <li>All fares are estimated and may vary depending on traffic conditions.</li>
            <li>Additional charges may apply for tolls, peak hours, or waiting time.</li>
            <li>No refunds are allowed once the ride has been completed.</li>
            <li>This invoice is subject to change without prior notice.</li>
            <li>For inquiries, please contact Mega City Cab support.</li>
        </ul>

        <hr>

        <div class="text-center">
            <button class="btn btn-success" onclick="printInvoice()">Print Invoice</button>
        </div>
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

<script>
    // Set current date for invoice
    document.getElementById("invoiceDate").innerText = new Date().toLocaleDateString();
</script>

</body>
</html>
