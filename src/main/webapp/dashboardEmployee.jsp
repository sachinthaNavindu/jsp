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
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/dashboardEmployee.css">
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
        <a href="<%= request.getContextPath() %>/logout">
            <div class="menu-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </div>
        </a>
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
                                    <button id="btn-edit" class="btn btn-edit btn-sm"
                                            <%= complaint.getStatus().equals("pending") ? "" : "disabled" %>
                                            style="<%= !complaint.getStatus().equals("pending") ? "opacity: 0.5; cursor: not-allowed;" : "" %>">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </a>

                                <a href="${pageContext.request.contextPath}/dashboard?type=delete&userNic=<%=complaint.getNic()%>&complainid=<%=complaint.getComplainId()%>">
                                    <button class="btn btn-danger btn-sm"
                                            <%= complaint.getStatus().equals("pending") ? "" : "disabled" %>
                                            style="<%= !complaint.getStatus().equals("pending") ? "opacity: 0.5; cursor: not-allowed;" : "" %>">
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
