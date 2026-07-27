<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Online Student Counselling System</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

html,body{
    width:100%;
    height:100%;
    overflow:hidden;
    background:#eef2f7;
}

/* MAIN WRAPPER */
.main-wrapper{
    width:100%;
    height:100dvh;
    display:flex;
}

/* LEFT PANEL */
.left-panel{
    flex:1;
    background:linear-gradient(135deg,#3157ff 0%, #d414b2 100%);
    color:white;
    padding:34px 38px;
    display:flex;
    flex-direction:column;
    justify-content:center;
}

.brand{
    display:flex;
    align-items:center;
    gap:14px;
    margin-bottom:26px;
}

.brand-icon{
    width:52px;
    height:52px;
    border-radius:14px;
    background:white;
    color:#7c3aed;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:22px;
}

.brand h3{
    font-size:17px;
    font-weight:700;
    margin:0;
}

.left-panel h1{
    font-size:3.35rem;
    font-weight:800;
    line-height:1.15;
    margin-bottom:16px;
}

.left-panel p{
    font-size:0.95rem;
    line-height:1.75;
    max-width:500px;
    opacity:0.96;
}

/* FEATURES */
.feature-list{
    margin-top:24px;
}

.feature-item{
    display:flex;
    align-items:center;
    gap:12px;
    font-size:0.95rem;
    font-weight:500;
    margin-bottom:12px;
}

.feature-item i{
    width:38px;
    height:38px;
    border-radius:12px;
    background:rgba(255,255,255,0.15);
    display:flex;
    align-items:center;
    justify-content:center;
}

/* RIGHT PANEL */
.right-panel{
    flex:1;
    background:#f8fafc;
    padding:28px 34px;
    display:flex;
    flex-direction:column;
    justify-content:center;
}

.right-panel h2{
    font-size:3.35rem;
    font-weight:800;
    text-align:center;
    margin-bottom:4px;
    color:#111827;
}

.subtitle{
    font-size:0.95rem;
    color:#6b7280;
    text-align:center;
    margin-bottom:22px;
}

/* GRID */
.role-grid{
    display:grid;
    grid-template-columns:repeat(2,1fr);
    gap:20px;
}

/* CARDS */
.role-card{
    background:#fff;
    border-radius:22px;
    padding:22px 20px;
    text-align:center;
    transition:all 0.28s ease;
    box-shadow:0 8px 20px rgba(15,23,42,0.04);
}

.role-card:hover{
    transform:translateY(-6px);
}

.admin-card:hover{
    box-shadow:0 18px 35px rgba(37,99,235,0.14), 0 4px 10px rgba(37,99,235,0.08);
}

.hod-card:hover{
    box-shadow:0 18px 35px rgba(168,85,247,0.14), 0 4px 10px rgba(168,85,247,0.08);
}

.staff-card:hover{
    box-shadow:0 18px 35px rgba(20,184,166,0.14), 0 4px 10px rgba(20,184,166,0.08);
}

.student-card:hover{
    box-shadow:0 18px 35px rgba(236,72,153,0.14), 0 4px 10px rgba(236,72,153,0.08);
}

/* ICON */
.role-icon{
    width:68px;
    height:68px;
    border-radius:20px;
    margin:auto auto 14px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:25px;
    color:white;
    transition:all 0.28s ease;
}

.role-card:hover .role-icon{
    transform:translateY(-2px) scale(1.04);
}

.admin-icon{
    background:linear-gradient(135deg,#3b82f6,#2563eb);
    box-shadow:0 10px 24px rgba(59,130,246,0.25);
}

.hod-icon{
    background:linear-gradient(135deg,#c026d3,#9333ea);
    box-shadow:0 10px 24px rgba(192,38,211,0.25);
}

.staff-icon{
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    box-shadow:0 10px 24px rgba(20,184,166,0.25);
}

.student-icon{
    background:linear-gradient(135deg,#ec4899,#db2777);
    box-shadow:0 10px 24px rgba(236,72,153,0.25);
}

.role-card h4{
    font-size:1.45rem;
    font-weight:700;
    margin-bottom:6px;
    color:#111827;
}

.role-card p{
    font-size:0.92rem;
    color:#6b7280;
    margin-bottom:16px;
}

/* BUTTON */
.login-btn{
    width:100%;
    padding:11px;
    border-radius:14px;
    color:white;
    font-weight:600;
    font-size:0.95rem;
    text-decoration:none;
    display:inline-block;
    transition:all 0.28s ease;
}

.login-btn:hover{
    color:white;
    transform:translateY(-1px);
    filter:brightness(1.05);
}

.admin-btn{
    background:linear-gradient(135deg,#3b82f6,#2563eb);
}

.hod-btn{
    background:linear-gradient(135deg,#c026d3,#9333ea);
}

.staff-btn{
    background:linear-gradient(135deg,#14b8a6,#0f766e);
}

.student-btn{
    background:linear-gradient(135deg,#ec4899,#db2777);
}

/* FOOTER */
.footer-note{
    margin-top:16px;
    text-align:center;
    font-size:0.9rem;
    color:#6b7280;
}

.footer-note a{
    color:#7c3aed;
    text-decoration:none;
    font-weight:600;
}

/* MOBILE */
@media(max-width:992px){

    html,body{
        overflow:auto;
    }

    .main-wrapper{
        height:auto;
        flex-direction:column;
    }

    .role-grid{
        grid-template-columns:1fr;
    }

    .left-panel,
    .right-panel{
        width:100%;
        padding:30px 22px;
    }

    .left-panel h1,
    .right-panel h2{
        font-size:2.4rem;
    }
}
</style>
</head>
<body>

<div class="main-wrapper">

    <div class="left-panel">

        <div class="brand">
            <div class="brand-icon">
                <i class="fa-solid fa-graduation-cap"></i>
            </div>
            <h3>Student Counselling System</h3>
        </div>

        <h1>Empowering Students Through Digital Guidance</h1>

        <p>
            A comprehensive platform connecting students with counsellors,
            administrators, and department heads to provide personalized
            academic and personal guidance.
        </p>

        <div class="feature-list">
            <div class="feature-item">
                <i class="fa-solid fa-calendar-check"></i>
                Schedule Appointments
            </div>

            <div class="feature-item">
                <i class="fa-solid fa-comments"></i>
                Real-time Messaging
            </div>

            <div class="feature-item">
                <i class="fa-solid fa-chart-line"></i>
                Progress Tracking
            </div>

            <div class="feature-item">
                <i class="fa-solid fa-shield-halved"></i>
                Secure & Private
            </div>
        </div>

    </div>

    <div class="right-panel">

        <h2>Welcome Back</h2>

        <div class="subtitle">
            Select your role to access the system
        </div>

        <div class="role-grid">

            <div class="role-card admin-card">
                <div class="role-icon admin-icon">
                    <i class="fa-solid fa-user-shield"></i>
                </div>
                <h4>Admin</h4>
                <p>System Administrator</p>
                <a href="Admin_Login.jsp" class="login-btn admin-btn">Login</a>
            </div>

            <div class="role-card hod-card">
                <div class="role-icon hod-icon">
                    <i class="fa-solid fa-user-tie"></i>
                </div>
                <h4>HOD</h4>
                <p>Head of Department</p>
                <a href="hod_login.jsp" class="login-btn hod-btn">Login</a>
            </div>

            <div class="role-card staff-card">
                <div class="role-icon staff-icon">
                    <i class="fa-regular fa-comment"></i>
                </div>
                <h4>Counsellor</h4>
                <p>Student Counsellor</p>
                <a href="staff_login.jsp" class="login-btn staff-btn">Login</a>
            </div>

            <div class="role-card student-card">
                <div class="role-icon student-icon">
                    <i class="fa-solid fa-user-graduate"></i>
                </div>
                <h4>Student</h4>
                <p>Student Portal</p>
                <a href="student_login.jsp" class="login-btn student-btn">Login</a>
            </div>

        </div>

        <div class="footer-note">
            Need assistance? <a href="#">Contact Support</a>
        </div>

    </div>

</div>

</body>
</html>