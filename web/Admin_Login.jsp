<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<title>Admin Login - Student Counselling System</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

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
    background:linear-gradient(135deg,#0d6efd,#00c6ff);
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
    background:#fff;
    top:-80px;
    left:-60px;
}

body::after{
    width:320px;
    height:320px;
    background:#60a5fa;
    bottom:-100px;
    right:-70px;
}

.login-card{
    position:relative;
    z-index:2;
    width:430px;
    background:rgba(255,255,255,0.95);
    backdrop-filter:blur(18px);
    padding:38px;
    border-radius:28px;
    box-shadow:
        0 25px 50px rgba(0,0,0,.15),
        inset 0 1px 0 rgba(255,255,255,.5);
    animation:fadeUp .7s ease;
}

.login-icon{
    width:82px;
    height:82px;
    margin:0 auto 18px;
    border-radius:22px;
    background:linear-gradient(135deg,#0d6efd,#00c6ff);
    display:flex;
    align-items:center;
    justify-content:center;
    color:#fff;
    font-size:34px;
    box-shadow:0 12px 28px rgba(13,110,253,.35);
}

.login-card h2{
    text-align:center;
    font-size:30px;
    font-weight:700;
    color:#0f172a;
    margin-bottom:6px;
}

.subtitle{
    text-align:center;
    color:#64748b;
    font-size:14px;
    margin-bottom:28px;
}

.form-group{
    margin-bottom:18px;
}

.form-group label{
    display:block;
    font-weight:500;
    margin-bottom:8px;
    color:#334155;
    font-size:14px;
}

.input-wrap{
    position:relative;
}

.input-wrap i{
    position:absolute;
    left:16px;
    top:50%;
    transform:translateY(-50%);
    color:#94a3b8;
}

.form-control{
    width:100%;
    padding:14px 14px 14px 46px;
    border:1px solid #dbe2ea;
    border-radius:14px;
    font-size:14px;
    outline:none;
    transition:.3s;
}

.form-control:focus{
    border-color:#0d6efd;
    box-shadow:0 0 0 4px rgba(13,110,253,.12);
}

.btn-login{
    width:100%;
    padding:14px;
    border:none;
    border-radius:14px;
    background:linear-gradient(90deg,#0d6efd,#00c6ff);
    color:#fff;
    font-weight:600;
    font-size:15px;
    cursor:pointer;
    transition:.3s;
    margin-top:8px;
}

.btn-login:hover{
    transform:translateY(-2px);
    box-shadow:0 14px 28px rgba(13,110,253,.28);
}

.home-link{
    margin-top:22px;
    text-align:center;
}

.home-link a{
    text-decoration:none;
    color:#64748b;
    font-weight:500;
    font-size:14px;
    transition:.3s;
}

.home-link a:hover{
    color:#0d6efd;
}

@keyframes fadeUp{
    from{
        opacity:0;
        transform:translateY(30px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}
</style>

</head>
<body>

<div class="login-card">

    <div class="login-icon">
        <i class="fa-solid fa-user-shield"></i>
    </div>

    <h2>Admin Login</h2>
    <div class="subtitle">Access the Administrator dashboard</div>

    <form action="userauthentication.jsp" method="post">

        <input type="hidden" name="role" value="admin"/>

        <div class="form-group">
            <label>Username</label>
            <div class="input-wrap">
                <i class="fa-solid fa-user"></i>
                <input type="text" name="username" class="form-control" placeholder="Enter your username" required>
            </div>
        </div>

        <div class="form-group">
            <label>Password</label>
            <div class="input-wrap">
                <i class="fa-solid fa-lock"></i>
                <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
            </div>
        </div>

        <button type="submit" class="btn-login">
            <i class="fa-solid fa-right-to-bracket"></i> Login to Dashboard
        </button>

    </form>

    <div class="home-link">
        <a href="index.jsp">
            <i class="fa-solid fa-arrow-left"></i> Back to Home
        </a>
    </div>

</div>

</body>
</html>