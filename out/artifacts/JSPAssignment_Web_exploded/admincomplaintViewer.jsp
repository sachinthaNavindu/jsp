    <%@ page import="lk.ijse.jspassignment.dto.ComplainDTO" %><%--
      Created by IntelliJ IDEA.
      User: User
      Date: 19/06/2025
      Time: 1:12 pm
      To change this template use File | Settings | File Templates.
    --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%
        ComplainDTO complainDTO = (ComplainDTO) request.getAttribute("complaint");
    %>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Complaint Management</title>
        <link rel="stylesheet" href="css/admincomplaintViewer.css">
    </head>
    <body>
    <div class="complaint-container">
        <div class="user-bar">
            <div>
                <a href="${pageContext.request.contextPath}/reload" style="color: white; text-decoration: none;">← Back to Dashboard</a>
            </div>
        </div>

        <div class="header">
            <h1>Complaint Management</h1>
            <p>Review and manage the submitted complaint</p>
        </div>

        <div class="form-content">
            <%
                String error = request.getParameter("error");
                if ("true".equals(error)){
            %>
            <div style="background-color: #f8d7da; color: #721c24; padding: 15px; margin-bottom: 20px; border: 1px solid #f5c6cb; border-radius: 5px;">
                Failed to update complaint. Please try again.
            </div>
            <%
                }
            %>
            <form id="complaintForm" action="admincomplaintviewer" method="post">
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <label>NIC Number</label>
                            <input type="text" class="form-control info-field"
                                   value="<%=complainDTO.getNic()%>" readonly>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label>Complaint ID</label>
                            <input type="text" class="form-control info-field"
                                   name="complaintId"
                                   value="<%=complainDTO.getComplainId()%>" readonly>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <label>Submitted Date</label>
                            <input type="text" class="form-control info-field"
                                   value="<%=complainDTO.getDate()%>" readonly>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label>Submitted Time</label>
                            <input type="text" class="form-control info-field"
                                   value="<%=complainDTO.getTime()%>" readonly>
                        </div>
                    </div>
                </div>

                <div class="form-group highlight-field">
                    <label class="highlight-label">Complaint Category</label>
                    <input type="text" class="form-control"
                           value="<%=complainDTO.getCategory()%>" readonly
                           style="font-size: 16px; font-weight: 600; color: #2c3e50;">
                </div>

                <div class="form-group highlight-field">
                    <label class="highlight-label">Complaint Description</label>
                    <textarea class="form-control highlight-textarea" readonly><%=complainDTO.getContext()%></textarea>
                </div>

                <div class="form-group">
                    <label>Admin Comments</label>
                    <textarea class="form-control" id="adminComments" name="adminComments"
                              placeholder="Add any comments or updates regarding this complaint..."
                              required
                    ></textarea>
                </div>

                <div class="admin-actions">
                    <div class="action-buttons">
                        <button type="submit" name="action" value="inprogress" class="btn btn-primary">Mark as InProgress</button>
                        <button type="submit" name="action" value="solved" class="btn btn-success">Mark as Solved</button>
                    </div>

                </div>
            </form>

        </div>
    </div>
    </body>
    </html>
