<!--resolve_escaleted_request.jsp-->

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String hodEmail = (String) session.getAttribute("username");

if(hodEmail == null){
    response.sendRedirect("index.jsp");
    return;
}

String requestId = request.getParameter("id");

String studentRoll = "";
String issue = "";
String escalationReason = "";
String staffName = "";

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/student_counselling",
    "root","root"
);

PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM counselling_request WHERE request_id=?"
);
ps.setString(1, requestId);

ResultSet rs = ps.executeQuery();

if(rs.next()){
    studentRoll = rs.getString("student_roll");
    issue = rs.getString("issue");
    escalationReason = rs.getString("escalation_reason");
    staffName = rs.getString("escalated_by");
}

rs.close();
ps.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Resolve Escalated Request</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:#f8fafc;
    padding:30px;
}

.resolve-card{
    max-width:850px;
    margin:auto;
    background:#fff;
    border-radius:20px;
    padding:30px;
    box-shadow:0 8px 25px rgba(0,0,0,.08);
}

.heading{
    font-size:28px;
    font-weight:700;
    margin-bottom:25px;
}

.info-box{
    background:#f8fafc;
    border:1px solid #e2e8f0;
    border-radius:14px;
    padding:15px;
    margin-bottom:18px;
}

label{
    font-weight:600;
    margin-bottom:8px;
}

.btn-resolve{
    background:linear-gradient(90deg,#16a34a,#15803d);
    border:none;
    padding:12px 28px;
    border-radius:12px;
    color:#fff;
    font-weight:600;
}
</style>
</head>
<body>

<div class="resolve-card">

    <h2 class="heading">
        <i class="fa fa-gavel text-success"></i>
        Resolve Escalated Issue
    </h2>

    <form action="resolve_escalated_action.jsp" method="post">

        <input type="hidden" name="request_id" value="<%=requestId%>">

        <div class="mb-3">
            <label>Student Roll No</label>
            <div class="info-box"><%=studentRoll%></div>
        </div>

        <div class="mb-3">
            <label>Student Issue</label>
            <div class="info-box"><%=issue%></div>
        </div>

        <div class="mb-3">
            <label>Escalation Reason from Staff</label>
            <div class="info-box"><%=escalationReason%></div>
        </div>

        <div class="mb-3">
            <label>Escalated By</label>
            <div class="info-box"><%=staffName%></div>
        </div>

        <div class="mb-3">
            <label>HOD Remarks / Resolution</label>
            <textarea name="hod_remarks"
                      class="form-control"
                      rows="5"
                      required
                      placeholder="Enter final remarks / solution..."></textarea>
        </div>

        <button type="submit" class="btn-resolve">
            <i class="fa fa-check-circle"></i> Resolve Issue
        </button>

    </form>

</div>

</body>
</html>

<%
con.close();
%>