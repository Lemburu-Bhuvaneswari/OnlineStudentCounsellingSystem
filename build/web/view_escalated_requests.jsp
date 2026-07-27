<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String hodEmail = (String) session.getAttribute("username");

if(hodEmail == null){
    response.sendRedirect("index.jsp");
    return;
}

String filter = request.getParameter("filter");
if(filter == null) filter = "pending";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Escalated Issues</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:transparent;
    padding:20px;
}
.wrapper{
    background:#f8fafc;
    border-radius:24px;
    padding:30px;
    border:1px solid #e2e8f0;
}
.heading{
    font-size:42px;
    font-weight:700;
    margin-bottom:28px;
    color:#0f172a;
}

/* STAT CARDS */
.stats-grid{
    display:grid;
    grid-template-columns:repeat(2,1fr);
    gap:20px;
    margin-bottom:28px;
}
.stat-card{
    padding:24px;
    border-radius:20px;
    color:#fff;
    text-decoration:none;
    transition:.3s ease;
    box-shadow:0 8px 20px rgba(0,0,0,.08);
    position:relative;
    overflow:hidden;
}
.stat-card:hover{
    transform:translateY(-4px) scale(1.02);
    box-shadow:0 15px 30px rgba(124,58,237,.25);
}
.active-card{
    outline:4px solid rgba(255,255,255,.35);
}
.pending-card{
    background:linear-gradient(135deg,#3b82f6,#6366f1);
}
.resolved-card{
    background:linear-gradient(135deg,#9333ea,#7c3aed);
}
.stat-number{
    font-size:38px;
    font-weight:700;
    line-height:1;
}
.stat-label{
    margin-top:8px;
    font-size:15px;
    opacity:.95;
}
.stat-icon{
    position:absolute;
    right:20px;
    top:20px;
    font-size:34px;
    opacity:.18;
}

/* TABLE */
.table-box{
    background:#fff;
    padding:16px;
    border-radius:22px;
    box-shadow:0 8px 25px rgba(0,0,0,.06);
}
.custom-table{
    width:100%;
    border-collapse:collapse;
    overflow:hidden;
    border-radius:18px;
}
.custom-table thead{
    background:linear-gradient(90deg,#3b82f6,#9333ea);
    color:#fff;
}
.custom-table th,
.custom-table td{
    padding:16px;
    vertical-align:middle;
}
.custom-table tbody tr:hover{
    background:#f8fafc;
}

.btn-resolve{
    background:linear-gradient(135deg,#22c55e,#16a34a);
    color:#fff;
    padding:8px 14px;
    border-radius:10px;
    text-decoration:none;
    font-weight:600;
}

.badge-escalated{
    background:#fef3c7;
    color:#d97706;
    padding:6px 14px;
    border-radius:20px;
    font-size:13px;
    font-weight:600;
}
.badge-resolved{
    background:#dcfce7;
    color:#166534;
    padding:6px 14px;
    border-radius:20px;
    font-size:13px;
    font-weight:600;
}

.no-data{
    text-align:center;
    padding:25px;
    color:#64748b;
    font-weight:500;
}
</style>
</head>
<body>

<div class="wrapper">

<h2 class="heading">Escalated Issues</h2>

<%
int pendingCount = 0;
int resolvedCount = 0;
String hodDepartment = "";

Connection con = null;

try{
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root","root"
    );

    PreparedStatement psDept = con.prepareStatement(
        "SELECT department FROM hod WHERE email=?"
    );
    psDept.setString(1, hodEmail);

    ResultSet rsDept = psDept.executeQuery();
    if(rsDept.next()){
        hodDepartment = rsDept.getString("department");
    }

    PreparedStatement psStats = con.prepareStatement(
        "SELECT " +
        "SUM(CASE WHEN cr.status='Escalated' THEN 1 ELSE 0 END) pending_count, " +
        "SUM(CASE WHEN cr.status='Resolved by HOD' THEN 1 ELSE 0 END) resolved_count " +
        "FROM counselling_request cr " +
        "JOIN student s ON cr.student_roll=s.rollno " +
        "WHERE s.department=?"
    );

    psStats.setString(1, hodDepartment);
    ResultSet rsStats = psStats.executeQuery();

    if(rsStats.next()){
        pendingCount = rsStats.getInt("pending_count");
        resolvedCount = rsStats.getInt("resolved_count");
    }
%>

<div class="stats-grid">

<a href="view_escalated_requests.jsp?filter=pending"
   class="stat-card pending-card <%=filter.equals("pending")?"active-card":""%>">
    <i class="fa fa-triangle-exclamation stat-icon"></i>
    <div class="stat-number counter" data-target="<%=pendingCount%>">0</div>
    <div class="stat-label">Pending Escalated Requests</div>
</a>

<a href="view_escalated_requests.jsp?filter=resolved"
   class="stat-card resolved-card <%=filter.equals("resolved")?"active-card":""%>">
    <i class="fa fa-circle-check stat-icon"></i>
    <div class="stat-number counter" data-target="<%=resolvedCount%>">0</div>
    <div class="stat-label">Completed Escalated Requests</div>
</a>

</div>

<div class="table-box">
<table class="custom-table">

<thead>
<tr>
    <th>ID</th>
    <th>Student</th>
    <th>Roll No</th>
    <th>Issue</th>
    <th>Escalation Reason</th>
    <th>Escalated By</th>
    <th>Date</th>
    <th>Status</th>

    <% if(filter.equals("pending")){ %>
        <th>Action</th>
    <% } else { %>
        <th>HOD Remarks</th>
    <% } %>
</tr>
</thead>

<tbody>

<%
String statusCondition =
    filter.equals("resolved")
    ? "Resolved by HOD"
    : "Escalated";

PreparedStatement ps = con.prepareStatement(
    "SELECT cr.*, s.name AS student_name " +
    "FROM counselling_request cr " +
    "JOIN student s ON cr.student_roll=s.rollno " +
    "WHERE cr.status=? AND s.department=? " +
    "ORDER BY cr.escalated_date DESC"
);

ps.setString(1, statusCondition);
ps.setString(2, hodDepartment);

ResultSet rs = ps.executeQuery();

int count = 1;
boolean hasData = false;

while(rs.next()){
    hasData = true;
%>

<tr>
    <td><%=count++%></td>
    <td><%=rs.getString("student_name")%></td>
    <td><%=rs.getString("student_roll")%></td>
    <td><%=rs.getString("issue")%></td>
    <td><%=rs.getString("escalation_reason")%></td>
    <td><%=rs.getString("escalated_by")%></td>
    <td><%=rs.getTimestamp("escalated_date")%></td>

    <td>
        <% if(filter.equals("pending")){ %>
            <span class="badge-escalated">Escalated</span>
        <% } else { %>
            <span class="badge-resolved">Resolved</span>
        <% } %>
    </td>

    <% if(filter.equals("pending")){ %>
    <td>
        <a href="resolve_escalated_request.jsp?id=<%=rs.getInt("request_id")%>"
           class="btn-resolve">
           Resolve
        </a>
    </td>
    <% } else { %>
    <td><%=rs.getString("hod_remarks")%></td>
    <% } %>

</tr>

<%
}

if(!hasData){
%>
<tr>
    <td colspan="9" class="no-data">
        No records found.
    </td>
</tr>
<%
}
%>

</tbody>
</table>
</div>

<%
rs.close();
ps.close();
rsStats.close();
psStats.close();
rsDept.close();
psDept.close();
con.close();

}catch(Exception e){
%>
<div class="alert alert-danger">
    Error: <%=e.getMessage()%>
</div>
<%
}
%>

</div>

<script>
document.addEventListener("DOMContentLoaded", function(){

    const counters = document.querySelectorAll(".counter");

    counters.forEach(counter => {

        const target = parseInt(counter.getAttribute("data-target"));
        let count = 0;

        const increment = Math.max(1, Math.ceil(target / 40));

        const updateCounter = () => {
            count += increment;

            if(count >= target){
                counter.innerText = target;
            }else{
                counter.innerText = count;
                requestAnimationFrame(updateCounter);
            }
        };

        updateCounter();
    });

});
</script>

</body>
</html>