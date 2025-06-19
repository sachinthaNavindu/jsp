<%@ page import="lk.ijse.jspassignment.dto.ComplainDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.jspassignment.dto.CustomeDTO" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 19/06/2025
  Time: 2:03 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String NIC = (String) session.getAttribute("NIC");
    String userName = (String) session.getAttribute("name");

    Integer pendingCount = (Integer) session.getAttribute("pendingCompCount");
    Integer inProgressCount = (Integer) session.getAttribute("inProgressCount");
    Integer resolvedCount = (Integer) session.getAttribute("resolvedCount");

    List<ComplainDTO> complaintsPending = (List<ComplainDTO>) session.getAttribute("complaintsPending");
    List<ComplainDTO> complaintsInProgress = (List<ComplainDTO>) session.getAttribute("complaintsInProgress");
    List<CustomeDTO> complaintsResolved = (List<CustomeDTO>) session.getAttribute("complaintsResolved");

    if(NIC == null){
        response.sendRedirect("signin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Complaint Management Dashboard</title>
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

        .btn-danger {
            background-color: #e74c3c;
            color: white;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        .btn-edit {
            background-color: #f39c12;
            color: white;
        }

        .btn-edit:hover {
            background-color: #d35400;
        }

        .btn-success {
            background-color: #2ecc71;
            color: white;
        }

        .btn-success:hover {
            background-color: #27ae60;
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
        }

        .status-pending {
            color: #f39c12;
            font-weight: 500;
        }

        .status-resolved {
            color: #2ecc71;
            font-weight: 500;
        }

        .status-in-progress {
            color: #3498db;
            font-weight: 500;
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

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: white;
            border-radius: 5px;
            width: 500px;
            max-width: 90%;
            padding: 30px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .close {
            font-size: 24px;
            cursor: pointer;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .container a {
            text-decoration: none;
            color: white;
        }

        .stats-container {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .stat-card {
            flex: 1;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 20px;
            text-align: center;
        }

        .stat-card h3 {
            margin-top: 0;
            color: #7f8c8d;
        }

        .stat-card .count {
            font-size: 36px;
            font-weight: bold;
            margin: 10px 0;
        }

        .stat-card.pending .count {
            color: #f39c12;
        }

        .stat-card.in-progress .count {
            color: #3498db;
        }

        .stat-card.resolved .count {
            color: #2ecc71;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container">
    <div class="option-bar">
        <div class="logo">
            <h2>Admin Dashboard</h2>
        </div>

        <a href="dashboardAdmin.jsp">
            <div class="menu-item active">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </div>
        </a>

        <a href="<%= request.getContextPath() + "/employee?username=" + userName %>">
        <div class="menu-item">
                <i class="fas fa-users"></i>
                <span>User Management</span>
            </div>
        </a>
        <div class="menu-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </div>
    </div>
    <div class="loading-bar">
        <div class="top-bar">
            <h3>Admin Complaint Management</h3>
            <div class="user-info">
                <img src="https://ui-avatars.com/api/?name=Admin&background=3498db&color=fff" alt="Admin">
                <span><%= userName %></span>
            </div>
        </div>
        <div class="content">
            <div class="stats-container">
                <div class="stat-card pending">
                    <h3>Pending</h3>
                    <div class="count"><%= pendingCount %></div>
                    <p>Complaints awaiting action</p>
                </div>
                <div class="stat-card in-progress">
                    <h3>In Progress</h3>
                    <div class="count"><%= inProgressCount %></div>
                    <p>Complaints being processed</p>
                </div>
                <div class="stat-card resolved">
                    <h3>Resolved</h3>
                    <div class="count"><%= resolvedCount %></div>
                    <p>Complaints resolved</p>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h4>Pending Complaints</h4>
                </div>
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>User</th>
                        <th>Title</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if(complaintsPending != null && !complaintsPending.isEmpty()) {
                        for(ComplainDTO complaint : complaintsPending) { %>
                    <tr>
                        <td><%= complaint.getComplainId() %></td>
                        <td><%= complaint.getNic() %></td>
                        <td><%= complaint.getContext() %></td>
                        <td><%= complaint.getDate() %></td>
                        <td><%= complaint.getStatus() %></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admincomplaintviewer?complaintid=<%= complaint.getComplainId()%>">
                                <div class="action-view">
                                    <button class="btn btn-edit btn-sm">
                                        <i class="fas fa-edit"></i> View
                                    </button>
                                </div>
                            </a>
                            <br>
                            <a href="${pageContext.request.contextPath}/delete?complainid=<%= complaint.getComplainId()%>">
                                <button class="btn btn-danger btn-sm" <%= complaint.getStatus().equals("pending") || complaint.getStatus().equals("In Progress") ? "" : "disabled" %>>
                                    <i class="fas fa-trash"></i>
                                </button>
                            </a>
                        </td>
                    </tr>
                    <% }
                    } else { %>
                    <tr>
                        <td colspan="6">No complaints to display.</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <div class="card">
                <div class="card-header">
                    <h4>In Progress Complaints</h4>

                </div>
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>User</th>
                        <th>Title</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if(complaintsInProgress != null && !complaintsInProgress.isEmpty()) {
                        for(ComplainDTO complaint : complaintsInProgress) { %>
                    <tr>
                        <td><%= complaint.getComplainId() %></td>
                        <td><%= complaint.getNic() %></td>
                        <td><%= complaint.getContext() %></td>
                        <td><%= complaint.getDate() %></td>
                        <td><%= complaint.getStatus() %></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admincomplaintviewer?complaintid=<%= complaint.getComplainId()%>">
                                <div class="action-view">
                                    <button class="btn btn-success btn-sm">
                                        <i class="fas fa-edit"></i> View
                                    </button>
                                </div>
                            </a>
                            <br>
                            <a href="${pageContext.request.contextPath}/delete?complainid=<%= complaint.getComplainId()%>">
                                <button class="btn btn-danger btn-sm" <%= complaint.getStatus().equals("pending") || complaint.getStatus().equals("In Progress") ? "" : "disabled" %>>
                                    <i class="fas fa-trash"></i>
                                </button>
                            </a>
                        </td>
                    </tr>
                    <% }
                    } else { %>
                    <tr>
                        <td colspan="6">No complaints to display.</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <div class="card">
                <div class="card-header">
                    <h4>Resolved Complaints</h4>

                </div>
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>User</th>
                        <th>Title</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Admin Comment</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if(complaintsResolved != null && !complaintsResolved.isEmpty()) {
                        for(CustomeDTO complaint : complaintsResolved) { %>
                    <tr>
                        <td><%= complaint.getComplaintId() %></td>
                        <td><%= complaint.getNic() %></td>
                        <td><%= complaint.getDescription() %></td>
                        <td><%= complaint.getDate() %></td>
                        <td><%= complaint.getStatus() %></td>
                        <td><%=complaint.getSolution()%></td>
                    </tr>
                    <% }
                    } else { %>
                    <tr>
                        <td colspan="6">No complaints to display.</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>


</body>
</html>