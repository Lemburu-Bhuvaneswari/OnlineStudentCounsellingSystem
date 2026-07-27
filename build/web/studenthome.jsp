<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String username = (String)session.getAttribute("username");
if(username == null){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Student Dashboard</title>

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
    background:#fdf2f8;
    padding:8px;
    height:100vh;
    overflow:hidden;
}

.dashboard-wrapper{
    display:flex;
    gap:12px;
    height:calc(100vh - 16px);
}

.sidebar{
    width:250px;
    background:#fff;
    border-radius:24px;
    padding:14px;
    box-shadow:0 8px 24px rgba(236,72,153,.10);
    display:flex;
    flex-direction:column;
}

.logo-card{
    background:linear-gradient(135deg,#ff2d95,#ff006a);
    border-radius:20px;
    padding:18px 16px;
    color:#fff;
    display:flex;
    align-items:center;
    gap:14px;
    margin-bottom:14px;
}

.logo-icon{
    width:52px;
    height:52px;
    border-radius:16px;
    background:rgba(255,255,255,.15);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:22px;
}

.logo-card h2{
    font-size:20px;
    font-weight:700;
}

.menu-title{
    font-size:12px;
    font-weight:700;
    color:#94a3b8;
    margin:10px 12px 8px;
    text-transform:uppercase;
}

.sidebar a{
    text-decoration:none;
    color:#0f172a;
    padding:12px 14px;
    border-radius:14px;
    display:flex;
    align-items:center;
    gap:12px;
    font-weight:500;
    font-size:15px;
    margin-bottom:6px;
    transition:.3s;
    cursor:pointer;
}

.sidebar a:hover,
.sidebar a.active{
    background:linear-gradient(90deg,#ff2d95,#ff006a);
    color:#fff;
}

.sidebar a i{
    width:18px;
}

.main-content{
    flex:1;
    display:flex;
    flex-direction:column;
    gap:12px;
}

.topbar{
    background:#fff;
    border-radius:24px;
    padding:14px 22px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 8px 24px rgba(236,72,153,.08);
}

.topbar h2{
    font-size:18px;
    font-weight:700;
}

.content-panel{
    flex:1;
    background:#fff;
    border-radius:24px;
    padding:18px;
    box-shadow:0 8px 24px rgba(236,72,153,.08);
    overflow:hidden;
}

iframe{
    width:100%;
    height:100%;
    border:none;
}

.profile-dropdown{
    position:relative;
}

.profile-btn{
    border:none;
    background:linear-gradient(135deg,#ff2d95,#ff006a);
    color:#fff;
    padding:10px 18px;
    border-radius:16px;
    font-weight:600;
    font-size:14px;
    display:flex;
    align-items:center;
    gap:8px;
    cursor:pointer;
}

.dropdown-menu{
    position:absolute;
    top:110%;
    right:0;
    background:#fff;
    min-width:180px;
    border-radius:16px;
    box-shadow:0 15px 35px rgba(0,0,0,.10);
    padding:8px;
    display:none;
    z-index:1000;
}

.dropdown-menu a{
    display:flex;
    align-items:center;
    gap:10px;
    padding:11px 14px;
    text-decoration:none;
    color:#0f172a;
    border-radius:12px;
    font-weight:500;
    font-size:14px;
}

.dropdown-menu a:hover{
    background:#fdf2f8;
    color:#ff006a;
}

.dropdown-menu.show{
    display:block;
}
</style>

<script>
function toggleDropdown(){
    document.getElementById("profileMenu").classList.toggle("show");
}

window.onclick = function(event){
    if(!event.target.closest('.profile-dropdown')){
        document.getElementById("profileMenu").classList.remove("show");
    }
}

function loadPage(page, element){
    document.getElementById("contentFrame").src = page;

    document.querySelectorAll(".sidebar a").forEach(link=>{
        link.classList.remove("active");
    });

    if(element){
        element.classList.add("active");
    }
}
</script>

</head>
<body>

<div class="dashboard-wrapper">

    <div class="sidebar">

        <div class="logo-card">
            <div class="logo-icon">
                <i class="fa-solid fa-user-graduate"></i>
            </div>
            <h2>Student Panel</h2>
        </div>

        <div class="menu-title">Main</div>

        <a class="active" onclick="loadPage('student_welcome.jsp', this)">
            <i class="fa-solid fa-house"></i> Dashboard
        </a>

        <div class="menu-title">Services</div>

        <a onclick="loadPage('view_assigned_staff.jsp', this)">
            <i class="fa-solid fa-user-group"></i> My Counsellor
        </a>

        <a onclick="loadPage('view_student_status.jsp', this)">
            <i class="fa-solid fa-comments"></i> Counselling Status
        </a>

        <a onclick="loadPage('student_upcoming_session.jsp', this)">
            <i class="fa-solid fa-calendar-days"></i> Upcoming Sessions
        </a>

        <a onclick="loadPage('postCounsellingRequest.jsp', this)">
            <i class="fa-solid fa-paper-plane"></i> Post Request
        </a>

        <a onclick="loadPage('viewrequeststatus.jsp', this)">
            <i class="fa-solid fa-envelope-open-text"></i> Request Status
        </a>

        <div class="menu-title">Settings</div>

        <a onclick="loadPage('student_change_password.jsp', this)">
            <i class="fa-solid fa-key"></i> Change Password
        </a>
        
        <a href="logout.jsp">
    <i class="fa-solid fa-right-from-bracket"></i> Logout
</a>

    </div>

    <div class="main-content">

        <div class="topbar">
            <h2>Online Student Counselling System</h2>

            <div class="profile-dropdown">
                <button class="profile-btn" onclick="toggleDropdown()">
                    <i class="fa-solid fa-user"></i>
                    <%=username%>
                    <i class="fa-solid fa-chevron-down"></i>
                </button>

                <div class="dropdown-menu" id="profileMenu">
                    <a onclick="loadPage('student_profile.jsp')">
                        <i class="fa-solid fa-id-card"></i> Profile
                    </a>

                    <a href="logout.jsp">
                        <i class="fa-solid fa-right-from-bracket"></i> Logout
                    </a>
                </div>
            </div>
        </div>

        <div class="content-panel">
            <iframe id="contentFrame" src="student_welcome.jsp"></iframe>
        </div>

    </div>

</div>

</body>
</html>