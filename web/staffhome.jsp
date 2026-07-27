<!--staffhome.jsp-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String username = (String) session.getAttribute("username");
String name = (String) session.getAttribute("name");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Staff Dashboard</title>

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
    background:linear-gradient(135deg,#ccfbf1,#d1fae5);
    padding:10px;
}

/* Dashboard Layout */
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
    transition:.35s;
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

.logo-box{
    background:linear-gradient(135deg,#14b8a6,#0f766e);
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
}

.logo-title{
    font-size:20px;
    font-weight:600;
}

.menu-title{
    font-size:11px;
    font-weight:700;
    color:#94a3b8;
    margin:12px 10px 6px;
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
    cursor:pointer;
    transition:.25s;
    margin-bottom:4px;
}

.nav-link:hover,
.nav-link.active{
    background:linear-gradient(90deg,#14b8a6,#0f766e);
    color:#fff;
}

.sidebar-bottom{
    border-top:1px solid #e5e7eb;
    padding-top:10px;
}

/* Main */
.main-content{
    flex:1;
    display:flex;
    flex-direction:column;
    gap:16px;
}

.topbar{
    background:rgba(255,255,255,.88);
    border-radius:24px;
    padding:16px 22px;
    display:flex;
    justify-content:space-between;
    align-items:center;
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
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    color:#fff;
    cursor:pointer;
    font-size:18px;
}

.topbar h2{
    font-size:22px;
    font-weight:700;
}

/* Profile Dropdown */
.profile-menu-wrapper{
    position:relative;
}

.profile-btn{
    border:none;
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    color:#fff;
    padding:10px 18px;
    border-radius:14px;
    font-weight:600;
    display:flex;
    align-items:center;
    gap:10px;
    cursor:pointer;
}

.profile-dropdown{
    position:absolute;
    right:0;
    top:58px;
    width:230px;
    background:#fff;
    border-radius:16px;
    box-shadow:0 15px 35px rgba(0,0,0,.12);
    padding:10px;
    display:none;
    z-index:999;
}

.profile-dropdown a{
    display:flex;
    align-items:center;
    gap:10px;
    padding:12px 14px;
    border-radius:12px;
    text-decoration:none;
    color:#334155;
    font-weight:500;
    cursor:pointer;
}

.profile-dropdown a:hover{
    background:#f1f5f9;
}

/* Content */
.content-panel{
    flex:1;
    background:rgba(255,255,255,.88);
    border-radius:26px;
    padding:16px;
}

iframe{
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
                    <i class="fa fa-comments"></i>
                </div>
                <div class="logo-title">Counsellor Panel</div>
            </div>

            <div class="menu-title">Main</div>

            <a class="nav-link active" onclick="loadPage('staff_welcome.jsp',this)">
                <i class="fa fa-house"></i><span>Dashboard</span>
            </a>

            <div class="menu-title">Management</div>

            <a class="nav-link" onclick="loadPage('view_assigned_students.jsp',this)">
                <i class="fa fa-users"></i><span>Assigned Students</span>
            </a>

            <a class="nav-link" onclick="loadPage('view_counselling.jsp',this)">
                <i class="fa fa-comments"></i><span>View Counselling</span>
            </a>

            <a class="nav-link" onclick="loadPage('viewCounsellingRequests.jsp',this)">
                <i class="fa fa-code-pull-request"></i><span>View Requests</span>
            </a>

            <div class="menu-title">Settings</div>

                        <a class="nav-link" onclick="loadPage('staff_change_password.jsp',this)">
                <i class="fa fa-lock"></i>
                <span>Change Password</span>
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

            <div class="profile-menu-wrapper">

                <button class="profile-btn" onclick="toggleProfileMenu()">
                    <i class="fa fa-user-circle"></i>
                    <span><%=name%></span>
                    <i class="fa fa-chevron-down"></i>
                </button>

                <div class="profile-dropdown" id="profileDropdown">

                    <a onclick="loadPage('staff_profile.jsp')">
                        <i class="fa fa-user"></i> My Profile
                    </a>

                    <a onclick="loadPage('staff_change_password.jsp')">
                        <i class="fa fa-lock"></i> Change Password
                    </a>

                    <a href="logout.jsp">
                        <i class="fa fa-right-from-bracket"></i> Logout
                    </a>

                </div>

            </div>

        </div>

        <div class="content-panel">
            <iframe id="contentFrame" name="contentFrame" src="staff_welcome.jsp"></iframe>
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

    document.getElementById("profileDropdown").style.display="none";
}

function toggleSidebar(){
    document.getElementById("sidebar").classList.toggle("collapsed");
}

function toggleProfileMenu(){
    const dropdown=document.getElementById("profileDropdown");
    dropdown.style.display =
        dropdown.style.display==="block" ? "none" : "block";
}

window.addEventListener("click",function(e){
    if(!e.target.closest(".profile-menu-wrapper")){
        document.getElementById("profileDropdown").style.display="none";
    }
});
</script>

</body>
</html>