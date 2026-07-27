<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>View HOD</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
body,*{
    font-family:'Poppins',sans-serif;
    box-sizing:border-box;
}

body{
    background:transparent;
    margin:0;
    padding:0;
}

/* PAGE HEADER */
.page-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:18px;
    flex-wrap:wrap;
    gap:15px;
}

.page-title{
    font-size:22px;
    font-weight:700;
    margin:0;
    color:#1e293b;
}

/* SEARCH */
.search-box{
    position:relative;
    width:320px;
    max-width:100%;
}

.search-box i{
    position:absolute;
    left:14px;
    top:50%;
    transform:translateY(-50%);
    color:#94a3b8;
}

.search-box input{
    width:100%;
    padding:10px 14px 10px 40px;
    border:1px solid #dbe2ea;
    border-radius:14px;
    outline:none;
    font-size:14px;
}

/* TABLE CARD */
.table{
    margin:0;
    border-collapse:separate;
    border-spacing:0;
}

/* GRADIENT HEADER */
thead tr{
    background:linear-gradient(90deg,#1d72f3 0%, #1aa7ff 45%, #14b8c4 100%);
}

thead th{
    background:transparent !important;
    color:#fff !important;
    padding:18px;
    text-align:left;
    font-size:15px;
    font-weight:700;
    border:none !important;
    letter-spacing:.3px;
}

thead th:first-child{
    border-top-left-radius:16px;
}

thead th:last-child{
    border-top-right-radius:16px;
}

/* BODY CELLS */
tbody td{
    padding:18px;
    vertical-align:middle;
    border-color:#eef2f7;
    font-size:14px;
    color:#334155;
}

/* ROW HOVER */
tbody tr:hover{
    background:#f8fbff;
}
/* TABLE WRAPPER */
.table-card{
    background:#fff;
    padding:20px;
    border-radius:22px;
    box-shadow:0 8px 22px rgba(0,0,0,.06);
}

/* TABLE */
.table{
    width:100%;
    margin:0;
    border-collapse:separate;
    border-spacing:0;
}

/* HEADER ROW */
thead tr{
    background:linear-gradient(90deg,#1d72f3 0%, #1aa7ff 45%, #14b8c4 100%);
}

/* HEADER CELLS */
thead th{
    background:transparent !important;
    color:#fff !important;
    padding:20px 18px;
    font-size:15px;
    font-weight:700;
    border:none !important;
    vertical-align:middle;
}

/* HEADER RADIUS */
thead th:first-child{
    border-top-left-radius:16px;
}

thead th:last-child{
    border-top-right-radius:16px;
}

/* BODY CELLS */
tbody td{
    padding:14px 18px;
    vertical-align:middle;
    border-bottom:1px solid #eef2f7;
    font-size:14px;
    color:#334155;
}

/* REMOVE EXTRA TALL ROWS */
tbody tr{
    height:auto;
}

/* HOVER */
tbody tr:hover{
    background:#f8fbff;
}
/* ACTION BUTTON */
.icon-btn{
    width:38px;
    height:38px;
    border:none;
    border-radius:12px;
    display:flex;
    align-items:center;
    justify-content:center;
    text-decoration:none;
    color:#fff;
    transition:.25s ease;
}

.delete-btn{
    background:#ef4444;
    box-shadow:0 6px 14px rgba(239,68,68,.25);
}

.delete-btn:hover{
    transform:translateY(-2px);
    background:#dc2626;
    color:#fff;
}
/* ACTION COLUMN */
.action-cell{
    display:flex;
    align-items:center;
    justify-content:center;
    gap:10px;
    min-height:60px;
}

/* COMMON BUTTON */
.edit-btn,
.delete-btn{
    width:38px;
    height:38px;
    border:none;
    border-radius:12px;
    display:flex;
    align-items:center;
    justify-content:center;
    text-decoration:none;
    color:#fff !important;
    transition:.25s ease;
    flex-shrink:0;
    cursor:pointer;
}

/* EDIT BUTTON */
.edit-btn{
    background:linear-gradient(135deg,#2563eb,#06b6d4);
    box-shadow:0 6px 14px rgba(37,99,235,.25);
}

/* DELETE BUTTON */
.delete-btn{
    background:#ef4444;
    box-shadow:0 6px 14px rgba(239,68,68,.25);
}

/* HOVER */
.edit-btn:hover,
.delete-btn:hover{
    transform:translateY(-2px) scale(1.05);
}
/* RESPONSIVE */
@media(max-width:768px){
    .page-header{
        flex-direction:column;
        align-items:stretch;
    }

    .search-box{
        width:100%;
    }
}
</style>
</head>
<body>

<div class="container-fluid">

<div class="page-header">
    <h4 class="page-title"><i class="fa fa-user-tie"></i> View HOD</h4>

    <div class="search-box">
        <i class="fa fa-search"></i>
        <input type="text" id="searchInput" placeholder="Search HOD...">
    </div>
</div>

<div class="table-card">
<div class="table-responsive">
<table class="table table-hover" id="hodTable">

<thead>
<tr>
<th>ID</th>
<th>Name</th>
<th>Department</th>
<th>Email</th>
<th>Phone</th>
<th>Action</th>
</tr>
</thead>

<tbody>
<%
int k=0;
try{
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/student_counselling","root","root");
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("SELECT * FROM hod");

while(rs.next()){
%>

<tr>
<td><%=++k%></td>
<td><%=rs.getString("name")%></td>
<td><%=rs.getString("department")%></td>
<td><%=rs.getString("email")%></td>
<td><%=rs.getString("phone")%></td>

<td>
    <div class="action-cell">

        <button class="edit-btn"
            onclick="parent.loadPage('admin_edit_hod.jsp?id=<%=rs.getInt("hod_id")%>')">
            <i class="fa fa-pen"></i>
        </button>

        <a href="delete_hod.jsp?id=<%=rs.getInt("hod_id")%>"
           class="delete-btn"
           onclick="return confirm('Delete this HOD?')">
            <i class="fa fa-trash"></i>
        </a>

    </div>
</td>
</tr>

<% }}catch(Exception e){out.println(e);} %>
</tbody>

</table>
</div>
</div>
</div>

<script>
document.getElementById("searchInput").addEventListener("keyup",function(){
let value=this.value.toLowerCase();
document.querySelectorAll("#hodTable tbody tr").forEach(row=>{
row.style.display=row.innerText.toLowerCase().includes(value)?"":"none";
});
});
</script>

</body>
</html>