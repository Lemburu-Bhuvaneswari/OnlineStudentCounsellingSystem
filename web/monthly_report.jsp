<%@ page import="java.sql.*" %>

<%
String usertype = (String) session.getAttribute("usertype");
if(usertype == null || !usertype.equals("hod")){
    response.sendRedirect("index.jsp");
    return;
}

String dname = (String) session.getAttribute("dname");

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/student_counselling",
    "root",
    "root"
);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reports & Analytics</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.31/jspdf.plugin.autotable.min.js"></script>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}
body{
    background:#f8fafc;
    padding:24px;
}
h1{
    font-size:34px;
    font-weight:700;
}
.subtitle{
    color:#64748b;
    margin:10px 0 28px;
}
.cards{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:20px;
    margin-bottom:28px;
}
.report-card{
    background:#fff;
    padding:24px;
    border-radius:20px;
    border:2px solid transparent;
    cursor:pointer;
    transition:.3s;
    box-shadow:0 6px 18px rgba(0,0,0,.05);
}
.report-card.active{
    border-color:#9333ea;
    background:#faf5ff;
}
.section{
    display:none;
    background:#fff;
    padding:24px;
    border-radius:22px;
    box-shadow:0 8px 24px rgba(15,23,42,.06);
}
.section.active{
    display:block;
}
.filter-row{
    display:flex;
    gap:15px;
    flex-wrap:wrap;
    margin:20px 0;
}
.filter-input{
    padding:12px 16px;
    border:1px solid #dbe2ea;
    border-radius:12px;
    min-width:220px;
}
.btn{
    background:linear-gradient(90deg,#9333ea,#2563eb);
    color:#fff;
    border:none;
    padding:12px 20px;
    border-radius:12px;
    font-weight:600;
    cursor:pointer;
}
table{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}
thead{
    background:linear-gradient(90deg,#3b82f6,#9333ea);
    color:#fff;
}
th,td{
    padding:16px;
    text-align:left;
    vertical-align:top;
}
tbody tr{
    border-bottom:1px solid #eef2f7;
}
.badge{
    padding:6px 14px;
    border-radius:999px;
    font-size:12px;
    font-weight:600;
}
.completed{
    background:#dcfce7;
    color:#16a34a;
}
.pending{
    background:#fef3c7;
    color:#d97706;
}
.summary-card{
    max-width:350px;
    border:1px solid #e5e7eb;
    border-radius:18px;
    padding:24px;
    margin-top:20px;
}
.summary-card p{
    margin-top:14px;
}
.workload-card{
    border:1px solid #e5e7eb;
    border-radius:18px;
    padding:20px;
    margin-top:18px;
}
.progress{
    height:10px;
    background:#e5e7eb;
    border-radius:999px;
    overflow:hidden;
    margin-top:12px;
}
.progress-bar{
    height:100%;
    background:linear-gradient(90deg,#9333ea,#2563eb);
}
</style>
</head>
<body>

<h1>Reports & Analytics</h1>
<p class="subtitle">View counselling reports by category</p>

<div class="cards">
    <div class="report-card active" onclick="showSection('status',this)">
        <h3>Counselling Status</h3>
        <p>All counselling conducted</p>
    </div>

    <div class="report-card" onclick="showSection('department',this)">
        <h3>Department Summary</h3>
        <p>Summary for your department</p>
    </div>

    <div class="report-card" onclick="showSection('workload',this)">
        <h3>Counselor Workload</h3>
        <p>Sessions handled by counselors</p>
    </div>
</div>


<!-- COUNSELLING STATUS -->
<div id="status" class="section active">

<div style="display:flex;justify-content:space-between;align-items:center;">
    <div>
        <h2>Counselling Status</h2>
        <p style="color:#64748b;">Filter counselling reports</p>
    </div>

    <button onclick="downloadPDF()" class="btn">
        Generate Report
    </button>
</div>

<form method="get" class="filter-row">

<input type="text" name="search"
placeholder="Search student/counsellor..."
value="<%= request.getParameter("search")!=null?request.getParameter("search"):"" %>"
class="filter-input">

<select name="status" class="filter-input">
    <option value="">All Status</option>
    <option value="Completed" <%= "Completed".equals(request.getParameter("status"))?"selected":"" %>>Completed</option>
    <option value="Pending" <%= "Pending".equals(request.getParameter("status"))?"selected":"" %>>Pending</option>
</select>

<input type="month" name="month"
value="<%= request.getParameter("month")!=null?request.getParameter("month"):"" %>"
class="filter-input">

<button type="submit" class="btn">Apply Filters</button>

</form>


<table id="reportTable">
<thead>
<tr>
    <th>Roll Number</th>
    <th>Name</th>
    <th>Year</th>
    <th>Issue</th>
    <th>Remarks</th>
    <th>Counsellor</th>
    <th>Status</th>
</tr>
</thead>
<tbody>

<%
String search = request.getParameter("search");
String statusFilter = request.getParameter("status");
String monthFilter = request.getParameter("month");

StringBuilder query = new StringBuilder(
"SELECT s.rollno,s.name AS student_name,s.year," +
"c.problem,c.counselling_notes," +
"COALESCE(st.name,'Not Assigned') AS staff_name," +
"c.status " +
"FROM counselling_sessions c " +
"JOIN student s ON c.student_roll=s.rollno " +
"LEFT JOIN staff st ON TRIM(c.staff_id)=TRIM(st.email) " +
"WHERE s.department=? "
);

if(search!=null && !search.trim().isEmpty()){
    query.append("AND (s.name LIKE ? OR s.rollno LIKE ? OR st.name LIKE ?) ");
}

if(statusFilter!=null && !statusFilter.trim().isEmpty()){
    query.append("AND c.status=? ");
}

if(monthFilter!=null && !monthFilter.trim().isEmpty()){
    query.append("AND DATE_FORMAT(c.session_date,'%Y-%m')=? ");
}

query.append("ORDER BY c.session_date DESC");

PreparedStatement statusPs = conn.prepareStatement(query.toString());

int idx=1;
statusPs.setString(idx++,dname);

if(search!=null && !search.trim().isEmpty()){
    String like="%"+search+"%";
    statusPs.setString(idx++,like);
    statusPs.setString(idx++,like);
    statusPs.setString(idx++,like);
}

if(statusFilter!=null && !statusFilter.trim().isEmpty()){
    statusPs.setString(idx++,statusFilter);
}

if(monthFilter!=null && !monthFilter.trim().isEmpty()){
    statusPs.setString(idx++,monthFilter);
}

ResultSet statusRs = statusPs.executeQuery();

while(statusRs.next()){
%>

<tr>
    <td><%= statusRs.getString("rollno") %></td>
    <td><%= statusRs.getString("student_name") %></td>
    <td><%= statusRs.getString("year") %></td>
    <td><%= statusRs.getString("problem") %></td>
    <td><%= statusRs.getString("counselling_notes") %></td>
    <td><%= statusRs.getString("staff_name") %></td>
    <td>
        <span class="badge <%= statusRs.getString("status").equalsIgnoreCase("Completed")?"completed":"pending" %>">
            <%= statusRs.getString("status") %>
        </span>
    </td>
</tr>

<%
}
statusRs.close();
statusPs.close();
%>

</tbody>
</table>
</div>


<!-- DEPARTMENT SUMMARY -->
<div id="department" class="section">

<h2>Department Summary</h2>

<%
ps = conn.prepareStatement(
"SELECT COUNT(*) total," +
"SUM(CASE WHEN c.status='Completed' THEN 1 ELSE 0 END) completed," +
"SUM(CASE WHEN c.status='Pending' THEN 1 ELSE 0 END) pending " +
"FROM counselling_sessions c " +
"JOIN student s ON c.student_roll=s.rollno " +
"WHERE s.department=?"
);

ps.setString(1,dname);
rs=ps.executeQuery();

if(rs.next()){
%>

<div class="summary-card">
    <h3><%= dname %></h3>
    <p>Total Sessions <span style="float:right;"><%= rs.getInt("total") %></span></p>
    <p style="color:green;">Completed <span style="float:right;"><%= rs.getInt("completed") %></span></p>
    <p style="color:orange;">Pending <span style="float:right;"><%= rs.getInt("pending") %></span></p>
</div>

<%
}
%>

</div>


<!-- COUNSELOR WORKLOAD -->
<div id="workload" class="section">

<h2>Counselor Workload Analysis</h2>

<%
ps = conn.prepareStatement(
"SELECT st.name,st.email," +
"COUNT(c.session_id) total," +
"SUM(CASE WHEN c.status='Completed' THEN 1 ELSE 0 END) completed," +
"SUM(CASE WHEN c.status='Pending' THEN 1 ELSE 0 END) pending " +
"FROM staff st " +
"LEFT JOIN counselling_sessions c ON TRIM(st.email)=TRIM(c.staff_id) " +
"WHERE st.department=? " +
"GROUP BY st.name,st.email"
);

ps.setString(1,dname);
rs=ps.executeQuery();

while(rs.next()){

int total=rs.getInt("total");
int completed=rs.getInt("completed");
int pending=rs.getInt("pending");

int progress=total==0?0:(completed*100/total);
%>

<div class="workload-card">
    <div style="display:flex;justify-content:space-between;">
        <div>
            <h3><%= rs.getString("name") %></h3>
            <p><%= total %> Total Sessions</p>
        </div>

        <div>
            <span style="color:green;"><%= completed %> Completed</span><br>
            <span style="color:orange;"><%= pending %> Pending</span>
        </div>
    </div>

    <div class="progress">
        <div class="progress-bar" style="width:<%= progress %>%"></div>
    </div>
</div>

<%
}
conn.close();
%>

</div>


<script>
function showSection(id,card){
    document.querySelectorAll('.section').forEach(sec=>sec.classList.remove('active'));
    document.querySelectorAll('.report-card').forEach(c=>c.classList.remove('active'));

    document.getElementById(id).classList.add('active');
    card.classList.add('active');
}

async function downloadPDF(){
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF('landscape');

    const department = "<%= dname %>";

    const searchVal =
        document.querySelector('input[name="search"]')?.value || "All";

    const statusVal =
        document.querySelector('select[name="status"]')?.value || "All";

    const monthRaw =
        document.querySelector('input[name="month"]')?.value || "All";

    const monthVal = monthRaw==="All"||monthRaw===""
        ? "All"
        : new Date(monthRaw+"-01").toLocaleString('default',{
            month:'long',
            year:'numeric'
        });

    doc.setFontSize(18);
    doc.text(`${department} Department Counselling Report`,14,18);

    doc.setFontSize(10);
    doc.text("Generated: "+new Date().toLocaleString(),14,26);
    doc.text("Search: "+searchVal,14,33);
    doc.text("Status: "+statusVal,90,33);
    doc.text("Month: "+monthVal,170,33);

    doc.autoTable({
        html:'#reportTable',
        startY:40,
        theme:'grid',
        styles:{
            fontSize:9,
            cellPadding:4,
            overflow:'linebreak'
        },
        headStyles:{
            fillColor:[124,58,237],
            textColor:255
        },
        alternateRowStyles:{
            fillColor:[248,250,252]
        },
        didDrawPage:function(data){
            const pageHeight=doc.internal.pageSize.height;
            const pageWidth=doc.internal.pageSize.width;

            doc.setFontSize(9);

            doc.text(
                "Online Student Counselling System",
                14,
                pageHeight-10
            );

            doc.text(
                "Page "+doc.internal.getNumberOfPages(),
                pageWidth-30,
                pageHeight-10
            );
        }
    });

    doc.save(`${department}_Counselling_Report.pdf`);
}
</script>

</body>
</html>