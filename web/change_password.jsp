<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String username = (String)session.getAttribute("username");

if(username==null){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Change Password</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
    background:transparent;
}

.password-page{
    width:100%;
    padding:30px;
}

.page-header-center{
    text-align:center;
    margin-bottom:28px;
}

.page-title{
    font-size:30px;
    font-weight:700;
    color:#0f172a;
    margin-bottom:8px;
}

.page-subtitle{
    font-size:15px;
    color:#64748b;
}

.password-card-wrapper{
    width:100%;
    display:flex;
    justify-content:center;
    align-items:flex-start;
}

.password-card{
    width:100%;
    max-width:780px;
    background:#fff;
    border-radius:24px;
    padding:35px;
    border:1px solid #e2e8f0;
    box-shadow:0 10px 30px rgba(99,102,241,0.08);
}

.card-header-custom{
    display:flex;
    align-items:center;
    gap:16px;
    margin-bottom:28px;
}

.icon-box{
    width:52px;
    height:52px;
    border-radius:16px;
    background:#f3e8ff;
    color:#9333ea;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:20px;
}

.card-title{
    font-size:22px;
    font-weight:700;
    margin:0;
    color:#0f172a;
}

.form-label{
    font-size:14px;
    font-weight:600;
    color:#334155;
    margin-bottom:8px;
}

.input-group-custom{
    position:relative;
    margin-bottom:22px;
}

.input-group-custom .left-icon{
    position:absolute;
    left:18px;
    top:50%;
    transform:translateY(-50%);
    color:#94a3b8;
    font-size:16px;
}

.input-group-custom .toggle-password{
    position:absolute;
    right:18px;
    top:50%;
    transform:translateY(-50%);
    color:#94a3b8;
    cursor:pointer;
    font-size:16px;
}

.form-control{
    height:56px;
    border-radius:14px;
    padding-left:48px;
    padding-right:48px;
    border:1px solid #dbe2ea;
    font-size:15px;
    transition:.3s;
}

.form-control:focus{
    border-color:#7c3aed;
    box-shadow:0 0 0 4px rgba(124,58,237,0.10);
}

.password-rules{
    background:#eff6ff;
    border:1px solid #bfdbfe;
    border-radius:16px;
    padding:18px 20px;
    margin-bottom:24px;
}

.password-rules h6{
    font-size:15px;
    font-weight:600;
    color:#1e40af;
    margin-bottom:10px;
}

.password-rules ul{
    padding-left:20px;
    margin:0;
}

.password-rules li{
    font-size:13px;
    color:#2563eb;
    margin-bottom:6px;
}

.btn-update{
    width:100%;
    height:56px;
    border:none;
    border-radius:16px;
    font-size:17px;
    font-weight:600;
    color:#fff;
    background:linear-gradient(90deg,#2563eb,#a21caf);
    transition:.3s;
    box-shadow:0 8px 20px rgba(124,58,237,0.25);
}

.btn-update:hover{
    transform:translateY(-2px);
    opacity:.95;
}
</style>
</head>

<body>

<div class="password-page">

    <div class="page-header-center">
        <h2 class="page-title">Account Security</h2>
        <p class="page-subtitle">Manage your password and security settings</p>
    </div>

    <div class="password-card-wrapper">

        <div class="password-card">

            <div class="card-header-custom">
                <div class="icon-box">
                    <i class="fa-solid fa-key"></i>
                </div>
                <h4 class="card-title">Change Password</h4>
            </div>

            <form action="change_password_action.jsp" method="post">

                <label class="form-label">Current Password</label>
                <div class="input-group-custom">
                    <i class="fa fa-lock left-icon"></i>
                    <input type="password" name="current_password" id="current_password" class="form-control" placeholder="Enter current password" required>
                    <i class="fa fa-eye toggle-password" onclick="togglePassword('current_password',this)"></i>
                </div>

                <label class="form-label">New Password</label>
                <div class="input-group-custom">
                    <i class="fa fa-lock left-icon"></i>
                    <input type="password" name="new_password" id="new_password" class="form-control" placeholder="Enter new password" required>
                    <i class="fa fa-eye toggle-password" onclick="togglePassword('new_password',this)"></i>
                </div>

                <label class="form-label">Confirm New Password</label>
                <div class="input-group-custom">
                    <i class="fa fa-lock left-icon"></i>
                    <input type="password" name="confirm_password" id="confirm_password" class="form-control" placeholder="Confirm new password" required>
                    <i class="fa fa-eye toggle-password" onclick="togglePassword('confirm_password',this)"></i>
                </div>

                <div class="password-rules">
                    <h6><i class="fa fa-shield-alt"></i> Password Requirements:</h6>
                    <ul>
                        <li>At least 8 characters long</li>
                        <li>Mix of uppercase and lowercase letters recommended</li>
                        <li>Include numbers and special characters for better security</li>
                    </ul>
                </div>

                <button type="submit" class="btn-update">
                    <i class="fa fa-lock"></i> Update Password
                </button>

            </form>

        </div>

    </div>

</div>

<script>
function togglePassword(fieldId, icon){
    const input = document.getElementById(fieldId);

    if(input.type === "password"){
        input.type = "text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
    }else{
        input.type = "password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
    }
}
</script>

</body>
</html>