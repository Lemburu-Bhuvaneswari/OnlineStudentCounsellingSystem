<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = (String)session.getAttribute("username");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}

String name="", designation="", phone="", email="", department="";

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT name, designation, phone, email, department FROM staff WHERE email=?"
    );

    ps.setString(1, username);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        name = rs.getString("name");
        designation = rs.getString("designation");
        phone = rs.getString("phone");
        email = rs.getString("email");
        department = rs.getString("department");
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
<meta charset="UTF-8">
<title>Staff Profile</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:transparent;
    padding:30px;
}

.success-msg{
    max-width:950px;
    margin:0 auto 20px;
    background:#dcfce7;
    color:#166534;
    padding:14px 20px;
    border-radius:14px;
    font-weight:600;
    border:1px solid #bbf7d0;
}

.profile-card{
    max-width:950px;
    margin:auto;
    background:#ffffff;
    border-radius:28px;
    padding:40px;
    box-shadow:0 10px 30px rgba(0,0,0,.06);
    border:1px solid #e5e7eb;
}

.profile-header{
    display:flex;
    align-items:center;
    gap:18px;
    margin-bottom:32px;
}

.profile-icon{
    width:72px;
    height:72px;
    border-radius:20px;
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    display:flex;
    align-items:center;
    justify-content:center;
    color:#fff;
    font-size:28px;
    box-shadow:0 10px 25px rgba(20,184,166,.25);
}

.profile-title h2{
    font-size:32px;
    font-weight:700;
    color:#0f172a;
}

.profile-title p{
    color:#64748b;
    font-size:16px;
}

.profile-grid{
    display:grid;
    grid-template-columns:repeat(2,1fr);
    gap:22px;
}

.info-box{
    background:#f8fafc;
    border:1px solid #dbe2ea;
    border-radius:18px;
    padding:18px 20px;
}

.info-box.full{
    grid-column:span 2;
}

.label{
    font-size:13px;
    font-weight:700;
    color:#64748b;
    display:block;
    margin-bottom:8px;
    letter-spacing:.7px;
}

input{
    width:100%;
    border:none;
    outline:none;
    background:transparent;
    font-size:16px;
    font-weight:600;
    color:#0f172a;
}

input[readonly]{
    color:#64748b;
}

.profile-actions{
    margin-top:30px;
    display:flex;
    justify-content:center;
}

.btn-save{
    padding:14px 36px;
    border:none;
    border-radius:14px;
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    color:white;
    font-weight:600;
    font-size:15px;
    cursor:pointer;
    transition:.3s;
}

.btn-save:hover{
    transform:translateY(-2px);
    box-shadow:0 10px 20px rgba(20,184,166,.20);
}

@media(max-width:768px){
    .profile-grid{
        grid-template-columns:1fr;
    }

    .info-box.full{
        grid-column:span 1;
    }

    .profile-title h2{
        font-size:28px;
    }
}
</style>
</head>
<body>

<% if(request.getParameter("success") != null){ %>
<div class="success-msg">
    <i class="fa fa-circle-check"></i> Profile updated successfully!
</div>
<% } %>

<div class="profile-card">

    <div class="profile-header">
        <div class="profile-icon">
            <i class="fa fa-user"></i>
        </div>

        <div class="profile-title">
            <h2>My Profile</h2>
            <p>Manage your professional details</p>
        </div>
    </div>

    <form action="update_staff_profile.jsp" method="post" onsubmit="return validateProfileForm()">

        <div class="profile-grid">

            <div class="info-box">
                <span class="label">NAME</span>
                <input type="text" id="name" name="name" value="<%= name %>" required>
            </div>

            <div class="info-box">
                <span class="label">DESIGNATION</span>
                <input type="text" id="designation" name="designation" value="<%= designation %>" required>
            </div>

            <div class="info-box">
                <span class="label">PHONE</span>
                <input type="text" id="phone" name="phone" value="<%= phone %>" required>
            </div>

            <div class="info-box">
                <span class="label">EMAIL</span>
                <input type="text" value="<%= email %>" readonly>
            </div>

            <div class="info-box full">
                <span class="label">DEPARTMENT</span>
                <input type="text" value="<%= department %>" readonly>
            </div>

        </div>

        <div class="profile-actions">
            <button type="submit" class="btn-save">
                <i class="fa fa-save"></i> Save Changes
            </button>
        </div>

    </form>

</div>

<script>
function validateProfileForm(){

    let name = document.getElementById("name").value.trim();
    let designation = document.getElementById("designation").value.trim();
    let phone = document.getElementById("phone").value.trim();

    const nameRegex = /^[A-Za-z\s]+$/;
    const phoneRegex = /^[0-9]{10}$/;

    if(!nameRegex.test(name)){
        alert("Name should contain only letters and spaces.");
        return false;
    }

    if(name.length < 3){
        alert("Name must be at least 3 characters.");
        return false;
    }

    if(designation.length < 2){
        alert("Designation must be at least 2 characters.");
        return false;
    }

    if(!phoneRegex.test(phone)){
        alert("Phone number must be exactly 10 digits.");
        return false;
    }

    return true;
}
</script>

</body>
</html>