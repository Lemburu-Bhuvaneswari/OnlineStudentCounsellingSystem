<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Add HOD</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:transparent;
}
.page-title{
    font-size:30px;
    font-weight:700;
    margin-bottom:28px;
    color:#0f172a;
}
.form-wrapper{
    display:flex;
    justify-content:center;
}
.form-card{
    width:100%;
    max-width:620px;
    background:#ffffff;
    padding:32px;
    border-radius:24px;
    box-shadow:0 10px 30px rgba(15,23,42,0.08);
    border:1px solid #eef2ff;
}
.form-label{
    font-weight:600;
    font-size:14px;
    margin-bottom:8px;
    color:#334155;
}
.form-control,.form-select{
    height:50px;
    border-radius:14px;
    border:1.5px solid #dbeafe;
    padding:0 16px;
    font-size:14px;
}
.form-control:focus,.form-select:focus{
    border-color:#2563eb;
    box-shadow:0 0 0 4px rgba(37,99,235,0.08);
}
.btn-submit{
    background:linear-gradient(135deg,#2563eb,#06b6d4);
    border:none;
    color:#fff;
    padding:12px 34px;
    border-radius:50px;
    font-weight:600;
    font-size:15px;
}
.btn-submit:hover{
    transform:translateY(-1px);
}
</style>
</head>
<body>

<div class="container-fluid">

<h4 class="page-title">
<i class="fa fa-user-tie"></i> Add HOD
</h4>

<div class="form-wrapper">
<div class="form-card">

<form action="add_hod_action.jsp" method="post">

<div class="mb-3">
<label class="form-label">HOD Name</label>
<input type="text" name="name" class="form-control"
pattern="[A-Za-z ]{3,50}" required>
</div>

<div class="mb-3">
<label class="form-label">Department</label>
<select name="department" class="form-select" required>
<option value="">Select Department</option>

<%
try{
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/student_counselling","root","root");
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("SELECT * FROM department");
while(rs.next()){
%>
<option value="<%=rs.getString("dept_name")%>">
<%=rs.getString("dept_name")%>
</option>
<% }}catch(Exception e){out.println(e);} %>

</select>
</div>

<div class="mb-3">
<label class="form-label">Email</label>
<input type="email" name="email" class="form-control" required>
</div>

<div class="mb-3">
<label class="form-label">Phone</label>
<input type="text" name="phone" class="form-control"
maxlength="10"
pattern="[0-9]{10}"
oninput="this.value=this.value.replace(/[^0-9]/g,'')"
required>
</div>

<div class="mb-4">
<label class="form-label">Password</label>
<input type="password" name="password" class="form-control"
minlength="6" required>
</div>

<div class="text-center">
<button type="submit" class="btn btn-submit">
<i class="fa fa-save"></i> Add HOD
</button>
</div>

</form>
</div>
</div>
</div>

</body>
</html>