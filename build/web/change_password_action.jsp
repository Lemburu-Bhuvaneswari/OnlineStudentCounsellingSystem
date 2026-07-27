<%@page import="java.sql.*"%>
<%
String usertype = (String) session.getAttribute("usertype");

if (usertype == null) {
    response.sendRedirect("index.jsp");
    return;
}

String oldpass = request.getParameter("current_password");
String newpass = request.getParameter("new_password");
String confpass = request.getParameter("confirm_password");

String username = (String) session.getAttribute("username");

String table = null;
String redirectPage = null;
String userColumn = null;

String message = "";
String type = "error";

if(!newpass.equals(confpass)){
    message = "New Password and Confirm Password do not match.";
}
else{

    if(usertype.equalsIgnoreCase("admin")){
        userColumn = "username";
        table = "admin";
        redirectPage = "change_password.jsp";
    }
    else if(usertype.equalsIgnoreCase("hod")){
        userColumn = "email";
        table = "hod";
        redirectPage = "hod_welcome.jsp";
    }
    else if(usertype.equalsIgnoreCase("staff")){
        userColumn = "email";
        table = "staff";
        redirectPage = "staff_welcome.jsp";
    }
    else if(usertype.equalsIgnoreCase("student")){
        userColumn = "rollno";
        table = "student";
        redirectPage = "student_welcome.jsp";
    }

    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/student_counselling",
            "root",
            "root"
        );

        PreparedStatement check = con.prepareStatement(
            "SELECT * FROM " + table + " WHERE " + userColumn + "=? AND password=?"
        );

        check.setString(1, username);
        check.setString(2, oldpass);

        ResultSet rs = check.executeQuery();

        if(rs.next()){

            PreparedStatement ps = con.prepareStatement(
                "UPDATE " + table + " SET password=? WHERE " + userColumn + "=?"
            );

            ps.setString(1, newpass);
            ps.setString(2, username);

            ps.executeUpdate();

            type = "success";
            message = "Password Changed Successfully!";

            ps.close();

        }else{
            message = "Current Password is Incorrect.";
        }

        rs.close();
        check.close();
        con.close();

    }catch(Exception e){
        message = "Error: " + e.getMessage();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Password Update Status</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

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
    background:linear-gradient(135deg,#eef2ff,#f3e8ff);
    height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
}

.status-card{
    width:420px;
    background:#fff;
    border-radius:24px;
    padding:35px;
    text-align:center;
    box-shadow:0 15px 35px rgba(124,58,237,0.18);
    border:1px solid #e5e7eb;
}

.icon-box{
    width:80px;
    height:80px;
    margin:auto;
    border-radius:50%;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:34px;
    margin-bottom:20px;
}

.success{
    background:#dcfce7;
    color:#16a34a;
}

.error{
    background:#fee2e2;
    color:#dc2626;
}

h2{
    font-size:24px;
    font-weight:700;
    margin-bottom:12px;
    color:#0f172a;
}

p{
    font-size:15px;
    color:#64748b;
    margin-bottom:25px;
}

.btn-back{
    display:inline-block;
    padding:12px 26px;
    border-radius:14px;
    text-decoration:none;
    font-weight:600;
    color:#fff;
    background:linear-gradient(90deg,#2563eb,#a21caf);
    box-shadow:0 8px 20px rgba(124,58,237,0.25);
}
</style>
</head>
<body>

<div class="status-card">

    <div class="icon-box <%=type%>">
        <% if(type.equals("success")){ %>
            <i class="fa fa-check"></i>
        <% } else { %>
            <i class="fa fa-times"></i>
        <% } %>
    </div>

    <h2><%= type.equals("success") ? "Success" : "Error" %></h2>
    <p><%= message %></p>

    <% if(type.equals("success")){ %>
        <script>
            setTimeout(function(){
                window.location = "change_password.jsp";
            }, 2000);
        </script>
    <% } else { %>
        <a href="change_password.jsp" class="btn-back">Go Back</a>
    <% } %>

</div>

</body>
</html>