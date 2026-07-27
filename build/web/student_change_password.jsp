<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
String username = (String) session.getAttribute("username");
if(username == null){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Change Password</title>

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
}

.page{
    width:100%;
    padding:6px 12px 12px;
}

.page-header{
    text-align:center;
    margin-bottom:18px;
}

.page-header h2{
    font-size:34px;
    font-weight:700;
    color:#0f172a;
}

.page-header p{
    color:#64748b;
    font-size:15px;
}

.card{
    width:100%;
    max-width:850px;
    margin:auto;
    background:#fff;
    border-radius:22px;
    padding:28px;
    box-shadow:0 8px 20px rgba(236,72,153,.08);
    border:1px solid #fce7f3;
}

.card-title{
    display:flex;
    align-items:center;
    gap:14px;
    font-size:24px;
    font-weight:700;
    margin-bottom:24px;
    color:#0f172a;
}

.icon-box{
    width:50px;
    height:50px;
    border-radius:16px;
    background:#fce7f3;
    color:#db2777;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:20px;
}

.form-group{
    margin-bottom:20px;
}

label{
    display:block;
    margin-bottom:8px;
    font-weight:600;
    color:#334155;
}

.input-box{
    position:relative;
}

input{
    width:100%;
    padding:14px 48px 14px 18px;
    border:1px solid #fbcfe8;
    border-radius:14px;
    font-size:15px;
    outline:none;
    transition:.3s;
}

input:focus{
    border-color:#ec4899;
    box-shadow:0 0 0 3px rgba(236,72,153,.15);
}

.eye{
    position:absolute;
    right:18px;
    top:50%;
    transform:translateY(-50%);
    cursor:pointer;
    color:#64748b;
}

.info-box{
    background:#fdf2f8;
    border:1px solid #fbcfe8;
    padding:16px;
    border-radius:14px;
    margin-bottom:22px;
}

.info-box h4{
    color:#be185d;
    margin-bottom:10px;
}

.info-box ul{
    padding-left:20px;
    color:#be185d;
}

.btn-submit{
    width:100%;
    border:none;
    padding:15px;
    border-radius:14px;
    background:linear-gradient(90deg,#ff2d95,#ff006a);
    color:#fff;
    font-size:16px;
    font-weight:600;
    cursor:pointer;
    transition:.3s;
}

.btn-submit:hover{
    transform:translateY(-2px);
    box-shadow:0 10px 20px rgba(255,0,106,.20);
}

.msg{
    text-align:center;
    font-weight:600;
    margin-bottom:16px;
}

.success{color:green;}
.error{color:red;}
</style>
</head>
<body>

<div class="page">

    <div class="page-header">
        <h2>Account Security</h2>
        <p>Manage your password and security settings</p>
    </div>

    <div class="card">

        <div class="card-title">
            <div class="icon-box">
                <i class="fa fa-key"></i>
            </div>
            Student Change Password
        </div>

        <% if(request.getParameter("success") != null){ %>
            <div class="msg success">Password updated successfully.</div>
        <% } %>

        <% if(request.getParameter("error") != null){ %>
            <div class="msg error"><%= request.getParameter("error") %></div>
        <% } %>

        <form action="student_change_password_action.jsp" method="post">

            <div class="form-group">
                <label>Current Password</label>
                <div class="input-box">
                    <input type="password" name="currentPassword" id="currentPassword" required>
                    <i class="fa fa-eye eye" onclick="togglePassword('currentPassword',this)"></i>
                </div>
            </div>

            <div class="form-group">
                <label>New Password</label>
                <div class="input-box">
                    <input type="password" name="newPassword" id="newPassword" required>
                    <i class="fa fa-eye eye" onclick="togglePassword('newPassword',this)"></i>
                </div>
            </div>

            <div class="form-group">
                <label>Confirm New Password</label>
                <div class="input-box">
                    <input type="password" name="confirmPassword" id="confirmPassword" required>
                    <i class="fa fa-eye eye" onclick="togglePassword('confirmPassword',this)"></i>
                </div>
            </div>

            <div class="info-box">
                <h4>Password Requirements:</h4>
                <ul>
                    <li>At least 8 characters long</li>
                    <li>Use uppercase/lowercase letters</li>
                    <li>Include numbers/symbols for better security</li>
                </ul>
            </div>

            <button type="submit" class="btn-submit">
                <i class="fa fa-lock"></i> Update Password
            </button>

        </form>

    </div>
</div>

<script>
function togglePassword(id,icon){
    const input=document.getElementById(id);

    if(input.type==="password"){
        input.type="text";
        icon.classList.replace("fa-eye","fa-eye-slash");
    }else{
        input.type="password";
        icon.classList.replace("fa-eye-slash","fa-eye");
    }
}
</script>

</body>
</html>