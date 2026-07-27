
<!--view_counselling_status.jsp-->
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

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
<title>Counselling Status</title>

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

.status-container{
    background:#f8fafc;
    border-radius:28px;
    padding:28px;
    min-height:calc(100vh - 40px);
    border:1px solid #e2e8f0;
}

.top-bar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:22px;
    gap:15px;
    flex-wrap:wrap;
}

.page-title{
    font-size:2.1rem;
    font-weight:700;
    color:#0f172a;
}

.search-box{
    width:340px;
}

.search-box input{
    width:100%;
    padding:13px 16px;
    border:1px solid #dbe3ef;
    border-radius:14px;
    outline:none;
    font-size:14px;
}

.table-card{
    background:#fff;
    border-radius:20px;
    padding:14px;
    border:1px solid #edf2f7;
    box-shadow:0 6px 20px rgba(0,0,0,.04);
}

.table-wrapper{
    max-height:70vh;
    overflow:auto;
    border-radius:14px;
}

table{
    width:100%;
    border-collapse:separate;
    border-spacing:0;
    min-width:850px;
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

.badge{
    padding:6px 12px;
    border-radius:20px;
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

.inprogress{
    background:#dbeafe;
    color:#2563eb;
}
</style>
</head>
<body>

<div class="status-container">

    <div class="top-bar">
        <h2 class="page-title">Student Counselling Status</h2>

        <div class="search-box">
            <input type="text" id="searchInput" placeholder="Search by student or counsellor...">
        </div>
    </div>

    <div class="table-card">
        <div class="table-wrapper">
            <table id="statusTable">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Student Name</th>
                        <th>Email</th>
                        <th>Counsellor</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>

                <tbody>
                <%
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/student_counselling","root","root");

                    Statement stmt = con.createStatement();

                    String sql =
                        "SELECT s.name AS student_name, s.email, c.staff_id, c.session_date, c.status " +
                        "FROM student s " +
                        "LEFT JOIN counselling_sessions c ON s.rollno = c.student_roll " +
                        "WHERE s.department='"+dname+"'";

                    ResultSet rs = stmt.executeQuery(sql);

                    int count = 1;

                    while(rs.next()){
                        String status = rs.getString("status");
                        String badgeClass = "pending";

                        if("Completed".equalsIgnoreCase(status))
                            badgeClass="completed";
                        else if("In-progress".equalsIgnoreCase(status))
                            badgeClass="inprogress";
                %>

                    <tr>
                        <td><%=count++%></td>
                        <td><%=rs.getString("student_name")%></td>
                        <td><%=rs.getString("email")%></td>
                        <td><%=rs.getString("staff_id")!=null?rs.getString("staff_id"):"-"%></td>
                        <td><%=rs.getString("session_date")!=null?rs.getString("session_date"):"-"%></td>
                        <td>
                            <span class="badge <%=badgeClass%>">
                                <%=status!=null?status:"Pending"%>
                            </span>
                        </td>
                    </tr>

                <%
                    }

                    rs.close();
                    stmt.close();
                    con.close();

                }catch(Exception e){
                %>
                    <tr>
                        <td colspan="6">Error: <%=e.getMessage()%></td>
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
    document.querySelectorAll("#statusTable tbody tr").forEach(row=>{
        row.style.display = row.textContent.toLowerCase().includes(filter) ? "" : "none";
    });
});
</script>

</body>
</html>