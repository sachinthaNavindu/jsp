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
        <style>
            * {
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                margin: 0;
                background-color: #f5f5f5;
                padding: 20px;
            }

            .user-bar {
                background-color: #2c3e50;
                color: white;
                padding: 15px 30px;
                border-radius: 8px 8px 0 0;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .user-info img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
            }

            .complaint-container {
                max-width: 1000px;
                margin: 0 auto;
                background-color: white;
                border-radius: 0 0 8px 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .header {
                text-align: center;
                margin-bottom: 30px;
                padding: 30px 30px 0;
            }

            .header h1 {
                color: #2c3e50;
                margin-bottom: 10px;
            }

            .form-content {
                padding: 0 30px 30px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #34495e;
            }

            .form-control {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
                transition: border 0.3s;
            }

            .form-control:focus {
                border-color: #3498db;
                outline: none;
            }

            .info-field {
                background-color: #f8f9fa;
                padding: 12px;
                border-radius: 4px;
                border: 1px solid #eee;
                font-weight: 500;
            }

            /* Highlighted fields */
            .highlight-field {
                background-color: #fffaf0;
                border: 2px solid #f1c40f;
                padding: 15px;
                border-radius: 6px;
                box-shadow: 0 2px 5px rgba(241, 196, 15, 0.2);
                margin-bottom: 25px;
            }

            .highlight-label {
                font-weight: 600;
                color: #e67e22;
                font-size: 17px;
            }

            .highlight-textarea {
                min-height: 180px;
                font-size: 15px;
                line-height: 1.5;
                background-color: #fffdf8;
            }

            .row {
                display: flex;
                gap: 20px;
            }

            .col {
                flex: 1;
            }

            textarea.form-control {
                min-height: 150px;
                resize: vertical;
            }

            .btn {
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
                font-size: 16px;
                transition: all 0.3s;
            }

            .btn-primary {
                background-color: #3498db;
                color: white;
            }

            .btn-primary:hover {
                background-color: #2980b9;
            }

            .btn-reset {
                background-color: #95a5a6;
                color: white;
                margin-left: 10px;
            }

            .btn-reset:hover {
                background-color: #7f8c8d;
            }

            .btn-danger {
                background-color: #e74c3c;
                color: white;
                margin-left: 10px;
            }

            .btn-danger:hover {
                background-color: #c0392b;
            }

            .btn-success {
                background-color: #2ecc71;
                color: white;
                margin-left: 10px;
            }

            .btn-success:hover {
                background-color: #27ae60;
            }

            .status-pending {
                color: #e67e22;
                font-weight: bold;
            }

            .status-inprogress {
                color: #3498db;
                font-weight: bold;
            }

            .status-solved {
                color: #2ecc71;
                font-weight: bold;
            }

            .admin-actions {
                display: flex;
                justify-content: space-between;
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid #eee;
            }

            .action-buttons {
                display: flex;
                gap: 10px;
            }

            .history-section {
                margin-top: 30px;
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 5px;
                border: 1px solid #eee;
            }

            .history-item {
                padding: 10px 0;
                border-bottom: 1px solid #eee;
            }

            .history-item:last-child {
                border-bottom: none;
            }

            .history-date {
                font-weight: bold;
                color: #7f8c8d;
            }

            .history-action {
                color: #2c3e50;
            }
        </style>
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
