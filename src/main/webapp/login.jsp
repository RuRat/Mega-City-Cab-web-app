<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- Bootswatch Theme -->
    <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/litera/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg p-4">
                <h3 class="text-center">User Login</h3>
                <form>
                    <div class="mb-3">
                        <label for="txtUsername" class="form-label">Username</label>
                        <input type="text" class="form-control" id="txtUsername" required>
                    </div>
                    <div class="mb-3">
                        <label for="txtPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="txtPassword" required>
                    </div>
                    <button type="button" class="btn btn-primary w-100" onclick="loginUser()">Login</button>
                </form>
                <div class="text-center mt-3">
                    <a href="registerUser.jsp">Don't have an account? Register here</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const url = "http://localhost:8080/api/user/login";
    function loginUser() {
        const user = {
            "username": document.getElementById("txtUsername").value,
            "password": document.getElementById("txtPassword").value
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
                if (data.status === "SUCCESS") {
                    sessionStorage.setItem("user", JSON.stringify(data.user));
                    alert("Login Successful");
                    window.location.href = "dashboard.jsp";
                } else {
                    alert("Invalid Credentials");
                }
            })
            .catch(error => {
                console.error("Error:", error);
            });
    }
</script>
</body>
</html>