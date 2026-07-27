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
<title>Change Password</title>

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
    padding:0;
}

/* MAIN WRAPPER */
.page{
    width:100%;
    padding:10px 20px 20px 20px;
}

/* TOP TITLE */
.page-header{
    text-align:center;
    margin-bottom:25px;
}

.page-header h2{
    font-size:42px;
    font-weight:700;
    color:#0f172a;
}

.page-header p{
    color:#64748b;
    font-size:17px;
}

/* CARD */
.card{
    width:100%;
    max-width:900px;
    margin:auto;
    background:#fff;
    border-radius:24px;
    padding:35px;
    box-shadow:0 8px 25px rgba(0,0,0,.08);
}

/* CARD TITLE */
.card-title{
    display:flex;
    align-items:center;
    gap:15px;
    font-size:28px;
    font-weight:700;
    margin-bottom:28px;
}

.icon-box{
    width:52px;
    height:52px;
    border-radius:16px;
    background:#ccfbf1;
    color:#0f766e;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:22px;
}

/* FORM */
.form-group{
    margin-bottom:22px;
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
    padding:15px 50px 15px 18px;
    border:1px solid #cbd5e1;
    border-radius:14px;
    font-size:15px;
    outline:none;
    transition:.3s;
}

input:focus{
    border-color:#14b8a6;
    box-shadow:0 0 0 3px rgba(20,184,166,.15);
}

.eye{
    position:absolute;
    right:18px;
    top:50%;
    transform:translateY(-50%);
    cursor:pointer;
    color:#64748b;
}

/* INFO BOX */
.info-box{
    background:#ecfeff;
    border:1px solid #99f6e4;
    padding:18px;
    border-radius:16px;
    margin-bottom:25px;
}

.info-box h4{
    color:#0f766e;
    margin-bottom:10px;
}

.info-box ul{
    padding-left:20px;
    color:#0f766e;
}

/* BUTTON */
.btn-submit{
    width:100%;
    border:none;
    padding:16px;
    border-radius:16px;
    background:linear-gradient(90deg,#14b8a6,#0f766e);
    color:#fff;
    font-size:18px;
    font-weight:600;
    cursor:pointer;
    transition:.3s;
}

.btn-submit:hover{
    transform:translateY(-2px);
    box-shadow:0 10px 20px rgba(20,184,166,.25);
}

/* MESSAGE */
.msg{
    text-align:center;
    font-weight:600;
    margin-bottom:18px;
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
            Change Password
        </div>

        <% if(request.getParameter("success") != null){ %>
            <div class="msg success">Password updated successfully.</div>
        <% } %>

        <% if(request.getParameter("error") != null){ %>
            <div class="msg error"><%= request.getParameter("error") %></div>
        <% } %>

        <form action="staff_change_password_action.jsp" method="post">

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
                    <li>Mix of uppercase and lowercase letters recommended</li>
                    <li>Include numbers and special characters for better security</li>
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