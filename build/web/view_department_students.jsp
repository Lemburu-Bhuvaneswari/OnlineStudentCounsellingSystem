<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
<%
String usertype = (String) session.getAttribute("usertype");
String dname = (String) session.getAttribute("dname");

if(usertype == null || !usertype.equals("hod")){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Department Students</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    
body{
    margin:0;
    padding:0;
    font-family:'Poppins',sans-serif;
    background:transparent;
}

/* HEADER */
.page-top{
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:20px;
    flex-wrap:wrap;
    margin-bottom:20px;
    width:100%;
}

.page-heading h2{
    margin:0;
    font-size:26px;
    font-weight:700;
    color:#1e293b;
}

.page-heading p{
    margin-top:4px;
    font-size:13px;
    color:#64748b;
}

/* SEARCH */
.search-box{
    position:relative;
    width:220px;
    margin-right:15px;
    flex-shrink:0;
}

.search-box i{
    position:absolute;
    left:14px;
    top:50%;
    transform:translateY(-50%);
    color:#94a3b8;
}

.search-box input{
    width:70%;
    padding:10px 14px 10px 38px;
    border:1px solid #e2e8f0;
    border-radius:14px;
    font-size:13px;
}

/* TABLE CARD */
.table-card{
    background:rgba(255,255,255,.95);
    border-radius:20px;
    border:1px solid #e2e8f0;
    overflow:hidden;
    box-shadow:
        0 8px 20px rgba(124,58,237,.05),
        0 2px 8px rgba(0,0,0,.04);
}

/* TABLE */
table{
    width:100%;
    border-collapse:collapse;
}

thead{
    background:linear-gradient(90deg,#3b82f6,#9333ea);
}

th{
    padding:18px 18px;
    text-align:left;
    font-size:15px;
    font-weight:700;
    color:white;
    border:none;
    letter-spacing:.3px;
}

thead th:first-child{
    border-top-left-radius:16px;
}

thead th:last-child{
    border-top-right-radius:16px;
}

td{
    padding:14px 12px;
    font-size:14px;
    color:#1e293b;
    border-top:1px solid #f1f5f9;
}

tbody tr{
    transition:.25s;
}

tbody tr:hover{
    background:#faf5ff;
}

/* AVATAR */
.avatar{
    width:34px;
    height:34px;
    border-radius:50%;
    display:flex;
    align-items:center;
    justify-content:center;
    color:white;
    font-weight:600;
    font-size:13px;
    box-shadow:0 4px 10px rgba(0,0,0,.12);
}

.av1{background:linear-gradient(135deg,#7c3aed,#9333ea);}
.av2{background:linear-gradient(135deg,#2563eb,#3b82f6);}
.av3{background:linear-gradient(135deg,#16a34a,#22c55e);}
.av4{background:linear-gradient(135deg,#ea580c,#f97316);}
.av5{background:linear-gradient(135deg,#db2777,#ec4899);}

.avatar-wrap{
    display:flex;
    align-items:center;
    gap:12px;
}

/* BADGE */
.badge{
    padding:5px 10px;
    border-radius:999px;
    background:linear-gradient(135deg,#ede9fe,#ddd6fe);
    color:#6d28d9;
    font-size:10px;
    font-weight:600;
}

/* ACTION BUTTON */
.edit-btn{
    width:38px;
    height:38px;
    border-radius:12px;
    background:linear-gradient(135deg,#7c3aed,#9333ea);
    color:#fff;
    display:flex;
    align-items:center;
    justify-content:center;
    text-decoration:none;
    box-shadow:0 6px 14px rgba(124,58,237,.28);
    transition:.25s ease;
    font-size:14px;
    border:none;
}

.edit-btn:hover{
    transform:translateY(-2px) scale(1.05);
    box-shadow:0 10px 20px rgba(124,58,237,.35);
    color:#fff;
}
</style>
</head>
<body>

<div class="page-top">
    <div class="page-heading">
        <h2>Department Students</h2>
        <p>Manage and view all student records</p>
    </div>

    <div class="search-box">
        <i class="fa fa-search"></i>
        <input type="text" id="searchInput" placeholder="Search students...">
    </div>
</div>

<div class="table-card">
<table>
<thead>
<tr>
<th>Id</th>
<th>Student</th>
<th>Email</th>
<th>Department</th>
<th>Year</th>
<th>Actions</th>
</tr>
</thead>
<tbody>

<%
try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root","root"
    );

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(
        "SELECT student_id,name,email,department,year FROM student WHERE department='"+dname+"'"
    );

    int count=1;

    while(rs.next()){
        int id=rs.getInt("student_id");
        String name=rs.getString("name");
        String email=rs.getString("email");
        String dept=rs.getString("department");
        String year=rs.getString("year");

        String initial=name.substring(0,1).toUpperCase();
        String avatarClass="av"+((count%5)+1);
%>

<tr>
<td><%=count%></td>
<td>
<div class="avatar-wrap">
<div class="avatar <%=avatarClass%>"><%=initial%></div>
<span><%=name%></span>
</div>
</td>
<td><%=email%></td>
<td><span class="badge"><%=dept%></span></td>
<td><%=year%></td>
<td>
<a href="edit_student.jsp?id=<%=id%>" class="edit-btn">
<i class="fa fa-edit"></i>
</a>
</td>
</tr>

<%
count++;
}
conn.close();
}catch(Exception e){
out.println(e.getMessage());
}
%>

</tbody>
</table>
</div>

<script>
document.getElementById("searchInput").addEventListener("keyup", function(){
    const filter=this.value.toLowerCase();
    document.querySelectorAll("tbody tr").forEach(row=>{
        row.style.display=row.textContent.toLowerCase().includes(filter)?"":"none";
    });
});
</script>

</body>
</html>