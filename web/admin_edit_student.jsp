<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String id=request.getParameter("id");

Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/student_counselling","root","root");

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM student WHERE student_id=?");

ps.setString(1,id);

ResultSet rs=ps.executeQuery();

if(!rs.next()){
    out.println("<h3>Student Not Found</h3>");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Student</title>

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

.edit-container{
    max-width:760px;
    margin:auto;
    background:#fff;
    border-radius:24px;
    overflow:hidden;
    box-shadow:0 12px 35px rgba(0,0,0,.08);
}

.edit-header{
    background:linear-gradient(90deg,#0d6efd,#06b6d4);
    color:#fff;
    padding:22px 30px;
    font-size:28px;
    font-weight:700;
    display:flex;
    align-items:center;
    gap:14px;
}

.edit-body{
    padding:32px;
}

.form-group{
    margin-bottom:22px;
}

.form-group label{
    display:block;
    margin-bottom:8px;
    font-weight:600;
    color:#334155;
}

.input-box{
    position:relative;
}

.input-box i{
    position:absolute;
    left:18px;
    top:50%;
    transform:translateY(-50%);
    color:#0d6efd;
    font-size:15px;
}

.input-box input,
.input-box select{
    width:100%;
    padding:15px 18px 15px 48px;
    border:1px solid #dbe2ea;
    border-radius:16px;
    font-size:15px;
    outline:none;
}

.input-box input:focus,
.input-box select:focus{
    border-color:#0d6efd;
    box-shadow:0 0 0 4px rgba(13,110,253,.08);
}

.btn-row{
    display:flex;
    gap:16px;
    margin-top:30px;
}

.btn-cancel,
.btn-save{
    flex:1;
    border:none;
    padding:15px;
    border-radius:16px;
    font-weight:600;
    font-size:16px;
    cursor:pointer;
}

.btn-cancel{
    background:#e2e8f0;
    color:#334155;
}

.btn-save{
    background:#16a34a;
    color:#fff;
}
</style>
</head>
<body>

<div class="edit-container">

    <div class="edit-header">
        <i class="fa fa-user-edit"></i>
        Edit Student
    </div>

    <form action="admin_edit_student_action.jsp" method="post" class="edit-body">

        <input type="hidden" name="student_id" value="<%=rs.getInt("student_id")%>">

        <div class="form-group">
            <label>Name</label>
            <div class="input-box">
                <i class="fa fa-user"></i>
                <input type="text" name="name" value="<%=rs.getString("name")%>" required>
            </div>
        </div>

        <div class="form-group">
            <label>Roll Number</label>
            <div class="input-box">
                <i class="fa fa-id-card"></i>
                <input type="text" name="rollno" value="<%=rs.getString("rollno")%>" required>
            </div>
        </div>

        <div class="form-group">
            <label>Email</label>
            <div class="input-box">
                <i class="fa fa-envelope"></i>
                <input type="email"
                       name="email"
                       value="<%=rs.getString("email")%>"
                       pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"
                       required>
            </div>
        </div>

        <div class="form-group">
            <label>Phone Number</label>
            <div class="input-box">
                <i class="fa fa-phone"></i>
                <input type="text"
                       name="phone"
                       value="<%=rs.getString("phone")%>"
                       maxlength="10"
                       pattern="[0-9]{10}"
                       oninput="this.value=this.value.replace(/[^0-9]/g,'')"
                       required>
            </div>
        </div>

        <div class="form-group">
            <label>Department</label>
            <div class="input-box">
                <i class="fa fa-building"></i>
                <input type="text" name="department" value="<%=rs.getString("department")%>" required>
            </div>
        </div>

        <div class="form-group">
            <label>Year</label>
            <div class="input-box">
                <i class="fa fa-calendar"></i>
                <select name="year" required>
                    <option value="1" <%=rs.getString("year").equals("1")?"selected":""%>>1</option>
                    <option value="2" <%=rs.getString("year").equals("2")?"selected":""%>>2</option>
                    <option value="3" <%=rs.getString("year").equals("3")?"selected":""%>>3</option>
                    <option value="4" <%=rs.getString("year").equals("4")?"selected":""%>>4</option>
                </select>
            </div>
        </div>

        <div class="btn-row">
            <button type="button"
                    onclick="parent.loadPage('view_students.jsp')"
                    class="btn-cancel">
                Cancel
            </button>

            <button type="submit" class="btn-save">
                <i class="fa fa-floppy-disk"></i> Update
            </button>
        </div>

    </form>

</div>

</body>
</html>