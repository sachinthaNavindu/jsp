<%@ page import="lk.ijse.jspassignment.dto.EmployeeDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 19/06/2025
  Time: 11:17 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<EmployeeDTO> employeeList = (List<EmployeeDTO>) request.getAttribute("employeeList");
    String userName = (String) session.getAttribute("loggedInUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management</title>
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            margin: 0;
            background-color: #f5f5f5;
        }

        .container {
            height: 100vh;
            width: 100%;
            display: flex;
        }

        .option-bar {
            height: 100%;
            width: 250px;
            background-color: #2c3e50;
            color: white;
            padding: 20px 0;
        }

        .logo {
            text-align: center;
            padding: 10px 0 30px;
            border-bottom: 1px solid #34495e;
            margin-bottom: 20px;
        }

        .logo h2 {
            margin: 0;
        }

        .menu-item {
            padding: 15px 25px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
        }

        .menu-item:hover {
            background-color: #34495e;
        }

        .menu-item.active {
            background-color: #3498db;
        }

        .menu-item i {
            margin-right: 10px;
            font-size: 18px;
        }

        .loading-bar {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .top-bar {
            height: 70px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 30px;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .content {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
        }

        .card {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 20px;
            margin-bottom: 20px;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }

        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-primary {
            background-color: #3498db;
            color: white;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        .btn-success {
            background-color: #2ecc71;
            color: white;
        }

        .btn-success:hover {
            background-color: #27ae60;
        }

        .btn-danger {
            background-color: #e74c3c;
            color: white;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        .btn-disabled {
            background-color: #95a5a6;
            color: white;
            cursor: not-allowed;
            opacity: 0.6;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #f8f9fa;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f8f9fa;
            cursor: pointer;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        select.form-control {
            height: 38px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-col {
            flex: 1;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .container a {
            text-decoration: none;
            color: white;
        }

        input[readonly] {
            background-color: #f5f5f5;
            cursor: not-allowed;
        }
        .is-invalid {
            border-color: #e74c3c !important;
        }

        .invalid-feedback {
            width: 100%;
            margin-top: 0.25rem;
            font-size: 0.875em;
            color: #e74c3c;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container">
    <div class="option-bar">
        <div class="logo">
            <h2>Employee System</h2>
        </div>
        <a href="${pageContext.request.contextPath}/reload">
            <div class="menu-item">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </div>
        </a>
        <div class="menu-item active">
            <i class="fas fa-users"></i>
            <span>User Management</span>
        </div>
        <div class="menu-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </div>
    </div>
    <div class="loading-bar">
        <div class="top-bar">
            <h3>Employee Management</h3>
            <div class="user-info">
                <img src="https://ui-avatars.com/api/?name=Admin&background=3498db&color=fff" alt="User">
                <span><%=userName%></span>
            </div>
        </div>
        <div class="content">
            <div class="card">
                <div class="card-header">
                    <h4>Add New Employee</h4>
                </div>
                <form id="employeeForm" action="employee" method="post">
                    <div class="form-row">
                        <div class="form-col">
                            <div class="form-group">
                                <label for="nic">NIC Number</label>
                                <input type="text" class="form-control" id="nic" name="nic"
                                       pattern="^([0-9]{9}[vVxX]|[0-9]{12})$"
                                       title="10 digits ending with V/X or 12 digits"
                                       required>
                            </div>
                        </div>
                        <div class="form-col">
                            <div class="form-group">
                                <label for="name">Full Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" class="form-control" id="address" name="address" required>
                    </div>

                    <div class="form-row">
                        <div class="form-col">
                            <div class="form-group">
                                <label for="contact">Contact Number</label>
                                <input type="tel" class="form-control" id="contact" name="contact"
                                       pattern="^0[0-9]{9}$"
                                       title="10 digits starting with 0"
                                       required>
                            </div>
                        </div>
                        <div class="form-col">
                            <div class="form-group">
                                <label for="role">Job Role</label>
                                <select class="form-control" id="role" name="role" required>
                                    <option value="">Select Role</option>
                                    <option value="admin">Admin</option>
                                    <option value="employee">Employee</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="action-buttons">
                        <button type="submit" name="type" value="save" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save
                        </button>
                        <button type="submit" name="type" value="update" id="updateBtn" class="btn btn-success btn-disabled" disabled>
                            <i class="fas fa-sync-alt"></i> Update
                        </button>
                    </div>
                </form>
            </div>

            <div class="card">
                <div class="card-header">
                    <h4>Employee List</h4>
                </div>
                <table>
                    <thead>
                    <tr>
                        <th>NIC</th>
                        <th>Name</th>
                        <th>Contact</th>
                        <th>Address</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (employeeList != null) {
                        for (EmployeeDTO emp : employeeList) { %>
                    <tr onclick="loadEmployeeData('<%= emp.getNic() %>', '<%= emp.getName() %>', '<%= emp.getAddress() %>', '<%= emp.getContact() %>', '<%= emp.getJobRole() %>')">
                        <td><%= emp.getNic() %></td>
                        <td><%= emp.getName() %></td>
                        <td><%= emp.getContact() %></td>
                        <td><%=emp.getAddress()%></td>
                        <td><%= emp.getJobRole() %></td>
                        <td>
                            <form action="employee" method="post" style="display:inline;">
                                <input type="hidden" name="deleteNic" value="<%= emp.getNic() %>">
                                <button type="submit" name="type" value="delete" class="btn btn-danger">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%   }
                    } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    function loadEmployeeData(nic, name, address, contact, role) {
        document.getElementById('nic').value = nic;
        document.getElementById('name').value = name;
        document.getElementById('address').value = address;
        document.getElementById('contact').value = contact;
        document.getElementById('role').value = role;

        document.getElementById('nic').readOnly = true;

        const updateBtn = document.getElementById('updateBtn');
        updateBtn.disabled = false;
        updateBtn.classList.remove('btn-disabled');
    }

    document.addEventListener('click', function(e) {
        if (!e.target.closest('table') && !e.target.closest('#employeeForm')) {
            resetForm();
        }
    });

    function resetForm() {
        document.getElementById('employeeForm').reset();
        document.getElementById('nic').readOnly = false;

        const updateBtn = document.getElementById('updateBtn');
        updateBtn.disabled = true;
        updateBtn.classList.add('btn-disabled');
    }

    function validateNIC(nic) {
        const oldNicPattern = /^[0-9]{9}[vVxX]$/;
        const newNicPattern = /^[0-9]{12}$/;

        return oldNicPattern.test(nic) || newNicPattern.test(nic);
    }

    function validateContactNumber(contact) {
        const pattern = /^0[0-9]{9}$/;
        return pattern.test(contact);
    }

    document.getElementById('nic').addEventListener('blur', function() {
        const nic = this.value.trim();
        const errorElement = document.getElementById('nicError') || createErrorElement(this, 'nicError');

        if (nic === '') {
            errorElement.textContent = 'NIC is required';
            this.classList.add('is-invalid');
            return;
        }

        if (!validateNIC(nic)) {
            errorElement.textContent = 'Please enter a valid NIC (10 digits ending with V/X or 12 digits)';
            this.classList.add('is-invalid');
        } else {
            errorElement.textContent = '';
            this.classList.remove('is-invalid');
        }
    });

    document.getElementById('contact').addEventListener('blur', function() {
        const contact = this.value.trim();
        const errorElement = document.getElementById('contactError') || createErrorElement(this, 'contactError');

        if (contact === '') {
            errorElement.textContent = 'Contact number is required';
            this.classList.add('is-invalid');
            return;
        }

        if (!validateContactNumber(contact)) {
            errorElement.textContent = 'Please enter a valid 10-digit phone number starting with 0';
            this.classList.add('is-invalid');
        } else {
            errorElement.textContent = '';
            this.classList.remove('is-invalid');
        }
    });

    function createErrorElement(inputElement, id) {
        const errorElement = document.createElement('div');
        errorElement.id = id;
        errorElement.className = 'invalid-feedback';
        inputElement.parentNode.appendChild(errorElement);
        return errorElement;
    }

    document.getElementById('employeeForm').addEventListener('submit', function(e) {
        const nic = document.getElementById('nic').value.trim();
        const contact = document.getElementById('contact').value.trim();

        if (!validateNIC(nic)) {
            e.preventDefault();
            alert('Please enter a valid NIC number');
            document.getElementById('nic').focus();
            return;
        }

        if (!validateContactNumber(contact)) {
            e.preventDefault();
            alert('Please enter a valid contact number');
            document.getElementById('contact').focus();
            return;
        }
    });
</script>
</body>
</html>