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
<title>View Counselling Sessions</title>

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

.main-card{
    background:#ffffff;
    border-radius:28px;
    padding:28px;
    box-shadow:0 8px 25px rgba(0,0,0,0.06);
    border:1px solid #d9f2ed;
}

.page-title{
    font-size:28px;
    font-weight:700;
    color:#0f172a;
    display:flex;
    align-items:center;
    gap:14px;
    margin-bottom:24px;
}

.page-title i{
    color:#14b8a6;
}

.table-wrap{
    overflow-x:auto;
    border-radius:22px;
}

table{
    width:100%;
    border-collapse:collapse;
    overflow:hidden;
    border-radius:20px;
}

thead{
    background:linear-gradient(135deg,#1fb6aa,#147d74);
    color:white;
}

thead th{
    padding:18px;
    font-size:15px;
    font-weight:600;
    text-align:left;
}

tbody tr{
    border-bottom:1px solid #edf2f7;
    transition:.25s;
}

tbody tr:hover{
    background:#f0fdfa;
}

tbody td{
    padding:18px;
    font-size:15px;
    color:#334155;
    vertical-align:middle;
}

.status-badge{
    padding:8px 16px;
    border-radius:30px;
    font-size:13px;
    font-weight:600;
}

.completed{
    background:#dcfce7;
    color:#15803d;
}

.scheduled{
    background:#dbeafe;
    color:#2563eb;
}

.done-text{
    color:#16a34a;
    font-weight:600;
}
</style>
</head>
<body>

<div class="main-card">

    <div class="page-title">
        <i class="fa-solid fa-calendar-check"></i>
        Counselling Sessions
    </div>

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>#</th>
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
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root");

    PreparedStatement ps = con.prepareStatement(
        "SELECT c.*, s.name " +
        "FROM counselling_sessions c " +
        "JOIN student s ON c.student_roll=s.rollno " +
        "WHERE c.staff_id=? " +
        "ORDER BY c.session_date DESC"
    );

    ps.setString(1, username);

    ResultSet rs = ps.executeQuery();

    int count = 1;

    while(rs.next()){

        String status = rs.getString("status");
        String time = rs.getString("session_time");
        String venue = rs.getString("venue");

        if(time == null || time.trim().isEmpty()) time = "—";
        if(venue == null || venue.trim().isEmpty()) venue = "—";
%>

                <tr>
                    <td><%=count++%></td>
                    <td><%=rs.getString("name")%></td>
                    <td><%=rs.getString("session_date")%></td>
                    <td><%=time%></td>
                    <td><%=venue%></td>
                    <td><%=rs.getString("problem")%></td>
                    <td>
                        <%= rs.getString("counselling_notes") == null ? "—" : rs.getString("counselling_notes") %>
                    </td>

                    <td>
                        <% if("Completed".equalsIgnoreCase(status)){ %>
                            <span class="status-badge completed">Completed</span>
                        <% } else { %>
                            <span class="status-badge scheduled">Scheduled</span>
                        <% } %>
                    </td>

                    <td>
                        <% if("Completed".equalsIgnoreCase(status)){ %>
                            <span class="done-text">Done</span>
                        <% } else { %>
                            <a href="complete_counselling.jsp?session_id=<%=rs.getInt("session_id")%>"
                               class="done-text">Complete</a>
                        <% } %>
                    </td>
                </tr>

<%
    }

    rs.close();
    ps.close();
    con.close();

}catch(Exception e){
    out.println("<tr><td colspan='9'>Error: "+e.getMessage()+"</td></tr>");
}
%>

            </tbody>
        </table>
    </div>
</div>

</body>
</html>