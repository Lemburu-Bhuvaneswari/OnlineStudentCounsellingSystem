<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = (String) session.getAttribute("username");
String dname = (String) session.getAttribute("dname");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Unassigned Students</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:transparent;
    padding:18px;
}

.container-box{
    background:#f8fafc;
    border-radius:28px;
    padding:28px;
    min-height:calc(100vh - 40px);
    border:1px solid #e2e8f0;
}

.page-title{
    font-size:2.1rem;
    font-weight:700;
    color:#0f172a;
}

.page-subtitle{
    color:#64748b;
    margin-top:6px;
    font-size:14px;
}

.search-box{
    margin:20px 0;
}

.search-box input{
    width:100%;
    padding:13px 16px;
    border:1px solid #dbe2ea;
    border-radius:14px;
    font-size:14px;
    outline:none;
}

.card-box{
    background:#fff;
    border-radius:20px;
    padding:14px;
    box-shadow:0 6px 20px rgba(0,0,0,.04);
}

.table-wrapper{
    overflow:auto;
    border-radius:14px;
}

table{
    width:100%;
    border-collapse:separate;
    border-spacing:0;
    min-width:900px;
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
tbody td{
    padding:14px 16px;
    font-size:14px;
    color:#334155;
    border-bottom:1px solid #eef2f7;
}

tbody tr:hover td{
    background:#f8fafc;
}

.assign-btn{
    border:none;
    padding:7px 14px;
    border-radius:8px;
    background:linear-gradient(90deg,#7c3aed,#3b82f6);
    color:#fff;
    font-size:12px;
    cursor:pointer;
}
</style>
</head>
<body>

<div class="container-box">

    <h2 class="page-title">Counselling Management</h2>
    <p class="page-subtitle">Students waiting for counselor assignment</p>

    <div class="search-box">
        <input type="text" id="searchInput" placeholder="Search by name, roll number, email...">
    </div>

    <div class="card-box">
        <div class="table-wrapper">
            <table id="studentsTable">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Name</th>
                        <th>Roll No</th>
                        <th>Email</th>
                        <th>Department</th>
                        <th>Year</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                <%
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/student_counselling","root","root");

                    PreparedStatement ps = con.prepareStatement(
                        "SELECT student_id,name,rollno,email,department,year " +
                        "FROM student " +
                        "WHERE (assigned_staff IS NULL OR assigned_staff='') " +
                        "AND department=?"
                    );

                    ps.setString(1,dname);
                    ResultSet rs = ps.executeQuery();

                    int count=1;

                    while(rs.next()){
                %>

                    <tr>
                        <td><%=count++%></td>
                        <td><%=rs.getString("name")%></td>
                        <td><%=rs.getString("rollno")%></td>
                        <td><%=rs.getString("email")%></td>
                        <td><%=rs.getString("department")%></td>
                        <td><%=rs.getString("year")%></td>
                        <td>
                            <button class="assign-btn"
                                onclick="goAssign('<%=rs.getString("rollno")%>')">
                                Assign Staff
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
                        <td colspan="7">Error: <%=e.getMessage()%></td>
                    </tr>

                <%
                }
                %>

                </tbody>
            </table>
        </div>
    </div>

</div>

<script>
document.getElementById("searchInput").addEventListener("keyup", function(){
    let filter = this.value.toLowerCase();
    document.querySelectorAll("#studentsTable tbody tr").forEach(row=>{
        row.style.display = row.textContent.toLowerCase().includes(filter) ? "" : "none";
    });
});

function goAssign(rollno){
    parent.loadPage('assign_staff.jsp?rollno=' + encodeURIComponent(rollno));
}
</script>

</body>
</html>