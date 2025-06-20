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
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    List<EmployeeDTO> employeeList = (List<EmployeeDTO>) request.getAttribute("employeeList");
    String userName = (String) session.getAttribute("loggedInUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/employeemanagement.css">
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
        <a href="<%= request.getContextPath() %>/logout">
            <div class="menu-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </div>
        </a>
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

<script src="js/employeemanagement.js"></script>
</body>
</html>