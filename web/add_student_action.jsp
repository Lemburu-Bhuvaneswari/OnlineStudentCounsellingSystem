<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String name=request.getParameter("name");
String rollno=request.getParameter("rollno");
String department=request.getParameter("department");
String year=request.getParameter("year");
String email=request.getParameter("email");
String phone=request.getParameter("phone");
String password=request.getParameter("password");

boolean status=false;
String message="";

try{

Class.forName("com.mysql.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/student_counselling","root","root");

PreparedStatement ps=con.prepareStatement(
"INSERT INTO student(name,rollno,department,year,email,phone,password) VALUES(?,?,?,?,?,?,?)");

ps.setString(1,name);
ps.setString(2,rollno);
ps.setString(3,department);
ps.setString(4,year);
ps.setString(5,email);
ps.setString(6,phone);
ps.setString(7,password);

int i=ps.executeUpdate();

if(i>0){
    status=true;
    message="Student Added Successfully!";
}else{
    message="Failed to Add Student!";
}

}catch(Exception e){
    message="Error : "+e.getMessage();
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Add Student Status</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    font-family:Poppins;
    background:linear-gradient(135deg,#4facfe,#00f2fe);
    height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
}
.result-card{
    background:#fff;
    padding:40px;
    border-radius:20px;
    width:420px;
    text-align:center;
    box-shadow:0 10px 30px rgba(0,0,0,.25);
}
.icon{
    font-size:58px;
    margin-bottom:15px;
}
.success{color:#16a34a;}
.error{color:#dc2626;}
.btn-back{
    border-radius:30px;
    padding:10px 28px;
}
</style>
</head>
<body>

<div class="result-card">

<% if(status){ %>
    <div class="icon success">
        <i class="fa fa-circle-check"></i>
    </div>
    <h4 class="text-success"><%=message%></h4>
<% } else { %>
    <div class="icon error">
        <i class="fa fa-circle-xmark"></i>
    </div>
    <h4 class="text-danger"><%=message%></h4>
<% } %>

<div class="mt-4">
<a href="add_student.jsp" class="btn btn-primary btn-back">
<i class="fa fa-arrow-left"></i> Back
</a>
</div>

</div>

</body>
</html>