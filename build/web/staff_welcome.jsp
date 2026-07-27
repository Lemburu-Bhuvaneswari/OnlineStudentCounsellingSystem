<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = (String)session.getAttribute("username");
String name = (String)session.getAttribute("name");

int assignedStudents = 0;
int completedSessions = 0;
int pendingSessions = 0;
int totalCounselling = 0;

try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root");

    PreparedStatement ps1 = con.prepareStatement(
        "SELECT COUNT(*) FROM student WHERE assigned_staff=?");
    ps1.setString(1, username);
    ResultSet rs1 = ps1.executeQuery();
    if(rs1.next()) assignedStudents = rs1.getInt(1);

    PreparedStatement ps2 = con.prepareStatement(
        "SELECT COUNT(*) FROM counselling_sessions WHERE staff_id=? AND status='Completed'");
    ps2.setString(1, username);
    ResultSet rs2 = ps2.executeQuery();
    if(rs2.next()) completedSessions = rs2.getInt(1);

    PreparedStatement ps3 = con.prepareStatement(
        "SELECT COUNT(*) FROM counselling_sessions WHERE staff_id=? AND status='Pending'");
    ps3.setString(1, username);
    ResultSet rs3 = ps3.executeQuery();
    if(rs3.next()) pendingSessions = rs3.getInt(1);

    totalCounselling = completedSessions + pendingSessions;

    con.close();

}catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Staff Welcome</title>

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
    padding:8px;
}

/* Welcome Banner */
.welcome-banner{
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    color:white;
    padding:26px 28px;
    border-radius:22px;
    margin-bottom:26px;
    box-shadow:0 12px 30px rgba(20,184,166,.22);
}

.welcome-banner h2{
    font-size:28px;
    font-weight:700;
    margin-bottom:6px;
}

.welcome-banner p{
    opacity:.95;
    font-size:15px;
}

/* Stats Grid */
.stats-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(230px,1fr));
    gap:22px;
}

/* Stat Card */
.stat-card{
    background:#fff;
    border-radius:22px;
    padding:26px;
    border:1px solid #e5e7eb;
    box-shadow:0 10px 25px rgba(0,0,0,.06);
    transition:.3s;
}

.stat-card:hover{
    transform:translateY(-6px);
}

.icon-box{
    width:62px;
    height:62px;
    border-radius:18px;
    display:flex;
    align-items:center;
    justify-content:center;
    color:#fff;
    font-size:24px;
    margin-bottom:16px;
}

.bg1{ background:#3b82f6; }
.bg2{ background:#10b981; }
.bg3{ background:#f59e0b; }
.bg4{ background:#ef4444; }

.stat-title{
    font-size:15px;
    color:#64748b;
    margin-bottom:8px;
}

.stat-value{
    font-size:30px;
    font-weight:700;
    color:#0f172a;
}
</style>
</head>
<body>

<div class="welcome-banner">
    <h2>Welcome, <%=name%></h2>
    <p>Manage your assigned students and counselling activities efficiently.</p>
</div>

<div class="stats-grid">

    <div class="stat-card">
        <div class="icon-box bg1">
            <i class="fa fa-users"></i>
        </div>
        <div class="stat-title">Assigned Students</div>
        <div class="stat-value"><%=assignedStudents%></div>
    </div>

    <div class="stat-card">
        <div class="icon-box bg2">
            <i class="fa fa-check-circle"></i>
        </div>
        <div class="stat-title">Completed Sessions</div>
        <div class="stat-value"><%=completedSessions%></div>
    </div>

    <div class="stat-card">
        <div class="icon-box bg3">
            <i class="fa fa-hourglass-half"></i>
        </div>
        <div class="stat-title">Pending Sessions</div>
        <div class="stat-value"><%=pendingSessions%></div>
    </div>

    <div class="stat-card">
        <div class="icon-box bg4">
            <i class="fa fa-comments"></i>
        </div>
        <div class="stat-title">Total Counselling</div>
        <div class="stat-value"><%=totalCounselling%></div>
    </div>

</div>

</body>
</html>