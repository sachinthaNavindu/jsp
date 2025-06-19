<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.jspassignment.dto.ComplainDTO" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 15/06/2025
  Time: 2:30 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String NIC = (String) session.getAttribute("NIC");
    String userName = (String) session.getAttribute("name");
    List<ComplainDTO> complaints = (List<ComplainDTO>) session.getAttribute("complaints");

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
    <title>Complaint Management Dashboard</title>
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

        .container a{
            text-decoration: none;
            color: white;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="container">
    <div class="option-bar">
        <div class="logo">
            <h2>Complaint System</h2>
        </div>
        <div class="menu-item active">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </div>
        <a href="${pageContext.request.contextPath}/complain">
            <div class="menu-item">
                <i class="fas fa-plus-circle"></i>
                <span>New Complaint</span>
            </div>
        </a>
        <div class="menu-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </div>
    </div>
    <div class="loading-bar">
        <div class="top-bar">
            <h3>Complaint Management</h3>
            <div class="user-info">
                <img src="https://ui-avatars.com/api/?name=<%= userName != null ? userName.replace(" ", "+") : "User" %>&background=3498db&color=fff" alt="User">
                <span><%= userName %></span>
            </div>
        </div>
        <div class="content">
            <div class="card">
                <div class="card-header">
                    <h4>Submit New Complaint</h4>
                    <a href="${pageContext.request.contextPath}/complain"><button class="btn btn-primary" id="newComplaintBtn">
                        <i class="fas fa-plus"></i> New Complaint
                    </button></a>
                </div>
                <p>Click the button above to submit a new complaint.</p>
            </div>

            <div class="card">
                <div class="card-header">
                    <h4>My Recent Complaints</h4>
                </div>
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (complaints != null) {
                        for (ComplainDTO complaint : complaints) {
                    %>
                    <tr>
                        <td><%= complaint.getComplainId()%></td>
                        <td><%= complaint.getContext() %></td>
                        <td><%= complaint.getDate() %></td>
                        <td><%= complaint.getStatus() %></td>
                        <td>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/complainupdate?complainid=<%=complaint.getComplainId()%>">
                                    <button id="btn-edit" class="btn btn-edit btn-sm" <%= complaint.getStatus().equals("pending") ? "" : "disabled" %>>
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </a>

                                <a href="${pageContext.request.contextPath}/dashboard?type=delete&userNic=<%=complaint.getNic()%>&type=delete&complainid=<%= complaint.getComplainId()%>">
                                    <button class="btn btn-danger btn-sm" <%= complaint.getStatus().equals("pending") ? "" : "disabled" %>>
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%    }
                    } else { %>
                    <tr><td colspan="5">No complaints to display.</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
