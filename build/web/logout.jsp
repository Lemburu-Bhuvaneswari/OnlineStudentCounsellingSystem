<%
session.invalidate();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Logout Successful</title>

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
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    overflow:hidden;
    background:
        radial-gradient(circle at 15% 20%, rgba(59,130,246,.18), transparent 30%),
        radial-gradient(circle at 85% 80%, rgba(14,165,233,.18), transparent 30%),
        linear-gradient(135deg,#eef4ff,#f8fbff,#eef7ff);
}

.logout-wrapper{
    width:100%;
    max-width:560px;
    padding:20px;
}

.logout-card{
    position:relative;
    background:rgba(255,255,255,0.88);
    backdrop-filter:blur(22px);
    border:1px solid rgba(255,255,255,.65);
    border-radius:30px;
    padding:50px 42px;
    text-align:center;
    box-shadow:
        0 25px 60px rgba(15,23,42,.10),
        inset 0 1px 0 rgba(255,255,255,.75);
    overflow:hidden;
}

.logout-card::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    width:100%;
    height:6px;
    background:linear-gradient(90deg,#2563eb,#06b6d4);
}

.icon-shell{
    width:110px;
    height:110px;
    margin:auto;
    border-radius:30px;
    background:linear-gradient(135deg,#2563eb,#06b6d4);
    display:flex;
    align-items:center;
    justify-content:center;
    box-shadow:
        0 15px 35px rgba(37,99,235,.25),
        inset 0 2px 8px rgba(255,255,255,.25);
    margin-bottom:28px;
}

.icon-shell i{
    font-size:42px;
    color:#fff;
}

h1{
    font-size:36px;
    font-weight:700;
    color:#0f172a;
    margin-bottom:14px;
}

.subtitle{
    font-size:16px;
    color:#64748b;
    line-height:1.8;
    margin-bottom:30px;
}

.brand{
    color:#2563eb;
    font-weight:600;
}

.info-strip{
    background:#f8fafc;
    border:1px solid #e2e8f0;
    padding:14px 18px;
    border-radius:16px;
    font-size:14px;
    color:#475569;
    margin-bottom:30px;
}

.btn-login{
    display:inline-flex;
    align-items:center;
    gap:10px;
    padding:15px 34px;
    border-radius:50px;
    background:linear-gradient(135deg,#2563eb,#06b6d4);
    color:#fff;
    text-decoration:none;
    font-weight:600;
    font-size:15px;
    box-shadow:0 12px 28px rgba(37,99,235,.22);
    transition:.3s ease;
}

.btn-login:hover{
    transform:translateY(-2px);
    box-shadow:0 18px 35px rgba(37,99,235,.28);
    color:#fff;
}

.footer-text{
    margin-top:24px;
    font-size:13px;
    color:#94a3b8;
}

@media(max-width:576px){
    .logout-card{
        padding:38px 24px;
    }

    h1{
        font-size:28px;
    }

    .icon-shell{
        width:90px;
        height:90px;
    }

    .icon-shell i{
        font-size:34px;
    }
}
</style>
</head>
<body>

<div class="logout-wrapper">
    <div class="logout-card">

        <div class="icon-shell">
            <i class="fa-solid fa-right-from-bracket"></i>
        </div>

        <h1>Logout Successful</h1>

        <p class="subtitle">
            You have securely signed out of the
            <span class="brand">Online Student Counselling System</span>.
        </p>

        <div class="info-strip">
            Your session has ended successfully. Please log in again to continue accessing your dashboard.
        </div>

        <a href="index.jsp" class="btn-login">
            <i class="fa fa-arrow-left"></i>
            Return to Login
        </a>

        <div class="footer-text">
            Secure o Reliable o Academic Management Portal
        </div>

    </div>
</div>

</body>
</html>