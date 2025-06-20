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
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/dashboardAdmin.css">
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
        <a href="<%= request.getContextPath() %>/logout">
            <div class="menu-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </div>
        </a>
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