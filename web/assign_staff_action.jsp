<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String staffEmail = request.getParameter("staff_email");
String startRoll = request.getParameter("start_rollno");
String endRoll = request.getParameter("end_rollno");

boolean status=false;
String message="";

try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root");

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO staff_assignment(staff_id, roll_start, roll_end) VALUES(?,?,?)"
    );
    ps.setString(1, staffEmail);
    ps.setString(2, startRoll);
    ps.setString(3, endRoll);

    int i = ps.executeUpdate();

    if(i>0){
        status = true;

        PreparedStatement ps2 = con.prepareStatement(
            "UPDATE student SET assigned_staff=? WHERE rollno BETWEEN ? AND ?"
        );
        ps2.setString(1, staffEmail);
        ps2.setString(2, startRoll);
        ps2.setString(3, endRoll);

        ps2.executeUpdate();
    } else {
        message="Assignment failed!";
    }

    con.close();

}catch(Exception e){
    message="Error: "+e.getMessage();
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Assignment Status</title>

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
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    background:linear-gradient(135deg,#f3d9fa,#dbeafe);
    padding:20px;
}

.status-card{
    width:100%;
    max-width:460px;
    background:rgba(255,255,255,0.92);
    border-radius:28px;
    padding:42px 36px;
    text-align:center;
    box-shadow:0 20px 50px rgba(15,23,42,.12);
    border:1px solid rgba(255,255,255,.7);
}

.status-icon{
    width:90px;
    height:90px;
    border-radius:50%;
    margin:0 auto 22px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:38px;
}

.success{
    background:#dcfce7;
    color:#16a34a;
}

.error{
    background:#fee2e2;
    color:#dc2626;
}

.status-title{
    font-size:28px;
    font-weight:700;
    color:#0f172a;
    margin-bottom:10px;
}

.status-message{
    font-size:15px;
    color:#64748b;
    margin-bottom:28px;
}

.action-btn{
    display:inline-block;
    padding:14px 28px;
    border-radius:14px;
    background:linear-gradient(90deg,#7c3aed,#3b82f6);
    color:#fff;
    text-decoration:none;
    font-weight:600;
    transition:.25s;
}

.action-btn:hover{
    transform:translateY(-2px);
    box-shadow:0 10px 20px rgba(124,58,237,.25);
}
</style>
</head>
<body>

<div class="status-card">

<% if(status){ %>

    <div class="status-icon success">
        <i class="fa fa-check"></i>
    </div>

    <div class="status-title">Assignment Successful</div>
    <div class="status-message">
        Staff has been assigned to the selected students successfully.
    </div>

    <script>
        setTimeout(()=>{
            window.top.location.href="hodhome.jsp";
        },1500);
    </script>

<% } else { %>

    <div class="status-icon error">
        <i class="fa fa-times"></i>
    </div>

    <div class="status-title">Assignment Failed</div>
    <div class="status-message">
        <%= message %>
    </div>

    <a href="assign_staff.jsp" class="action-btn">
        Back to Assign Staff
    </a>

<% } %>

</div>

</body>
</html>