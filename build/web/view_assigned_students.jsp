<!--view_assigned_students.jsp-->

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = (String) session.getAttribute("username");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Assigned Students</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
*{
    font-family:'Poppins',sans-serif;
}

body{
    background:transparent;
    padding:25px;
    margin:0;
}

/* MAIN CARD */
.students-card{
    background:#ffffff;
    border-radius:28px;
    padding:30px;
    border:1px solid #d9f4ef;
}

/* TITLE */
.page-title{
    font-size:32px;
    font-weight:700;
    color:#0f172a;
    margin-bottom:25px;
    display:flex;
    align-items:center;
    gap:14px;
}

.page-title i{
    color:#14b8a6;
}

/* STATS */
.stats-grid{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:18px;
    margin-bottom:25px;
}

.stat-box{
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    color:#fff;
    padding:22px;
    border-radius:18px;
}

.stat-box h3{
    font-size:32px;
    font-weight:700;
    margin:0;
}

.stat-box p{
    margin:6px 0 0;
    opacity:.9;
    font-size:15px;
}

/* SEARCH */
.search-box{
    margin-bottom:24px;
}

.search-box input{
    border-radius:14px;
    padding:14px 18px;
    border:1px solid #dbe4ee;
    font-size:15px;
}

/* TABLE */
.custom-table{
    width:100%;
    border-collapse:separate;
    border-spacing:0;
    border-radius:20px;
    overflow:hidden;
    background:#fff;
}

/* HEADER */
.custom-table thead{
    background:linear-gradient(90deg,#20c4b2 0%, #15897f 100%);
}

.custom-table thead th{
    color:#fff;
    padding:20px 18px;
    font-size:16px;
    font-weight:700;
    border:none;
    white-space:nowrap;
}

.custom-table thead th:first-child{
    border-top-left-radius:18px;
}

.custom-table thead th:last-child{
    border-top-right-radius:18px;
}

/* BODY */
.custom-table tbody td{
    padding:20px 18px;
    border-bottom:1px solid #edf2f7;
    color:#334155;
    font-size:15px;
    vertical-align:middle;
    background:#fff;
}

.custom-table tbody tr:hover td{
    background:#f0fbf9;
}

/* STATUS BADGES */
.status-badge{
    padding:8px 15px;
    border-radius:30px;
    font-size:13px;
    font-weight:600;
}

.badge-new{
    background:#fee2e2;
    color:#b91c1c;
}

.badge-scheduled{
    background:#dbeafe;
    color:#1d4ed8;
}

.badge-followup{
    background:#fef3c7;
    color:#b45309;
}

/* BUTTONS */
.btn-schedule{
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    border:none;
    color:#fff;
    padding:10px 18px;
    border-radius:12px;
    font-weight:600;
}

.btn-schedule:hover{
    opacity:.92;
}

/* MODAL */
.modal-content{
    border:none;
    border-radius:20px;
}

.modal-header{
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    color:#fff;
}

.btn-save{
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    border:none;
    color:#fff;
    padding:10px 24px;
    border-radius:10px;
}
</style>
</head>
<body>

<div class="students-card">

<h2 class="page-title">
    <i class="fa fa-users"></i>
    Assigned Students
</h2>

<%
int totalStudents=0;
int scheduledCount=0;
int followupCount=0;
%>

<div class="stats-grid">
    <div class="stat-box">
        <h3 id="totalStudents">0</h3>
        <p>Total Students</p>
    </div>

    <div class="stat-box">
        <h3 id="scheduledCount">0</h3>
        <p>Scheduled Sessions</p>
    </div>

    <div class="stat-box">
        <h3 id="followupCount">0</h3>
        <p>Follow-Up Cases</p>
    </div>
</div>

<div class="search-box">
    <input type="text" id="studentSearch" class="form-control"
           placeholder="Search by name / roll number...">
</div>

<table class="custom-table" id="studentsTable">
<thead>
<tr>
    <th>Id</th>
    <th>Name</th>
    <th>Roll No</th>
    <th>Last Session</th>
    <th>Next Session</th>
    <th>Status</th>
    <th>Action</th>
</tr>
</thead>

<tbody>

<%
try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps=con.prepareStatement(
        "SELECT s.*, " +
        "(SELECT MAX(session_date) FROM counselling_sessions WHERE student_roll=s.rollno AND status='Completed') AS last_session, " +
        "(SELECT MIN(session_date) FROM counselling_sessions WHERE student_roll=s.rollno AND status='Scheduled') AS next_session " +
        "FROM student s WHERE assigned_staff=?"
    );

    ps.setString(1,username);

    ResultSet rs=ps.executeQuery();

    int count=1;

    while(rs.next()){

        totalStudents++;

        String lastSession=rs.getString("last_session");
        String nextSession=rs.getString("next_session");

        String badgeClass="badge-new";
        String badgeText="No Session Yet";

        if(nextSession!=null){
            badgeClass="badge-scheduled";
            badgeText="Scheduled";
            scheduledCount++;
        }
        else if(lastSession!=null){
            badgeClass="badge-followup";
            badgeText="Follow-Up Due";
            followupCount++;
        }
%>

<tr>
    <td><%=count++%></td>
    <td><%=rs.getString("name")%></td>
    <td><%=rs.getString("rollno")%></td>
    <td><%=lastSession==null?"—":lastSession%></td>
    <td><%=nextSession==null?"—":nextSession%></td>

    <td>
        <span class="status-badge <%=badgeClass%>">
            <%=badgeText%>
        </span>
    </td>

    <td>
        <button type="button"
                class="btn-schedule"
                onclick="openScheduleModal(
                    '<%=rs.getString("rollno")%>',
                    '<%=rs.getString("name")%>'
                )">
            <i class="fa fa-calendar-plus"></i> Schedule
        </button>
    </td>
</tr>

<%
    }

    rs.close();
    ps.close();
    con.close();

}catch(Exception e){
%>

<tr>
    <td colspan="7" class="text-danger text-center">
        Error: <%=e.getMessage()%>
    </td>
</tr>

<%
}
%>

</tbody>
</table>

</div>

<!-- Schedule Modal -->
<div class="modal fade" id="scheduleModal" tabindex="-1">
<div class="modal-dialog modal-lg modal-dialog-centered">
<div class="modal-content">

<form action="save_scheduled_counselling.jsp" method="post">

<div class="modal-header">
    <h5 class="modal-title">
        <i class="fa fa-calendar-check"></i> Schedule Counselling Session
    </h5>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">

    <input type="hidden" name="student_roll" id="student_roll">

    <div class="mb-3">
        <label>Student Name</label>
        <input type="text" id="student_name" class="form-control" readonly>
    </div>

    <div class="mb-3">
        <label>Session Date</label>
        <input type="date" name="session_date" class="form-control" required>
    </div>

    <div class="mb-3">
        <label>Session Time</label>
        <input type="time" name="session_time" class="form-control" required>
    </div>

    <div class="mb-3">
        <label>Venue / Mode</label>
        <input type="text" name="venue" class="form-control"
               placeholder="Room / Meet Link / Phone Call" required>
    </div>

    <div class="mb-3">
        <label>Purpose / Topic</label>
        <textarea name="problem" class="form-control" rows="3" required></textarea>
    </div>

</div>

<div class="modal-footer">
    <button type="submit" class="btn-save">Save Schedule</button>
</div>

</form>
</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.getElementById("totalStudents").innerText="<%=totalStudents%>";
document.getElementById("scheduledCount").innerText="<%=scheduledCount%>";
document.getElementById("followupCount").innerText="<%=followupCount%>";

function openScheduleModal(roll,name){
    document.getElementById("student_roll").value=roll;
    document.getElementById("student_name").value=name;

    new bootstrap.Modal(document.getElementById("scheduleModal")).show();
}

document.getElementById("studentSearch").addEventListener("keyup",function(){
    let value=this.value.toLowerCase();
    let rows=document.querySelectorAll("#studentsTable tbody tr");

    rows.forEach(row=>{
        row.style.display=row.innerText.toLowerCase().includes(value)?"":"none";
    });
});
</script>

</body>
</html>