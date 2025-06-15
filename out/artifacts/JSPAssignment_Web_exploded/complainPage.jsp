<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 15/06/2025
  Time: 5:03 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String NIC = (String) session.getAttribute("NIC");
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
    <title>Submit Complaint</title>
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
            max-width: 800px;
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

        /* Rest of your existing styles... */
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

        .required:after {
            content: " *";
            color: #e74c3c;
        }
    </style>
</head>
<body>
<div class="complaint-container">


    <div class="header">
        <h1>Submit a Complaint</h1>
        <p>Please fill out the form below to submit your complaint</p>
    </div>

    <div class="form-content">
        <%
            String success = request.getParameter("success");
            if ("true".equals(success)){
            %>
                <div style="background-color: #d4edda; color: #155724; padding: 15px; margin-bottom: 20px; border: 1px solid #c3e6cb; border-radius: 5px;">
                    Complaint submitted successfully!
                </div>
            <%
            }
             %>

        <%
            String error = request.getParameter("error");
            if ("true".equals(error)){
        %>
        <div style="background-color: #f8d7da; color: #721c24; padding: 15px; margin-bottom: 20px; border: 1px solid #f5c6cb; border-radius: 5px;">
            Failed to submit complaint. Please try again.
        </div>
        <%
            }
        %>
        <form id="complaintForm" action="complain" method="post">
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label class="required">NIC Number</label>
                        <input type="text" class="form-control" id="nicNumber" name="nicNumber"
                               value="<%= NIC%>" readonly
                               required
                               pattern="[0-9]{9}[vVxX]|[0-9]{12}"
                               title="Please enter a valid NIC number (old format: 9 digits ending with V/X or new format: 12 digits)">
                    </div>
                </div>
                <div class="col">
                    <div class="form-group">
                        <label>Complaint ID</label>
                        <input type="text" class="form-control" id="complaintId"
                               name="complaintId"
                               value="<%= request.getAttribute("nextComplainId") != null ? request.getAttribute("nextComplainId") : "" %>"
                               readonly required>
                    </div>
                </div>
            </div>

            <%
                java.time.LocalDate date = java.time.LocalDate.now();
                java.time.LocalTime time = java.time.LocalTime.now();
                java.time.format.DateTimeFormatter timeFormatter = java.time.format.DateTimeFormatter.ofPattern("HH:mm");
            %>

            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label>Date</label>
                        <input type="text" class="form-control" id="complaintDate" name="complaintDate"
                               value="<%= date %>" readonly>
                    </div>
                </div>
                <div class="col">
                    <div class="form-group">
                        <label>Time</label>
                        <input type="text" class="form-control" id="complaintTime" name="complaintTime"
                               value="<%= time.format(timeFormatter) %>" readonly>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="required">Complaint Category</label>
                <select class="form-control" id="complaintCategory" name="complaintCategory" required>
                    <option value="">-- Select a category --</option>
                    <option value="facility">Facility Issue</option>
                    <option value="it">IT Problem</option>
                    <option value="hr">HR Matter</option>
                    <option value="security">Security Concern</option>
                    <option value="other">Other</option>
                </select>
            </div>

            <div class="form-group">
                <label class="required">Complaint Description</label>
                <textarea class="form-control" id="complaintDescription" name="complaintDescription"
                          placeholder="Please describe your complaint in detail..." required></textarea>
            </div>

            <div class="form-group" style="text-align: right; margin-top: 30px;">
                <button type="submit" class="btn btn-primary">Submit Complaint</button>
                <button type="reset" class="btn btn-reset">Reset Form</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
