<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = (String) session.getAttribute("username");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}

String name = "", email = "", department = "", year = "", counsellor = "";

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT s.name, s.email, s.department, s.year, " +
        "st.name AS counsellor_name " +
        "FROM student s " +
        "LEFT JOIN staff st ON s.assigned_staff = st.email " +
        "WHERE s.rollno=?"
    );

    ps.setString(1, username);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        name = rs.getString("name");
        email = rs.getString("email");
        department = rs.getString("department");
        year = rs.getString("year");
        counsellor = rs.getString("counsellor_name") != null
            ? rs.getString("counsellor_name")
            : "Not Assigned";
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
<title>Student Profile</title>

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
    background:transparent;
    padding:20px;
}

.profile-card{
    max-width:950px;
    margin:auto;
    background:#ffffff;
    padding:35px;
    border-radius:24px;
    box-shadow:0 10px 30px rgba(236,72,153,.08);
    border:1px solid #f3e8ff;
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
    background:linear-gradient(135deg,#ff2d95,#ff006a);
    display:flex;
    align-items:center;
    justify-content:center;
    color:white;
    font-size:28px;
    box-shadow:0 10px 20px rgba(255,0,106,.20);
}

.heading{
    font-size:38px;
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
    background:#fdf2f8;
    padding:18px;
    border-radius:18px;
    border:1px solid #fbcfe8;
}

.field label{
    display:block;
    font-size:13px;
    font-weight:600;
    color:#64748b;
    margin-bottom:8px;
    text-transform:uppercase;
}

.field p{
    font-size:17px;
    font-weight:600;
    color:#0f172a;
    margin:0;
}

.full-width{
    grid-column:span 2;
}

.action-area{
    margin-top:30px;
    text-align:right;
}

.btn-password{
    display:inline-flex;
    align-items:center;
    gap:10px;
    padding:14px 24px;
    border-radius:14px;
    text-decoration:none;
    background:linear-gradient(135deg,#ff2d95,#ff006a);
    color:#fff;
    font-weight:600;
    transition:.3s;
}

.btn-password:hover{
    transform:translateY(-2px);
    box-shadow:0 10px 20px rgba(255,0,106,.20);
}

</style>
</head>
<body>

<div class="profile-card">

    <div class="heading-wrap">
        <div class="profile-icon">
            <i class="fa fa-user-graduate"></i>
        </div>
        <div>
            <h1 class="heading">My Profile</h1>
            <div class="subtext">View your academic and counselling details</div>
        </div>
    </div>

    <div class="grid">

        <div class="field">
            <label>Name</label>
            <p><%=name%></p>
        </div>

        <div class="field">
            <label>Email</label>
            <p><%=email%></p>
        </div>

        <div class="field">
            <label>Department</label>
            <p><%=department%></p>
        </div>

        <div class="field">
            <label>Year</label>
            <p><%=year%></p>
        </div>

        <div class="field full-width">
            <label>Assigned Counsellor</label>
            <p><%=counsellor%></p>
        </div>

    </div>

    <div class="action-area">
        <a href="tudent_change_password.jsp" class="btn-password">
            <i class="fa fa-key"></i>
            Change Password
        </a>
    </div>

</div>

</body>
</html>