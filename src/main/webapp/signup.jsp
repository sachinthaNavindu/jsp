<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 14/06/2025
  Time: 12:04 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .signin-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .signin-logo {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-floating label {
            color: #6c757d;
        }
        .btn-signin {
            width: 100%;
            padding: 10px;
            font-weight: 600;
        }
        .forgot-password {
            text-align: right;
            margin-top: 10px;
        }
        .signin-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="signin-container">
        <div class="signin-logo">
            <h2>Welcome</h2>
            <p class="text-muted">Please fill below details</p>
        </div>

        <form id="signupForm" novalidate method="get">

            <div class="form-floating mb-3">
                <select class="form-select" id="nicSelect" name="nic" required>
                    <option selected disabled value="">Choose NIC</option>
                    <%
                        List<String> nicList = (List<String>)request.getAttribute("nicList");
                            if (nicList != null){
                                for (String nic : nicList){
                    %>
                    <option value="<%= nic %>"><%= nic %></option>
                    <%
                                }
                            }
                    %>
                </select>

                <label for="nicSelect">NIC</label>
                <div class="invalid-feedback">
                    Please select your NIC.
                </div>
            </div>


            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="usernameInput" name="username" placeholder="Username" required autocomplete="username">
                <label for="usernameInput">Username</label>
                <div class="invalid-feedback">
                    Please enter your username.
                </div>
            </div>


            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="gmailInput" name="gmail" placeholder="example@gmail.com" required autocomplete="email">
                <label for="gmailInput">Gmail</label>
                <div class="invalid-feedback">
                    Please enter a valid Gmail address.
                </div>
            </div>


            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="passwordInput" name="password" placeholder="Password" required autocomplete="new-password">
                <label for="passwordInput">Password</label>
                <div class="invalid-feedback">
                    Please enter your password.
                </div>
            </div>


            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="confirmPasswordInput" name="confirmPassword" placeholder="Confirm Password" required autocomplete="new-password">
                <label for="confirmPasswordInput">Confirm Password</label>
                <div class="invalid-feedback">
                    Passwords do not match.
                </div>
            </div>

            <button type="submit" class="btn btn-primary btn-signin">Sign Up</button>
        </form>


        <div class="signin-link">
            <p class="text-muted">Already have an account? <a href="signin.jsp" class="text-decoration-none">Sign in</a></p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.min.js" integrity="sha384-RuyvpeZCxMJCqVUGFI0Do1mQrods/hhxYlcVfGPOfQtPJh0JCw12tUAZ/Mv10S7D" crossorigin="anonymous"></script>

</body>
</html>
