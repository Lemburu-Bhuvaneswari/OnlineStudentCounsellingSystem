<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String id=request.getParameter("id");

Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/student_counselling","root","root");

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM hod WHERE hod_id=?");

ps.setString(1,id);

ResultSet rs=ps.executeQuery();

if(!rs.next()){
    out.println("<h3>HOD Not Found</h3>");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit HOD</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
<%@ include file="admin_edit_common_style.css" %>
</style>
</head>
<body>

<div class="edit-container">
    <div class="edit-header">
        <i class="fa fa-user-tie"></i> Edit HOD
    </div>

    <form action="admin_edit_hod_action.jsp" method="post" class="edit-body">

        <input type="hidden" name="hod_id" value="<%=rs.getInt("hod_id")%>">

        <div class="form-group">
            <label>Name</label>
            <div class="input-box">
                <i class="fa fa-user"></i>
                <input type="text" name="name" value="<%=rs.getString("name")%>" required>
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
            <label>Email</label>
            <div class="input-box">
                <i class="fa fa-envelope"></i>
                <input type="email" name="email" value="<%=rs.getString("email")%>" required>
            </div>
        </div>

        <div class="form-group">
            <label>Phone</label>
            <div class="input-box">
                <i class="fa fa-phone"></i>
                <input type="text" name="phone" value="<%=rs.getString("phone")%>"
                       maxlength="10" pattern="[0-9]{10}"
                       oninput="this.value=this.value.replace(/[^0-9]/g,'')" required>
            </div>
        </div>

        <div class="btn-row">
            <button type="button" onclick="parent.loadPage('view_hod.jsp')" class="btn-cancel">Cancel</button>
            <button type="submit" class="btn-save">Update</button>
        </div>

    </form>
</div>

</body>
</html>