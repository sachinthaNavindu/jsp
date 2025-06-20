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
    <link rel="stylesheet" href="css/complainPage.css">
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
                    <option value="facility Issue">Facility Issue</option>
                    <option value="It Problem">IT Problem</option>
                    <option value="Hr Matter">HR Matter</option>
                    <option value="Security Concern">Security Concern</option>
                    <option value="Other">Other</option>
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
