<!--view_counselling.jsp-->

<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires", 0);
%>

<!--view_counselling.jsp-->
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
<html>
<head>
<meta charset="UTF-8">
<title>View Counselling</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<script>
function closeToast(){
    const toast = document.getElementById("successToast");
    if(toast){
        toast.style.opacity = "0";
        toast.style.transform = "translateX(40px)";
        setTimeout(()=>toast.remove(),300);
    }
}

setTimeout(function(){
    closeToast();
},3000);
</script>

<style>
body{
    background:transparent;
    padding:25px;
    font-family:'Poppins',sans-serif;
}

.sessions-card{
    background:#fff;
    border-radius:28px;
    padding:30px;
    border:1px solid #d9f4ef;
}

.page-title{
    font-size:32px;
    font-weight:700;
    margin-bottom:25px;
    display:flex;
    align-items:center;
    gap:12px;
    color:#0f172a;
}

.custom-table{
    width:100%;
    border-collapse:separate;
    border-spacing:0;
    overflow:hidden;
    border-radius:18px;
}

.custom-table thead{
    background:linear-gradient(90deg,#20c4b2,#15897f);
}

.custom-table thead th{
    color:#fff;
    padding:16px;
    font-weight:600;
}

.custom-table tbody td{
    padding:16px;
    border-bottom:1px solid #edf2f7;
    vertical-align:middle;
}

.status-badge{
    padding:8px 14px;
    border-radius:20px;
    font-size:13px;
    font-weight:600;
}

.badge-completed{
    background:#dcfce7;
    color:#166534;
}

.badge-pending{
    background:#fef3c7;
    color:#b45309;
}

.badge-escalated{
    background:#fee2e2;
    color:#b91c1c;
}

.btn-main{
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    color:#fff;
    border:none;
    padding:10px 16px;
    border-radius:10px;
    font-weight:600;
}

.btn-escalate{
    background:linear-gradient(135deg,#f59e0b,#d97706);
    color:#fff;
    border:none;
    padding:10px 16px;
    border-radius:10px;
    font-weight:600;
}

.action-box{
    display:flex;
    gap:8px;
    flex-wrap:wrap;
}

.expand-box{
    background:#f8fffe;
    border:1px solid #d9f4ef;
    padding:20px;
    border-radius:16px;
}
.custom-toast{
    position:fixed;
    top:25px;
    right:25px;
    background:linear-gradient(135deg,#16a34a,#15803d);
    color:white;
    padding:16px 22px;
    border-radius:14px;
    box-shadow:0 12px 30px rgba(22,163,74,.25);
    font-weight:600;
    display:flex;
    align-items:center;
    gap:12px;
    z-index:9999;
    animation:slideIn .4s ease;
    min-width:320px;
}

.custom-toast i{
    font-size:18px;
}

.custom-toast button{
    margin-left:auto;
    background:none;
    border:none;
    color:white;
    font-size:22px;
    cursor:pointer;
    line-height:1;
}

@keyframes slideIn{
    from{
        opacity:0;
        transform:translateX(40px);
    }
    to{
        opacity:1;
        transform:translateX(0);
    }
}
</style>
</head>
<body>

<div class="sessions-card">

    <%
String escalated = request.getParameter("escalated");
if("success".equals(escalated)){
%>
<div id="successToast" class="custom-toast">
    <i class="fa fa-circle-check"></i>
    Case escalated to HOD successfully.
    <button onclick="closeToast()">&times;</button>
</div>
<%
}
%>

<h2 class="page-title">
    <i class="fa fa-calendar-check text-success"></i>
    Counselling Sessions
</h2>

<table class="custom-table">
<thead>
<tr>
    <th>ID</th>
    <th>Student</th>
    <th>Date</th>
    <th>Time</th>
    <th>Venue</th>
    <th>Purpose</th>
    <th>Notes</th>
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
        "SELECT c.*, s.name " +
        "FROM counselling_sessions c " +
        "JOIN student s ON c.student_roll=s.rollno " +
        "WHERE c.staff_id=? " +
        "ORDER BY c.session_date DESC"
    );

    ps.setString(1,username);

    ResultSet rs=ps.executeQuery();

    int count=1;

    while(rs.next()){

        String status=rs.getString("status");
        int sessionId=rs.getInt("session_id");

        String badgeClass="badge-pending";

        if("Completed".equalsIgnoreCase(status)){
            badgeClass="badge-completed";
        }
        else if("Escalated".equalsIgnoreCase(status)){
            badgeClass="badge-escalated";
        }
%>

<tr>
    <td><%=count++%></td>
    <td><%=rs.getString("name")%></td>
    <td><%=rs.getDate("session_date")%></td>
    <td><%=rs.getString("session_time")==null?"—":rs.getString("session_time")%></td>
    <td><%=rs.getString("venue")==null?"—":rs.getString("venue")%></td>
    <td><%=rs.getString("problem")%></td>
    <td><%=rs.getString("counselling_notes")==null?"—":rs.getString("counselling_notes")%></td>

    <td>
        <span class="status-badge <%=badgeClass%>">
            <%=status%>
        </span>
    </td>

    <td>
<%
boolean canTakeAction =
    !"Completed".equalsIgnoreCase(status) &&
    !"Escalated".equalsIgnoreCase(status) &&
    !"Resolved by HOD".equalsIgnoreCase(status);
%>

<% if(canTakeAction){ %>
        <div class="action-box">

            <button class="btn-main"
                    onclick="toggleComplete(<%=sessionId%>)">
                Complete
            </button>

            <button class="btn-escalate"
                    onclick="toggleEscalate(<%=sessionId%>)">
                Escalate
            </button>

        </div>

        <% } else { %>

<%
if("Resolved by HOD".equalsIgnoreCase(status)){
%>
    <span style="color:#b45309;font-weight:700;">
        Resolved by HOD
    </span>
<%
}else{
%>
    <span style="color:#16a34a;font-weight:600;">
        Done
    </span>
<%
}
%>
        <% } %>
    </td>
</tr>

<!-- COMPLETE FORM -->
<tr id="completeRow<%=sessionId%>" style="display:none;">
<td colspan="9">
<div class="expand-box">
<form action="complete_counselling.jsp" method="post">

<input type="hidden" name="session_id" value="<%=sessionId%>">

<label class="fw-semibold mb-2">Counselling Notes</label>

<textarea name="counselling_notes"
          class="form-control mb-3"
          rows="4"
          required></textarea>

<button class="btn-main">
    Mark Completed
</button>

</form>
</div>
</td>
</tr>

<!-- ESCALATE FORM -->
<tr id="escalateRow<%=sessionId%>" style="display:none;">
<td colspan="9">
<div class="expand-box">

<%
int reqId = rs.getInt("request_id");

if(!rs.wasNull()){
%>

<form action="escalate_request_action.jsp" method="post">

    <input type="hidden" name="session_id" value="<%=sessionId%>">
    <input type="hidden" name="request_id" value="<%=reqId%>">

    <label class="fw-semibold mb-2">Escalation Reason</label>

    <textarea name="escalation_reason"
              class="form-control mb-3"
              rows="4"
              required
              placeholder="Enter reason for escalation"></textarea>

    <button class="btn-escalate">
        Escalate to HOD
    </button>

</form>

<%
}else{
%>

<div class="alert alert-danger">
    Cannot escalate this session because Request ID is missing.
</div>

<%
}
%>

</div>
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
<td colspan="9" class="text-danger text-center">
    <%=e.getMessage()%>
</td>
</tr>

<%
}
%>

</tbody>
</table>

</div>

<script>
function toggleComplete(id){

    let row=document.getElementById("completeRow"+id);
    let esc=document.getElementById("escalateRow"+id);

    esc.style.display="none";
    row.style.display=row.style.display==="none"?"table-row":"none";
}

function toggleEscalate(id){

    let row=document.getElementById("escalateRow"+id);
    let comp=document.getElementById("completeRow"+id);

    comp.style.display="none";
    row.style.display=row.style.display==="none"?"table-row":"none";
}
</script>

</body>

</html>