<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>View Departments</title>

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
.table-card{
    background:#fff;
    padding:18px;
    border-radius:20px;
    box-shadow:0 8px 20px rgba(0,0,0,.06);
}

/* TABLE */
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
<h4 class="page-title"><i class="fa fa-building"></i> View Departments</h4>

<div class="search-box">
<i class="fa fa-search"></i>
<input type="text" id="searchInput" placeholder="Search departments...">
</div>
</div>

<div class="table-card">
<div class="table-responsive">
<table class="table table-hover" id="deptTable">

<thead>
<tr>
<th>ID</th>
<th>Department Name</th>
<th>Action</th>
</tr>
</thead>

<tbody>
<%
try{
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/student_counselling","root","root");
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("SELECT * FROM department");

while(rs.next()){
%>

<tr>
<td><%=rs.getInt("dept_id")%></td>
<td><%=rs.getString("dept_name")%></td>

<td>
<a href="delete_department.jsp?id=<%=rs.getInt("dept_id")%>"
   class="icon-btn delete-btn"
   onclick="return confirm('Delete this department?')">
   <i class="fa fa-trash"></i>
</a>
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
document.querySelectorAll("#deptTable tbody tr").forEach(row=>{
row.style.display=row.innerText.toLowerCase().includes(value)?"":"none";
});
});
</script>

</body>
</html>