<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
int departments=0, hods=0, staff=0, students=0;

try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    Statement st=con.createStatement();

    ResultSet rs=st.executeQuery("select count(*) from department");
    if(rs.next()) departments=rs.getInt(1);

    rs=st.executeQuery("select count(*) from hod");
    if(rs.next()) hods=rs.getInt(1);

    rs=st.executeQuery("select count(*) from staff");
    if(rs.next()) staff=rs.getInt(1);

    rs=st.executeQuery("select count(*) from student");
    if(rs.next()) students=rs.getInt(1);

}catch(Exception e){
    out.println(e);
}
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:transparent;
}

h2{
    margin-bottom:24px;
    font-size:24px;
    font-weight:700;
}

.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:24px;
}

.card{
    background:#fff;
    border-radius:18px;
    padding:28px;
    text-align:center;
    box-shadow:0 10px 25px rgba(0,0,0,.08);
    transition:.3s;
}

.card:hover{
    transform:translateY(-6px);
}

.icon{
    width:64px;
    height:64px;
    margin:auto;
    border-radius:16px;
    display:flex;
    align-items:center;
    justify-content:center;
    color:white;
    font-size:24px;
    margin-bottom:14px;
}

.c1{background:#3b82f6;}
.c2{background:#10b981;}
.c3{background:#f59e0b;}
.c4{background:#ef4444;}

.count{
    font-size:28px;
    font-weight:700;
}

.welcome-box{
    margin-top:32px;
    background:#fff;
    border-radius:20px;
    padding:35px;
    box-shadow:0 10px 25px rgba(0,0,0,.06);
    text-align:center;
}
</style>
</head>
<body>

<h2>Admin Dashboard Overview</h2>

<div class="grid">

    <div class="card">
        <div class="icon c1"><i class="fa fa-building"></i></div>
        <div class="count"><%=departments%></div>
        Total Departments
    </div>

    <div class="card">
        <div class="icon c2"><i class="fa fa-user-tie"></i></div>
        <div class="count"><%=hods%></div>
        Total HOD
    </div>

    <div class="card">
        <div class="icon c3"><i class="fa fa-users"></i></div>
        <div class="count"><%=staff%></div>
        Total Staff
    </div>

    <div class="card">
        <div class="icon c4"><i class="fa fa-user-graduate"></i></div>
        <div class="count"><%=students%></div>
        Total Students
    </div>

</div>

<div class="welcome-box">
    <h3>Welcome to Online Student Counselling System</h3>
    <p style="margin-top:15px;color:#64748b;">
        This dashboard allows the administrator to manage departments, HODs,
        staff counsellors, and students efficiently from one centralized panel.
    </p>
</div>

</body>
</html>