<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Users</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootswatch Theme -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/litera/bootstrap.min.css">

    <script>
        const url = "http://localhost:8080/api/user";

        document.addEventListener("DOMContentLoaded", function () {
            const user = JSON.parse(sessionStorage.getItem("user"));
            if (!user || user.role !== "ADMIN") {
                showToast("danger", "Access denied. Only admins can manage users.");
                setTimeout(() => window.location.href = "dashboard.jsp", 3000);
                return;
            }
            loadUsers();
        });

        function loadUsers() {
            fetch(url)
                .then(res => res.json())
                .then(data => {
                    console.log("User Data Received:", data);
                    let userTable = document.getElementById("userTable");
                    userTable.innerHTML = "";

                    data.forEach(user => {
                        console.log("Processing User:", user);
                        console.log("User Role:", user.role);

                        let row = document.createElement("tr");

                        // Username Column
                        let usernameCell = document.createElement("td");
                        usernameCell.textContent = user.username || "N/A";
                        row.appendChild(usernameCell);

                        // Role Column with Dropdown
                        let roleCell = document.createElement("td");
                        let roleSelect = document.createElement("select");
                        roleSelect.className = "form-select form-select-sm";

                        let roles = ["CUSTOMER", "DRIVER", "OPERATOR", "ADMIN"];
                        roles.forEach(role => {
                            let option = document.createElement("option");
                            option.value = role;
                            option.textContent = role;
                            if (user.role === role) {
                                option.selected = true;
                            }
                            roleSelect.appendChild(option);
                        });

                        roleSelect.onchange = function () {
                            updateUserRole(user.id, roleSelect.value);
                        };
                        roleCell.appendChild(roleSelect);
                        row.appendChild(roleCell);

                        // Status Column
                        let statusCell = document.createElement("td");
                        statusCell.textContent = user.status;
                        row.appendChild(statusCell);

                        // Actions Column (Toggle Status Button)
                        let actionCell = document.createElement("td");
                        let toggleButton = document.createElement("button");
                        toggleButton.className = `btn btn-${user.status == "ACTIVE" ? "warning" : "success"} btn-sm`;
                        toggleButton.textContent = user.status == "ACTIVE" ? "Deactivate" : "Activate";
                        toggleButton.onclick = function () {
                            toggleUserStatus(user.id, user.status);
                        };
                        actionCell.appendChild(toggleButton);
                        row.appendChild(actionCell);

                        userTable.appendChild(row);
                    });
                })
                .catch(error => console.error("Error loading users:", error));
        }

        function updateUserRole(userId, newRole) {
            fetch(url + "/updateRole", {
                method: "PUT",
                headers: { "content-type": "application/json" },
                body: JSON.stringify({ id: userId, role: newRole })
            }).then(() => {
                showToast("success", "User role updated successfully!");
                loadUsers();
            }).catch(() => showToast("danger", "Failed to update user role!"));
        }

        function toggleUserStatus(userId, currentStatus) {
            const newStatus = currentStatus === "ACTIVE" ? "INACTIVE" : "ACTIVE";
            fetch(url + "/updateStatus", {
                method: "PUT",
                headers: { "content-type": "application/json" },
                body: JSON.stringify({ id: userId, status: newStatus })
            }).then(() => {
                showToast("success", "User status updated successfully!");
                loadUsers();
            }).catch(() => showToast("danger", "Failed to update user status!"));
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
                    <a class="nav-link active" href="#">Manage Users</a>
                </li>
            </ul>
            <button class="btn btn-danger ms-3" onclick="logout()">Logout</button>
        </div>
    </div>
</nav>

<!-- Manage Users Section -->
<div class="container mt-4">
    <h2 class="text-center">Manage Users</h2>

    <div class="table-responsive">
        <table class="table table-bordered mt-3">
            <thead class="table-dark">
            <tr>
                <th>Username</th>
                <th>Role</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="userTable"></tbody>
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
