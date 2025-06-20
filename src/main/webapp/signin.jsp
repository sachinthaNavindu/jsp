    <%--
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
        <link
                href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
                rel="stylesheet"
                integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT"
                crossorigin="anonymous"
        />
        <link rel="stylesheet" href="css/signin.css">
    </head>
        <body>
        <div class="container">
            <div class="signin-container">
                <div class="signin-logo">
                    <h2>Welcome Back</h2>
                    <p class="text-muted">Please sign in to continue</p>
                </div>

                <form id="signinForm" novalidate action="signin" method="post">
                    <div class="form-floating mb-3">
                        <input
                                type="email"
                                class="form-control"
                                id="emailInput"
                                name="emailInput"
                                placeholder="name@example.com"
                                autocomplete="username"
                                required
                        />
                        <label for="emailInput">Email address</label>
                        <div class="invalid-feedback">
                            Please enter a valid email address.
                        </div>
                    </div>

                    <div class="form-floating mb-3">
                        <input
                                type="password"
                                class="form-control"
                                id="passwordInput"
                                name="passwordInput"
                                placeholder="Password"
                                autocomplete="current-password"
                                required
                        />
                        <label for="passwordInput">Password</label>
                        <div class="invalid-feedback">Please enter your password.</div>
                    </div>

                    <button type="submit"
                            class="btn btn-primary btn-signin"
                            id="btnSignIn">Sign In
                    </button>

                    <div class="forgot-password">
                        <a href="#" class="text-decoration-none">Forgot password?</a>
                    </div>

                    <%
                        String error = request.getParameter("error");
                        if ("invalid".equals(error)){
                    %>
                    <div class="alert alert-danger text-center py-2" role="alert">
                        Invalid email or password.
                    </div>
                    <%
                        }else if("server".equals(error)){
                    %>
                        <div class="alert alert-danger text-center py-2" role="alert">
                            Server error, try again later
                        </div>
                    <%
                        }
                    %>
                </form>

                <div class="signup-link">
                    <p class="text-muted">
                        Don't have an account?
                        <a href="${pageContext.request.contextPath}/signup" class="text-decoration-none"
                        >Sign up</a
                        >
                    </p>
                </div>
            </div>
        </div>
    </body>
    </html>
