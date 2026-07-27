<%@page import="java.sql.*"%>

<%
String username = (String)session.getAttribute("username");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}

String name = "";
String department = "";
String phone = "";
String email = "";

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root");

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM hod WHERE email=?");

    ps.setString(1, username);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        name = rs.getString("name");
        department = rs.getString("department");
        phone = rs.getString("phone");
        email = rs.getString("email");
    }

    rs.close();
    ps.close();
    con.close();

}catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOD Profile</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:transparent;
    padding:20px;
}

.profile-card{
    max-width:950px;
    margin:auto;
    background:#ffffff;
    padding:35px;
    border-radius:24px;
    box-shadow:0 10px 30px rgba(0,0,0,.08);
    border:1px solid #e2e8f0;
}

.heading-wrap{
    display:flex;
    align-items:center;
    gap:18px;
    margin-bottom:30px;
}

.profile-icon{
    width:70px;
    height:70px;
    border-radius:20px;
    background:linear-gradient(135deg,#6366f1,#7c3aed);
    display:flex;
    align-items:center;
    justify-content:center;
    color:white;
    font-size:28px;
    box-shadow:0 10px 20px rgba(124,58,237,.25);
}

.heading{
    font-size:42px;
    font-weight:700;
    color:#0f172a;
    margin:0;
}

.subtext{
    color:#64748b;
    font-size:15px;
    margin-top:4px;
}

.grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:22px;
}

.field{
    background:#f8fafc;
    padding:18px;
    border-radius:18px;
    border:1px solid #e2e8f0;
}

.field label{
    display:block;
    font-size:13px;
    font-weight:600;
    color:#64748b;
    margin-bottom:8px;
    text-transform:uppercase;
}

.field input{
    width:100%;
    border:none;
    background:transparent;
    font-size:17px;
    font-weight:600;
    color:#0f172a;
    outline:none;
}

.field input[readonly]{
    color:#64748b;
}

.save-btn{
    margin-top:35px;
    border:none;
    background:linear-gradient(135deg,#6366f1,#7c3aed);
    color:white;
    padding:14px 40px;
    border-radius:14px;
    font-size:15px;
    font-weight:600;
    cursor:pointer;
    transition:.25s;
}

.save-btn:hover{
    transform:translateY(-2px);
    box-shadow:0 10px 20px rgba(124,58,237,.25);
}
</style>
</head>
<body>

<div class="profile-card">

    <div class="heading-wrap">
        <div class="profile-icon">
            <i class="fa fa-user"></i>
        </div>
        <div>
            <h1 class="heading">My Profile</h1>
            <div class="subtext">Manage your HOD account details</div>
        </div>
    </div>

    <form action="update_hod_profile.jsp" method="post" onsubmit="return validateForm()">

        <div class="grid">

            <div class="field">
                <label>Name</label>
                <input type="text"
                       id="name"
                       name="name"
                       value="<%=name%>"
                       maxlength="50"
                       required>
            </div>

            <div class="field">
                <label>Department</label>
                <input type="text" value="<%=department%>" readonly>
            </div>

            <div class="field">
                <label>Phone</label>
                <input type="text"
                       id="phone"
                       name="phone"
                       value="<%=phone%>"
                       maxlength="10"
                       required>
            </div>

            <div class="field">
                <label>Email</label>
                <input type="email" value="<%=email%>" readonly>
            </div>

        </div>

        <center>
            <button type="submit" class="save-btn">
                <i class="fa fa-save"></i> Save Changes
            </button>
        </center>

    </form>

</div>

<script>
function validateForm(){

    const name = document.getElementById("name").value.trim();
    const phone = document.getElementById("phone").value.trim();

    const nameRegex = /^[A-Za-z ]+$/;
    const phoneRegex = /^[0-9]{10}$/;

    if(!nameRegex.test(name)){
        alert("Name should contain only letters and spaces.");
        return false;
    }

    if(name.length < 2){
        alert("Name must be at least 2 characters.");
        return false;
    }

    if(!phoneRegex.test(phone)){
        alert("Phone number must be exactly 10 digits.");
        return false;
    }

    return true;
}
</script>

</body>
</html>