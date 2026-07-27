<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String dept_name=request.getParameter("dept_name");

boolean status=false;
String message="";

try{

    Class.forName("com.mysql.jdbc.Driver");

    Connection con=DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/student_counselling","root","root");

    PreparedStatement ps=con.prepareStatement(
    "INSERT INTO department(dept_name) VALUES(?)");

    ps.setString(1,dept_name);

    int i=ps.executeUpdate();

    if(i>0){
        status=true;
        message="Department Added Successfully!";
    }else{
        message="Failed to Add Department!";
    }

}catch(Exception e){
    message="Error : " + e.getMessage();
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Department Status</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    background:linear-gradient(135deg,#2563eb,#06b6d4);
    font-family:'Poppins',sans-serif;
}

.result-card{
    width:430px;
    background:rgba(255,255,255,0.95);
    backdrop-filter:blur(16px);
    padding:42px 35px;
    border-radius:24px;
    text-align:center;
    box-shadow:0 20px 40px rgba(0,0,0,0.18);
    animation:fadeIn .4s ease;
}

.icon{
    font-size:60px;
    margin-bottom:18px;
}

.success{
    color:#16a34a;
}

.error{
    color:#dc2626;
}

.result-title{
    font-size:24px;
    font-weight:700;
    margin-bottom:8px;
}

.result-msg{
    font-size:15px;
    color:#475569;
    margin-bottom:28px;
}

.back-btn{
    background:linear-gradient(135deg,#2563eb,#06b6d4);
    color:white;
    border:none;
    padding:12px 28px;
    border-radius:50px;
    font-weight:600;
    text-decoration:none;
    display:inline-block;
    transition:.3s;
}

.back-btn:hover{
    transform:translateY(-2px);
    color:white;
    box-shadow:0 10px 20px rgba(37,99,235,.3);
}

@keyframes fadeIn{
    from{
        opacity:0;
        transform:translateY(20px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}
</style>

</head>
<body>

<div class="result-card">

    <% if(status){ %>

        <div class="icon success">
            <i class="fa fa-circle-check"></i>
        </div>

        <div class="result-title text-success">
            Success
        </div>

        <div class="result-msg">
            <%=message%>
        </div>

    <% } else { %>

        <div class="icon error">
            <i class="fa fa-circle-xmark"></i>
        </div>

        <div class="result-title text-danger">
            Failed
        </div>

        <div class="result-msg">
            <%=message%>
        </div>

    <% } %>

    <a href="add_department.jsp" class="back-btn">
        <i class="fa fa-arrow-left"></i> Back
    </a>

</div>

</body>
</html>