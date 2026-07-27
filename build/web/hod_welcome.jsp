<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
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
    padding:10px;
}

h2{
    font-size:22px;
    font-weight:700;
    margin-bottom:24px;
    color:#111827;
}

.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:24px;
}

.card{
    background:#fff;
    border-radius:20px;
    padding:32px 24px;
    text-align:center;
    border:1px solid #e5e7eb;
    box-shadow:0 8px 20px rgba(0,0,0,.06);
    cursor:pointer;
    transition:.3s;
}

.card:hover{
    transform:translateY(-6px);
    box-shadow:0 12px 24px rgba(124,58,237,.15);
}

.icon{
    width:68px;
    height:68px;
    margin:auto auto 16px;
    border-radius:18px;
    display:flex;
    align-items:center;
    justify-content:center;
    color:#fff;
    font-size:24px;
}

.c1{background:#3b82f6;}
.c2{background:#10b981;}
.c3{background:#f97316;}
.c4{background:#f59e0b;}
.c5{background:#ef4444;}

.card-title{
    font-size:18px;
    font-weight:600;
}
</style>
</head>
<body>

<h2>Dashboard</h2>

<div class="grid">

    <div class="card" onclick="parent.loadPage('view_department_students.jsp')">
        <div class="icon c1"><i class="fa fa-users"></i></div>
        <div class="card-title">Students</div>
    </div>

    <div class="card" onclick="parent.loadPage('assign_staff.jsp')">
        <div class="icon c2"><i class="fa fa-user-plus"></i></div>
        <div class="card-title">Assign Staff</div>
    </div>

    <div class="card" onclick="parent.loadPage('view_counselling_status.jsp')">
        <div class="icon c3"><i class="fa fa-comments"></i></div>
        <div class="card-title">Counselling</div>
    </div>

    <div class="card" onclick="parent.loadPage('view_escalated_requests.jsp')">
        <div class="icon c4"><i class="fa fa-triangle-exclamation"></i></div>
        <div class="card-title">Escalated Issues</div>
    </div>

    <div class="card" onclick="parent.loadPage('monthly_report.jsp')">
        <div class="icon c5"><i class="fa fa-file-lines"></i></div>
        <div class="card-title">Reports</div>
    </div>

</div>

</body>
</html>