<!--hodhome.jsp-->

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String hodEmail = (String) session.getAttribute("username");

if(hodEmail == null){
    response.sendRedirect("index.jsp");
    return;
}

String hodName = "HOD";

try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root");

    PreparedStatement ps = con.prepareStatement(
        "SELECT name FROM hod WHERE email=?");
    ps.setString(1, hodEmail);

    ResultSet rs = ps.executeQuery();
    if(rs.next()){
        hodName = rs.getString("name");
    }

    rs.close();
    ps.close();
    con.close();

}catch(Exception e){
    hodName = "HOD";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOD Dashboard</title>

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
    background:#f3e8ff;
    padding:12px;
    height:100vh;
    overflow:hidden;
}

/* MAIN DASHBOARD */
.dashboard{
    display:flex;
    gap:14px;
    height:calc(100vh - 24px);
}

/* SIDEBAR */
.sidebar{
    width:260px;
    min-width:260px;
    background:#fff;
    border-radius:24px;
    padding:14px;
    display:flex;
    flex-direction:column;
    height:100%;
    overflow:hidden;
}

/* Top Sidebar Content */
.sidebar-top{
    flex:1;
    overflow:hidden;
}

/* LOGO */
.logo-box{
    background:linear-gradient(135deg,#4f46e5,#7c3aed);
    border-radius:22px;
    padding:16px;
    display:flex;
    align-items:center;
    gap:14px;
    color:#fff;
    font-size:26px;
    font-weight:700;
    margin-bottom:14px;
}

.logo-box i{
    padding:15px;
    border-radius:16px;
    background:rgba(255,255,255,.15);
    font-size:22px;
}

/* TITLES */
.menu-title{
    font-size:11px;
    font-weight:700;
    color:#94a3b8;
    margin:10px 12px 6px;
    text-transform:uppercase;
}

/* LINKS */
.nav-link{
    display:flex;
    align-items:center;
    gap:12px;
    padding:11px 15px;
    margin-bottom:5px;
    border-radius:14px;
    font-size:15px;
    font-weight:600;
    color:#1e293b;
    text-decoration:none;
    cursor:pointer;
    transition:.25s;
}

.nav-link i{
    width:18px;
}

/* Hover */
.nav-link:hover{
    background:linear-gradient(90deg,#ede9fe,#ddd6fe);
    color:#6d28d9;
    transform:translateX(4px);
}

/* Active */
.nav-link.active{
    background:linear-gradient(90deg,#7c3aed,#3b82f6);
    color:#fff;
    box-shadow:0 8px 20px rgba(124,58,237,.25);
}

/* Bottom Links */
.bottom-links{
    border-top:1px solid #e5e7eb;
    padding-top:8px;
    margin-top:8px;
    flex-shrink:0;
}

/* MAIN CONTENT */
.main{
    flex:1;
    display:flex;
    flex-direction:column;
    gap:14px;
}

/* TOPBAR */
.topbar{
    background:#fff;
    border-radius:24px;
    padding:18px 28px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.brand{
    display:flex;
    align-items:center;
    gap:18px;
    font-size:20px;
    font-weight:700;
}

.brand i{
    background:linear-gradient(135deg,#4f46e5,#3b82f6);
    color:#fff;
    padding:16px;
    border-radius:18px;
}

/* PROFILE */
.profile-dropdown{
    position:relative;
}
.bottom-links .nav-link{
    margin-bottom:0;
    padding:10px 14px;
}
.profile-btn{
    background:linear-gradient(135deg,#4f46e5,#7c3aed);
    color:#fff;
    border:none;
    padding:14px 22px;
    border-radius:18px;
    font-size:15px;
    font-weight:600;
    cursor:pointer;
    display:flex;
    align-items:center;
    gap:10px;
}

.dropdown-menu{
    position:absolute;
    right:0;
    top:110%;
    background:#fff;
    border-radius:16px;
    box-shadow:0 10px 25px rgba(0,0,0,.12);
    width:210px;
    display:none;
    overflow:hidden;
    z-index:1000;
}

.dropdown-menu a{
    display:block;
    padding:14px 18px;
    text-decoration:none;
    color:#1e293b;
    font-weight:500;
    transition:.25s;
}

.dropdown-menu a:hover{
    background:#f8fafc;
    color:#6d28d9;
}

.profile-dropdown.open .dropdown-menu{
    display:block;
}

/* CONTENT */
.content{
    flex:1;
    background:#fff;
    border-radius:24px;
    padding:18px;
    overflow:hidden;
}

iframe{
    width:100%;
    height:100%;
    border:none;
    border-radius:18px;
    background:#fff;
}

/* RESPONSIVE */
@media(max-width:1400px){
    .sidebar{
        width:240px;
        min-width:240px;
    }

    .nav-link{
        font-size:14px;
        padding:10px 13px;
    }

    .logo-box{
        font-size:22px;
        padding:14px;
    }
}

@media(max-width:1200px){
    .sidebar{
        width:220px;
        min-width:220px;
    }

    .brand{
        font-size:18px;
    }

    .profile-btn{
        padding:12px 18px;
    }
}
</style>
</head>
<body>

<div class="dashboard">

    <!-- SIDEBAR -->
    <div class="sidebar">

        <div class="sidebar-top">

            <div class="logo-box">
                <i class="fa fa-graduation-cap"></i>
                <span>HOD Panel</span>
            </div>

            <div class="menu-title">Main</div>

            <a class="nav-link active" onclick="loadPage('hod_welcome.jsp',this)">
                <i class="fa fa-house"></i> Dashboard
            </a>

            <div class="menu-title">Management</div>

            <a class="nav-link" onclick="loadPage('view_department_students.jsp',this)">
                <i class="fa fa-users"></i> Students
            </a>

            <a class="nav-link" onclick="loadPage('viewstudentdetails.jsp',this)">
                <i class="fa fa-user-clock"></i> Unassigned Students
            </a>

            <a class="nav-link" onclick="loadPage('assign_staff.jsp',this)">
                <i class="fa fa-user-plus"></i> Assign Staff
            </a>

            <div class="menu-title">Sessions</div>

            <a class="nav-link" onclick="loadPage('view_counselling_status.jsp',this)">
                <i class="fa fa-comments"></i> Counselling
            </a>

            <a class="nav-link" onclick="loadPage('view_escalated_requests.jsp',this)">
                <i class="fa fa-triangle-exclamation"></i> Escalated Issues
            </a>

            <a class="nav-link" onclick="loadPage('monthly_report.jsp',this)">
                <i class="fa fa-file-lines"></i> Reports
            </a>

            <div class="menu-title">Settings</div>

            <a class="nav-link" onclick="loadPage('change_password.jsp',this)">
                <i class="fa fa-lock"></i> Change Password
            </a>

        </div>

        <div class="bottom-links">
            <a class="nav-link" href="logout.jsp">
                <i class="fa fa-right-from-bracket"></i> Logout
            </a>
        </div>

    </div>

    <!-- MAIN -->
    <div class="main">

        <div class="topbar">
            <div class="brand">
                <i class="fa fa-bars"></i>
                Online Student Counselling System
            </div>

            <div class="profile-dropdown" id="profileDropdown">
                <button class="profile-btn" onclick="toggleDropdown()">
                    <i class="fa fa-user-circle"></i>
                    <%= hodName %>
                    <i class="fa fa-chevron-down"></i>
                </button>

                <div class="dropdown-menu">
                    <a href="#" onclick="loadProfile();return false;">
                        <i class="fa fa-user"></i> Profile
                    </a>
                    <a href="logout.jsp">
                        <i class="fa fa-right-from-bracket"></i> Logout
                    </a>
                </div>
            </div>
        </div>

        <div class="content">
            <iframe id="contentFrame" src="hod_welcome.jsp"></iframe>
        </div>

    </div>

</div>

<script>
function loadPage(page, element=null){
    document.getElementById("contentFrame").src = page;

    document.querySelectorAll(".nav-link").forEach(link=>{
        link.classList.remove("active");
    });

    if(element){
        element.classList.add("active");
    }

    document.getElementById("profileDropdown").classList.remove("open");
}

function loadProfile(){
    document.getElementById("contentFrame").src = "hod_profile.jsp";
    document.getElementById("profileDropdown").classList.remove("open");
}

function toggleDropdown(){
    document.getElementById("profileDropdown").classList.toggle("open");
}

window.onclick=function(e){
    if(!e.target.closest(".profile-dropdown")){
        document.getElementById("profileDropdown").classList.remove("open");
    }
}
</script>

</body>
</html>