<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
String usertype = (String) session.getAttribute("usertype");
if(usertype == null || !usertype.equals("admin")){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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
}

body{
    background:linear-gradient(135deg,#dbeafe,#e0f2fe);
    padding:10px;
}

/* Layout */
.dashboard{
    display:flex;
    gap:16px;
    width:100%;
    height:calc(100vh - 20px);
}

/* Sidebar */
.sidebar{
    width:280px;
    min-width:280px;
    background:rgba(255,255,255,.88);
    border-radius:26px;
    padding:14px;
    display:flex;
    flex-direction:column;
    justify-content:space-between;
    overflow:hidden;
    transition:.35s ease;
}

.sidebar.collapsed{
    width:88px;
    min-width:88px;
}

.sidebar.collapsed .logo-title,
.sidebar.collapsed .menu-title,
.sidebar.collapsed .nav-link span{
    display:none;
}

.sidebar.collapsed .nav-link{
    justify-content:center;
}

/* Logo */
.logo-box{
    background:linear-gradient(135deg,#0d6efd,#06b6d4);
    color:#fff;
    border-radius:20px;
    padding:16px;
    display:flex;
    align-items:center;
    gap:12px;
    margin-bottom:14px;
}

.logo-icon{
    width:46px;
    height:46px;
    border-radius:14px;
    background:rgba(255,255,255,.15);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:18px;
}

.logo-title{
    font-size:20px;
    font-weight:600;
}

/* Menu */
.menu-title{
    font-size:11px;
    font-weight:700;
    color:#94a3b8;
    margin:10px 10px 6px;
    text-transform:uppercase;
}

.nav-link{
    display:flex;
    align-items:center;
    gap:12px;
    padding:11px 14px;
    border-radius:14px;
    text-decoration:none;
    color:#334155;
    font-weight:500;
    font-size:15px;
    transition:.25s;
    margin-bottom:4px;
    cursor:pointer;
}

.nav-link:hover,
.nav-link.active{
    background:linear-gradient(90deg,#0d6efd,#06b6d4);
    color:#fff;
}

.sidebar-bottom{
    padding-top:10px;
    border-top:1px solid #e5e7eb;
}

/* Main */
.main-content{
    flex:1;
    display:flex;
    flex-direction:column;
    gap:16px;
}

/* Topbar */
.topbar{
    background:rgba(255,255,255,.88);
    border-radius:24px;
    padding:16px 22px;
    display:flex;
    align-items:center;
    justify-content:space-between;
}

.top-left{
    display:flex;
    align-items:center;
    gap:14px;
}

.toggle-btn{
    width:48px;
    height:48px;
    border:none;
    border-radius:14px;
    background:linear-gradient(135deg,#0d6efd,#06b6d4);
    color:#fff;
    font-size:18px;
    cursor:pointer;
}

.topbar h2{
    font-size:21px;
    font-weight:700;
}

.logout-btn{
    padding:11px 22px;
    border-radius:15px;
    text-decoration:none;
    background:linear-gradient(135deg,#0d6efd,#06b6d4);
    color:#fff;
    font-weight:600;
}

/* Content */
.content-panel{
    flex:1;
    background:rgba(255,255,255,.88);
    border-radius:26px;
    padding:16px;
}

.content-frame{
    width:100%;
    height:100%;
    border:none;
    border-radius:18px;
    background:#fff;
}
</style>
</head>

<body>

<div class="dashboard">

    <div class="sidebar" id="sidebar">

        <div>

            <div class="logo-box">
                <div class="logo-icon">
                    <i class="fa fa-user-shield"></i>
                </div>
                <div class="logo-title">Admin Panel</div>
            </div>

            <div class="menu-title">Main</div>
            <a class="nav-link active" onclick="loadPage('welcome.jsp',this)">
                <i class="fa fa-house"></i><span>Dashboard</span>
            </a>

            <div class="menu-title">Management</div>

            <a class="nav-link" onclick="loadPage('add_department.jsp',this)">
                <i class="fa fa-building"></i><span>Add Department</span>
            </a>

            <a class="nav-link" onclick="loadPage('add_hod.jsp',this)">
                <i class="fa fa-user-tie"></i><span>Add HOD</span>
            </a>

            <a class="nav-link" onclick="loadPage('add_staff.jsp',this)">
                <i class="fa fa-user"></i><span>Add Staff</span>
            </a>

            <a class="nav-link" onclick="loadPage('add_student.jsp',this)">
                <i class="fa fa-user-graduate"></i><span>Add Student</span>
            </a>

            <div class="menu-title">View Records</div>

            <a class="nav-link" onclick="loadPage('view_departments.jsp',this)">
                <i class="fa fa-list"></i><span>Departments</span>
            </a>

            <a class="nav-link" onclick="loadPage('view_hod.jsp',this)">
                <i class="fa fa-eye"></i><span>View HOD</span>
            </a>

            <a class="nav-link" onclick="loadPage('view_staff.jsp',this)">
                <i class="fa fa-users"></i><span>View Staff</span>
            </a>

            <a class="nav-link" onclick="loadPage('view_students.jsp',this)">
                <i class="fa fa-user-graduate"></i><span>View Students</span>
            </a>

        </div>

        <div class="sidebar-bottom">
            <a href="logout.jsp" class="nav-link">
                <i class="fa fa-right-from-bracket"></i><span>Logout</span>
            </a>
        </div>

    </div>

    <div class="main-content">

        <div class="topbar">
            <div class="top-left">
                <button class="toggle-btn" onclick="toggleSidebar()">
                    <i class="fa fa-bars"></i>
                </button>
                <h2>Online Student Counselling System</h2>
            </div>

            <a href="logout.jsp" class="logout-btn">Logout</a>
        </div>

        <div class="content-panel">
            <iframe id="contentFrame" class="content-frame" src="welcome.jsp"></iframe>
        </div>

    </div>

</div>

<script>
function loadPage(page, element){
    document.getElementById("contentFrame").src = page;

    document.querySelectorAll(".nav-link").forEach(link=>{
        link.classList.remove("active");
    });

    if(element){
        element.classList.add("active");
    }
}

function toggleSidebar(){
    document.getElementById("sidebar").classList.toggle("collapsed");
}
</script>

</body>
</html>