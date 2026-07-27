<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String usertype = (String) session.getAttribute("usertype");
    if(usertype == null || !usertype.equals("hod")){
        response.sendRedirect("index.jsp");
        return;
    }

    String idParam = request.getParameter("id");
    if(idParam == null){
        response.sendRedirect("view_department_students.jsp");
        return;
    }

    int studentId = Integer.parseInt(idParam);
    String name = "", email = "", department = "", year = "", phone = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/student_counselling",
            "root",
            "root"
        );

        PreparedStatement ps = conn.prepareStatement(
            "SELECT name,email,department,year,phone FROM student WHERE student_id=?"
        );
        ps.setInt(1, studentId);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            name = rs.getString("name");
            email = rs.getString("email");
            department = rs.getString("department");
            year = rs.getString("year");
            phone = rs.getString("phone");
        }else{
            response.sendRedirect("view_department_students.jsp");
            return;
        }

        rs.close();
        ps.close();
        conn.close();

    } catch(Exception e){
        out.println("Error: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
    padding:30px 20px;
}

.edit-wrapper{
    max-width:620px;
    margin:auto;
    background:#fff;
    border-radius:24px;
    overflow:hidden;
    box-shadow:
        0 12px 30px rgba(124,58,237,.08),
        0 4px 10px rgba(0,0,0,.04);
    border:1px solid #ececf1;
}

/* HEADER */
.edit-header{
    background:linear-gradient(90deg,#4f46e5,#9333ea);
    padding:20px 26px;
    color:#fff;
    display:flex;
    align-items:center;
    gap:14px;
    font-size:24px;
    font-weight:600;
}

.edit-header i{
    width:46px;
    height:46px;
    border-radius:14px;
    background:rgba(255,255,255,.15);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:20px;
}

/* FORM BODY */
.form-body{
    padding:28px;
}

.form-group{
    margin-bottom:20px;
}

.form-label{
    display:block;
    font-size:14px;
    font-weight:500;
    margin-bottom:8px;
    color:#374151;
}

.input-box{
    position:relative;
}

.input-box i{
    position:absolute;
    left:14px;
    top:50%;
    transform:translateY(-50%);
    color:#9333ea;
    font-size:14px;
}

.input-box input,
.input-box select{
    width:100%;
    padding:14px 14px 14px 44px;
    border:1px solid #dbe2ea;
    border-radius:14px;
    font-size:14px;
    outline:none;
    transition:.25s;
}

.input-box input:focus,
.input-box select:focus{
    border-color:#9333ea;
    box-shadow:0 0 0 4px rgba(147,51,234,.08);
}

/* BUTTONS */
.btn-row{
    display:flex;
    justify-content:space-between;
    gap:14px;
    margin-top:28px;
}

.btn{
    flex:1;
    padding:14px;
    border:none;
    border-radius:14px;
    font-size:15px;
    font-weight:600;
    cursor:pointer;
    text-decoration:none;
    display:flex;
    align-items:center;
    justify-content:center;
    gap:10px;
    transition:.25s;
}

.btn-cancel{
    background:#f8fafc;
    border:1px solid #dbe2ea;
    color:#475569;
}

.btn-cancel:hover{
    background:#eef2f7;
}

.btn-update{
    background:#16a34a;
    color:#fff;
}

.btn-update:hover{
    background:#15803d;
}
</style>
</head>
<body>

<div class="edit-wrapper">

    <div class="edit-header">
        <i class="fa fa-user-edit"></i>
        Edit Student
    </div>

    <div class="form-body">

        <form action="edit_student_action.jsp" method="post">

            <input type="hidden" name="id" value="<%= studentId %>">

            <div class="form-group">
                <label class="form-label">Name</label>
                <div class="input-box">
                    <i class="fa fa-user"></i>
                    <input type="text" name="name" value="<%= name %>" required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Email</label>
                <div class="input-box">
                    <i class="fa fa-envelope"></i>
                    <input type="email" name="email" value="<%= email %>" required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Phone Number</label>
                <div class="input-box">
                    <i class="fa fa-phone"></i>
                    <input type="text" name="phone" value="<%= phone %>" required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Department</label>
                <div class="input-box">
                    <i class="fa fa-building"></i>
                    <input type="text" name="department" value="<%= department %>" required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Year</label>
                <div class="input-box">
                    <i class="fa fa-calendar"></i>
                    <select name="year" required>
                        <option value="1" <%= year.equals("1")?"selected":"" %>>1st Year</option>
                        <option value="2" <%= year.equals("2")?"selected":"" %>>2nd Year</option>
                        <option value="3" <%= year.equals("3")?"selected":"" %>>3rd Year</option>
                        <option value="4" <%= year.equals("4")?"selected":"" %>>4th Year</option>
                    </select>
                </div>
            </div>

            <div class="btn-row">
                <a href="view_department_students.jsp" class="btn btn-cancel">
                    Cancel
                </a>

                <button type="submit" class="btn btn-update">
                    <i class="fa fa-save"></i>
                    Update
                </button>
            </div>

        </form>

    </div>
</div>

</body>
</html>