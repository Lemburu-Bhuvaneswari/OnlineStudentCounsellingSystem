<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String rollno = request.getParameter("rollno");
String password = request.getParameter("password");

boolean status = false;
String message = "";

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM student WHERE rollno=? AND password=?"
    );

    ps.setString(1, rollno);
    ps.setString(2, password);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        status = true;
        session.setAttribute("username", rollno);
        session.setAttribute("usertype", "student");
    }else{
        message = "Invalid Roll Number or Password!";
    }

    con.close();

}catch(Exception e){
    message = "Error: " + e.getMessage();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Student Login Status</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

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
    background:linear-gradient(135deg,#f8b4d9,#ff0080);
    overflow:hidden;
    position:relative;
}

body::before,
body::after{
    content:"";
    position:absolute;
    border-radius:50%;
    filter:blur(90px);
    opacity:.35;
}

body::before{
    width:280px;
    height:280px;
    background:#fff;
    top:-80px;
    left:-60px;
}

body::after{
    width:320px;
    height:320px;
    background:#ff69b4;
    bottom:-100px;
    right:-70px;
}

.result-card{
    position:relative;
    z-index:2;
    width:420px;
    background:rgba(255,255,255,0.95);
    backdrop-filter:blur(18px);
    padding:38px;
    border-radius:28px;
    text-align:center;
    box-shadow:
        0 25px 50px rgba(0,0,0,.15),
        inset 0 1px 0 rgba(255,255,255,.5);
}

.status-icon{
    width:85px;
    height:85px;
    margin:0 auto 18px;
    border-radius:22px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:34px;
    color:#fff;
}

.success-box{
    background:linear-gradient(135deg,#22c55e,#16a34a);
    box-shadow:0 12px 28px rgba(34,197,94,.35);
}

.error-box{
    background:linear-gradient(135deg,#ef4444,#dc2626);
    box-shadow:0 12px 28px rgba(239,68,68,.35);
}

h2{
    font-size:28px;
    font-weight:700;
    margin-bottom:10px;
    color:#0f172a;
}

.msg{
    font-size:15px;
    color:#64748b;
    margin-bottom:25px;
}

.btn-back{
    display:inline-block;
    padding:12px 28px;
    border-radius:14px;
    background:linear-gradient(90deg,#ff2d95,#ff006a);
    color:#fff;
    text-decoration:none;
    font-weight:600;
    transition:.3s;
}

.btn-back:hover{
    transform:translateY(-2px);
    box-shadow:0 12px 25px rgba(255,0,106,.25);
}

</style>
</head>
<body>

<div class="result-card">

<%
if(status){
%>

    <div class="status-icon success-box">
        <i class="fa-solid fa-circle-check"></i>
    </div>

    <h2>Login Successful!</h2>
    <div class="msg">Redirecting to your dashboard...</div>

    <script>
        setTimeout(function(){
            window.location.href="studenthome.jsp";
        },1200);
    </script>

<%
}else{
%>

    <div class="status-icon error-box">
        <i class="fa-solid fa-circle-xmark"></i>
    </div>

    <h2>Login Failed</h2>
    <div class="msg"><%=message%></div>

    <a href="student_login.jsp" class="btn-back">
        <i class="fa-solid fa-arrow-left"></i> Back to Login
    </a>

<%
}
%>

</div>

</body>
</html>