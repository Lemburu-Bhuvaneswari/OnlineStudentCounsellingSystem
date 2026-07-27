<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = (String) session.getAttribute("username");
if(username == null){
    response.sendRedirect("index.jsp");
    return;
}

String counsellorName = "--";

int completedSessions = 0;
int scheduledSessions = 0;
int pendingRequests = 0;
int hodResolved = 0;

String nextDate = "--";
String nextTime = "--";
String nextVenue = "--";

try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    // Assigned Staff
    PreparedStatement ps1 = con.prepareStatement(
        "SELECT st.name FROM student s " +
        "LEFT JOIN staff st ON s.assigned_staff=st.email " +
        "WHERE s.rollno=?"
    );
    ps1.setString(1, username);
    ResultSet rs1 = ps1.executeQuery();
    if(rs1.next()) counsellorName = rs1.getString(1);

    // Completed Sessions
    PreparedStatement ps2 = con.prepareStatement(
        "SELECT COUNT(*) FROM counselling_sessions " +
        "WHERE student_roll=? AND status='Completed'"
    );
    ps2.setString(1, username);
    ResultSet rs2 = ps2.executeQuery();
    if(rs2.next()) completedSessions = rs2.getInt(1);

    // Scheduled Sessions
    PreparedStatement ps3 = con.prepareStatement(
        "SELECT COUNT(*) FROM counselling_sessions " +
        "WHERE student_roll=? AND status='Pending'"
    );
    ps3.setString(1, username);
    ResultSet rs3 = ps3.executeQuery();
    if(rs3.next()) scheduledSessions = rs3.getInt(1);

    // Pending Requests
    PreparedStatement ps4 = con.prepareStatement(
        "SELECT COUNT(*) FROM counselling_request " +
        "WHERE student_roll=? AND status='Pending'"
    );
    ps4.setString(1, username);
    ResultSet rs4 = ps4.executeQuery();
    if(rs4.next()) pendingRequests = rs4.getInt(1);

    // HOD Resolved
    PreparedStatement ps5 = con.prepareStatement(
        "SELECT COUNT(*) FROM counselling_request " +
        "WHERE student_roll=? AND " +
        "(status='Resolved by HOD' OR resolved_by IS NOT NULL)"
    );
    ps5.setString(1, username);
    ResultSet rs5 = ps5.executeQuery();
    if(rs5.next()) hodResolved = rs5.getInt(1);

    // Upcoming Session
    PreparedStatement ps6 = con.prepareStatement(
        "SELECT session_date, session_time, venue " +
        "FROM counselling_sessions " +
        "WHERE student_roll=? AND status='Pending' " +
        "ORDER BY session_date ASC LIMIT 1"
    );
    ps6.setString(1, username);
    ResultSet rs6 = ps6.executeQuery();

    if(rs6.next()){
        nextDate = rs6.getString("session_date");
        nextTime = rs6.getString("session_time");
        nextVenue = rs6.getString("venue");
    }

    con.close();

}catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Student Dashboard</title>

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

h2{
    font-size:24px;
    font-weight:700;
    color:#111827;
    margin-bottom:24px;
}

.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:22px;
    margin-bottom:28px;
}

.card{
    background:#fff;
    border-radius:22px;
    padding:28px 24px;
    text-align:center;
    border:1px solid #f5d0fe;
    box-shadow:0 10px 25px rgba(236,72,153,.08);
    transition:.3s;
}

.card:hover{
    transform:translateY(-5px);
    box-shadow:0 16px 30px rgba(236,72,153,.14);
}

.icon{
    width:65px;
    height:65px;
    margin:auto auto 16px;
    border-radius:18px;
    display:flex;
    align-items:center;
    justify-content:center;
    color:#fff;
    font-size:24px;
}

.c1{background:#3b82f6;}
.c2{background:#f59e0b;}
.c3{background:#8b5cf6;}
.c4{background:#22c55e;}
.c5{background:#ef4444;}

.card-title{
    font-size:16px;
    font-weight:600;
    color:#374151;
    margin-bottom:8px;
}

.card-value{
    font-size:28px;
    font-weight:700;
    color:#111827;
}

.upcoming-card{
    background:linear-gradient(135deg,#ff0080,#ff4da6);
    color:white;
    border-radius:24px;
    padding:28px;
    box-shadow:0 15px 35px rgba(236,72,153,.25);
}

.upcoming-title{
    font-size:22px;
    font-weight:700;
    margin-bottom:18px;
}

.upcoming-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(180px,1fr));
    gap:18px;
}

.upcoming-item{
    background:rgba(255,255,255,.18);
    padding:18px;
    border-radius:16px;
}

.upcoming-item span{
    display:block;
    font-size:13px;
    opacity:.9;
    margin-bottom:4px;
}

.upcoming-item strong{
    font-size:16px;
    font-weight:600;
}
</style>
</head>
<body>

<h2>Dashboard</h2>

<div class="grid">

    <div class="card">
        <div class="icon c1"><i class="fa-solid fa-user-group"></i></div>
        <div class="card-title">My Counsellor</div>
        <div class="card-value"><%= counsellorName %></div>
    </div>

    <div class="card">
        <div class="icon c2"><i class="fa-solid fa-file-circle-question"></i></div>
        <div class="card-title">Pending Requests</div>
        <div class="card-value"><%= pendingRequests %></div>
    </div>

    <div class="card">
        <div class="icon c3"><i class="fa-solid fa-calendar-check"></i></div>
        <div class="card-title">Scheduled Sessions</div>
        <div class="card-value"><%= scheduledSessions %></div>
    </div>

    <div class="card">
        <div class="icon c4"><i class="fa-solid fa-circle-check"></i></div>
        <div class="card-title">Completed Sessions</div>
        <div class="card-value"><%= completedSessions %></div>
    </div>

    <div class="card">
        <div class="icon c5"><i class="fa-solid fa-user-shield"></i></div>
        <div class="card-title">Resolved by HOD</div>
        <div class="card-value"><%= hodResolved %></div>
    </div>

</div>



</body>
</html>