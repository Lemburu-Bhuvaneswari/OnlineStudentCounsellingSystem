<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = (String) session.getAttribute("username");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}

String sessionDate = null;
String sessionTime = null;
String venue = null;
String problem = null;

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT session_date, session_time, venue, problem " +
        "FROM counselling_sessions " +
        "WHERE student_roll=? AND status='Pending' " +
        "ORDER BY session_date ASC LIMIT 1"
    );

    ps.setString(1, username);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        sessionDate = rs.getString("session_date");
        sessionTime = rs.getString("session_time");
        venue = rs.getString("venue");
        problem = rs.getString("problem");
    }

    rs.close();
    ps.close();
    con.close();

}catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Upcoming Sessions</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:transparent;
    padding:10px;
}

.wrapper{
    background:linear-gradient(135deg,#ff0080,#ff4da6);
    border-radius:24px;
    padding:28px;
    color:white;
    box-shadow:0 15px 35px rgba(236,72,153,.25);
}

.title{
    font-size:24px;
    font-weight:700;
    margin-bottom:22px;
}

.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:18px;
}

.box{
    background:rgba(255,255,255,.16);
    padding:20px;
    border-radius:18px;
    backdrop-filter:blur(10px);
}

.label{
    font-size:13px;
    opacity:.9;
    margin-bottom:6px;
}

.value{
    font-size:17px;
    font-weight:600;
}

.empty{
    text-align:center;
    padding:50px 20px;
    font-size:20px;
    font-weight:600;
    opacity:.95;
}
</style>
</head>
<body>

<div class="wrapper">

<% if(sessionDate != null){ %>

    <div class="title">
        <i class="fa-solid fa-calendar-check"></i> Upcoming Session
    </div>

    <div class="grid">

        <div class="box">
            <div class="label">Session Date</div>
            <div class="value"><%= sessionDate %></div>
        </div>

        <div class="box">
            <div class="label">Session Time</div>
            <div class="value"><%= sessionTime %></div>
        </div>

        <div class="box">
            <div class="label">Venue</div>
            <div class="value"><%= venue %></div>
        </div>

        <div class="box">
            <div class="label">Session Topic</div>
            <div class="value"><%= problem %></div>
        </div>

    </div>

<% } else { %>

    <div class="empty">
        <i class="fa-solid fa-calendar-xmark"></i><br><br>
        No Upcoming Sessions Scheduled
    </div>

<% } %>

</div>

</body>
</html>