<!DOCTYPE html>
<html>
<head>
    <title>Manage Reservations</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script>
        const url = "http://localhost:8080/api/reservation";

        document.addEventListener("DOMContentLoaded", function() {
            const user = JSON.parse(sessionStorage.getItem("user"));
            if (!user) {
                alert("You must be logged in to access this page.");
                window.location.href = "login.jsp";
                return;
            }
            loadReservations();
        });

        function loadReservations() {
            fetch(url)
                .then(res => res.json())
                .then(data => {
                    let reservationTable = document.getElementById("reservationTable");
                    reservationTable.innerHTML = "";
                    data.forEach(reservation => {
                        reservationTable.innerHTML += `<tr>
                                <td>\${reservation.customerId}</td>
                                <td>\${reservation.vehicleId}</td>
                                <td>\${reservation.pickupLocation}</td>
                                <td>\${reservation.destinationLocation}</td>
                                <td>\${reservation.startTime}</td>
                                <td>\${reservation.endTime}</td>
                                <td>\${reservation.status}</td>
                                <td>
                                    <select onchange="updateReservationStatus('\${reservation.id}', this.value)">
                                        <option value="PENDING" \${reservation.status === 'PENDING' ? 'selected' : ''}>Pending</option>
                                        <option value="CONFIRMED" \${reservation.status === 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                                        <option value="CANCELLED" \${reservation.status === 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                    </select>
                                </td>
                            </tr>`;
                    });
                })
                .catch(error => console.error("Error loading reservations:", error));
        }

        function updateReservationStatus(reservationId, newStatus) {
            fetch(url + "/updateStatus", {
                method: "PUT",
                headers: { "content-type": "application/json" },
                body: JSON.stringify({ id: reservationId, status: newStatus })
            }).then(() => loadReservations());
        }
    </script>
</head>
<body>
<h2>Manage Reservations</h2>
<table border="1">
    <thead>
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

<br>
<a href="dashboard.jsp">Back to Dashboard</a>
</body>
</html>