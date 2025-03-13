<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <!-- Bootswatch Theme -->
    <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/litera/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg p-4">
                <h3 class="text-center">User Registration</h3>
                <form>
                    <div class="mb-3">
                        <label for="txtUsername" class="form-label">Username</label>
                        <input type="text" class="form-control" id="txtUsername" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="txtPassword" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtRole" class="form-label">Select Role</label>
                        <select class="form-control" id="txtRole" required>
                            <option value="CUSTOMER">Customer</option>
                            <option value="DRIVER">Driver</option>
                            <option value="OPERATOR">Operator</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="txtName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="txtName" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtAddress" class="form-label">Address</label>
                        <input type="text" class="form-control" id="txtAddress" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtPhone" class="form-label">Phone Number</label>
                        <input type="text" class="form-control" id="txtPhone" required>
                    </div>
                    <button type="button" class="btn btn-primary w-100" onclick="registerUser()">Register</button>
                </form>
                <div class="text-center mt-3">
                    <a href="login.jsp">Already have an account? Login here</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const url = "http://localhost:8080/api/user/register";
    function registerUser() {
        const user = {
            "username": document.getElementById("txtUsername").value,
            "password": document.getElementById("txtPassword").value,
            "role": document.getElementById("txtRole").value,
            "name": document.getElementById("txtName").value,
            "address": document.getElementById("txtAddress").value,
            "phone": document.getElementById("txtPhone").value
        };

        const options = {
            method: "POST",
            headers: {
                "content-type": "application/json"
            },
            body: JSON.stringify(user)
        };

        fetch(url, options)
            .then(res => res.json())
            .then(data => {
                alert(data);
                window.location.href = "login.jsp";
            })
            .catch(error => {
                console.error("Error:", error);
            });
    }
</script>
</body>
</html>
