<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = (String) session.getAttribute("username");
if(username == null){
    response.sendRedirect("index.jsp");
    return;
}

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling", "root", "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT s.rollno, s.name AS student_name, st.name AS staff_name, " +
        "st.email AS staff_email, st.department " +
        "FROM student s " +
        "JOIN staff st ON s.assigned_staff = st.email " +
        "WHERE s.rollno=?"
    );
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<title>My Counsellor</title>

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
    padding:8px;
}

.page-title{
    font-size:28px;
    font-weight:700;
    color:#0f172a;
    margin-bottom:6px;
}

.page-subtitle{
    color:#64748b;
    margin-bottom:24px;
    font-size:15px;
}

.staff-card{
    background:#fff;
    border:1px solid #fce7f3;
    border-radius:24px;
    padding:28px;
    box-shadow:0 8px 24px rgba(236,72,153,.08);
}

.table-wrap{
    overflow-x:auto;
}

table{
    width:100%;
    border-collapse:separate;
    border-spacing:0;
    overflow:hidden;
    border-radius:18px;
}

thead{
    background:linear-gradient(90deg,#ff2d95,#ff006a);
    color:#fff;
}

th{
    padding:16px 18px;
    font-size:14px;
    font-weight:600;
    text-align:left;
}

td{
    padding:18px;
    font-size:15px;
    color:#334155;
    background:#fff;
    border-bottom:1px solid #fce7f3;
}

tbody tr:hover td{
    background:#fdf2f8;
    transition:.3s;
}

.staff-name{
    font-weight:600;
    color:#0f172a;
}

.badge-dept{
    background:#fce7f3;
    color:#db2777;
    padding:6px 12px;
    border-radius:999px;
    font-size:13px;
    font-weight:600;
    display:inline-block;
}
</style>
</head>
<body>

<div class="page-title">
    <i class="fa-solid fa-user-group"></i> My Assigned Counsellor
</div>

<div class="page-subtitle">
    View your assigned counselling staff details
</div>

<div class="staff-card">

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>Staff Name</th>
                    <th>Email Address</th>
                    <th>Department</th>
                </tr>
            </thead>
            <tbody>

            <%
            boolean found = false;
            while(rs.next()){
                found = true;
            %>

                <tr>
                    <td class="staff-name"><%= rs.getString("staff_name") %></td>
                    <td><%= rs.getString("staff_email") %></td>
                    <td>
                        <span class="badge-dept">
                            <%= rs.getString("department") %>
                        </span>
                    </td>
                </tr>

            <%
            }

            if(!found){
            %>

                <tr>
                    <td colspan="3" style="text-align:center;color:#94a3b8;padding:24px;">
                        No counsellor assigned yet.
                    </td>
                </tr>

            <%
            }

            rs.close();
            ps.close();
            con.close();
            %>

            </tbody>
        </table>
    </div>

</div>

</body>
</html>

<%
} catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>