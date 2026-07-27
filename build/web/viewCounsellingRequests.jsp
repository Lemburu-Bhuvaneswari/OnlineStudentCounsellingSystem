<!--viewCounsellingRequests.jsp-->
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String usertype = (String) session.getAttribute("usertype");
String dname = (String) session.getAttribute("dname");
String username = (String) session.getAttribute("username");

if(usertype == null || !usertype.equals("staff")){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Counselling Requests</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:transparent;
    padding:10px;
}

.wrapper{
    background:#ffffff;
    border-radius:24px;
    padding:28px;
    border:1px solid #dbeafe;
    box-shadow:0 10px 30px rgba(0,0,0,0.05);
}

.page-title{
    display:flex;
    align-items:center;
    gap:14px;
    font-size:34px;
    font-weight:700;
    color:#0f172a;
    margin-bottom:28px;
}

.page-title i{
    color:#14b8a6;
}

.table-box{
    overflow-x:auto;
    border-radius:20px;
    border:1px solid #e2e8f0;
}

table{
    width:100%;
    border-collapse:collapse;
}

thead{
    background:linear-gradient(90deg,#14b8a6,#0f766e);
    color:white;
}

th{
    padding:18px 16px;
    text-align:left;
    font-size:15px;
    font-weight:600;
}

td{
    padding:18px 16px;
    border-bottom:1px solid #edf2f7;
    font-size:15px;
    color:#334155;
    vertical-align:middle;
}

tbody tr:hover{
    background:#f0fdfa;
}

.badge{
    padding:8px 14px;
    border-radius:999px;
    font-size:13px;
    font-weight:600;
    display:inline-block;
}

.pending{
    background:#fef3c7;
    color:#92400e;
}

.completed{
    background:#dcfce7;
    color:#166534;
}

.escalated{
    background:#fee2e2;
    color:#b91c1c;
}

.action-btn{
    padding:10px 18px;
    border:none;
    border-radius:12px;
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    color:white;
    text-decoration:none;
    font-size:14px;
    font-weight:600;
    display:inline-flex;
    align-items:center;
    gap:8px;
    transition:.3s;
}

.action-btn:hover{
    transform:translateY(-2px);
    box-shadow:0 8px 18px rgba(20,184,166,.25);
    color:white;
}

.no-action{
    color:#94a3b8;
    font-size:18px;
    font-weight:600;
}
</style>
</head>
<body>

<div class="wrapper">

    <div class="page-title">
        <i class="fa fa-list-check"></i>
        Student Counselling Requests
    </div>

    <div class="table-box">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Student Roll</th>
                    <th>Issue / Request</th>
                    <th>Request Date</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>

<%
try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT r.request_id, r.student_roll, r.issue, r.request_date, r.status " +
        "FROM counselling_request r " +
        "JOIN student s ON r.student_roll = s.rollno " +
        "WHERE s.department=? AND s.assigned_staff=? " +
        "ORDER BY r.request_date DESC"
    );

    ps.setString(1, dname);
    ps.setString(2, username);

    ResultSet rs = ps.executeQuery();

    int count = 1;

    while(rs.next()){

        int requestId = rs.getInt("request_id");
        String studentRoll = rs.getString("student_roll");
        String issue = rs.getString("issue");
        String requestDate = rs.getString("request_date");
        String status = rs.getString("status");
%>

<tr>
    <td><%=count++%></td>
    <td><%=studentRoll%></td>
    <td><%=issue%></td>
    <td><%=requestDate%></td>

    <td>
        <% if("Pending".equalsIgnoreCase(status)){ %>
            <span class="badge pending">Pending</span>

        <% } else if("Completed".equalsIgnoreCase(status)){ %>
            <span class="badge completed">Completed</span>

        <% } else if("Escalated".equalsIgnoreCase(status)){ %>
            <span class="badge escalated">Escalated</span>

        <% } else { %>
            <span class="badge completed"><%=status%></span>
        <% } %>
    </td>

    <td>
        <% if("Pending".equalsIgnoreCase(status)){ %>

            <a href="process_request.jsp?id=<%=requestId%>" class="action-btn">
                <i class="fa fa-circle-check"></i>
                Process Request
            </a>

        <% } else { %>

            <span class="no-action">—</span>

        <% } %>
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
    <td colspan="6" style="color:red;">Error: <%=e.getMessage()%></td>
</tr>

<%
}
%>

            </tbody>
        </table>
    </div>

</div>

</body>
</html>
