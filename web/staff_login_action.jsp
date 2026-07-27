<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

boolean status = false;
String message = "";

try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root");

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM staff WHERE email=? AND password=?"
    );
    ps.setString(1, email);
    ps.setString(2, password);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        status = true;
        session.setAttribute("username", email);
        session.setAttribute("usertype", "staff");
        session.setAttribute("name", rs.getString("name"));
        session.setAttribute("dname", rs.getString("department"));
    } else {
        message = "Invalid Email or Password!";
    }

    con.close();

} catch(Exception e){
    message = "Error: " + e.getMessage();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Staff Login Status</title>

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
    background:linear-gradient(135deg,#14b8a6,#0b6e69);
    position:relative;
    overflow:hidden;
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
    background:#ccfbf1;
    top:-80px;
    left:-60px;
}

body::after{
    width:320px;
    height:320px;
    background:#14b8a6;
    bottom:-100px;
    right:-70px;
}

.result-card{
    position:relative;
    z-index:2;
    width:400px;
    background:rgba(255,255,255,0.95);
    padding:38px;
    border-radius:28px;
    text-align:center;
    box-shadow:0 25px 50px rgba(0,0,0,.15);
}

.icon{
    font-size:60px;
    margin-bottom:18px;
}

.success{ color:#14b8a6; }
.error{ color:#ef4444; }

h4{
    font-size:24px;
    margin-bottom:20px;
    color:#0f172a;
}

.btn-back{
    display:inline-block;
    padding:12px 24px;
    border-radius:14px;
    background:linear-gradient(90deg,#14b8a6,#0d9488);
    color:white;
    text-decoration:none;
    font-weight:600;
    transition:.3s;
}

.btn-back:hover{
    transform:translateY(-2px);
    box-shadow:0 12px 24px rgba(20,184,166,.25);
}
</style>
</head>
<body>

<div class="result-card">

<%
if(status){
%>

    <div class="icon success">
        <i class="fa-solid fa-circle-check"></i>
    </div>

    <h4>Login Successful!</h4>

    <script>
        setTimeout(()=>{
            window.top.location.href="staffhome.jsp";
        },1000);
    </script>

<%
} else {
%>

    <div class="icon error">
        <i class="fa-solid fa-circle-xmark"></i>
    </div>

    <h4><%=message%></h4>

    <a href="staff_login.jsp" class="btn-back">
        <i class="fa-solid fa-arrow-left"></i> Back to Login
    </a>

<%
}
%>

</div>

</body>
</html>