<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String usertype = (String) session.getAttribute("usertype");
String username = (String) session.getAttribute("username");

if(usertype == null || !usertype.equals("student")){
    response.sendRedirect("index.jsp");
    return;
}

try {
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    String sql =
        "SELECT s.rollno, s.name, " +
        "SUM(CASE WHEN c.status='Completed' THEN 1 ELSE 0 END) AS completed_sessions, " +
        "SUM(CASE WHEN c.status='Pending' THEN 1 ELSE 0 END) AS pending_sessions, " +
        "COUNT(c.session_id) AS total_sessions " +
        "FROM student s " +
        "LEFT JOIN counselling_sessions c ON s.rollno = c.student_roll " +
        "WHERE s.rollno=? " +
        "GROUP BY s.rollno, s.name";

    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, username);

    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<title>Counselling Status</title>

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
    font-size:15px;
    color:#64748b;
    margin-bottom:24px;
}

.status-card{
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
    border-radius:18px;
    overflow:hidden;
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

.rollno{
    font-weight:600;
    color:#0f172a;
}

.badge-completed{
    background:#dcfce7;
    color:#16a34a;
    padding:6px 12px;
    border-radius:999px;
    font-weight:600;
    font-size:13px;
}

.badge-pending{
    background:#ffedd5;
    color:#ea580c;
    padding:6px 12px;
    border-radius:999px;
    font-weight:600;
    font-size:13px;
}

.badge-total{
    background:#fce7f3;
    color:#db2777;
    padding:6px 12px;
    border-radius:999px;
    font-weight:600;
    font-size:13px;
}
</style>
</head>
<body>

<div class="page-title">
    <i class="fa-solid fa-chart-line"></i> Counselling Status
</div>

<div class="page-subtitle">
    Track your completed and pending counselling sessions
</div>

<div class="status-card">

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>Roll Number</th>
                    <th>Student Name</th>
                    <th>Completed</th>
                    <th>Pending</th>
                    <th>Total Sessions</th>
                </tr>
            </thead>
            <tbody>

            <%
            while(rs.next()){
            %>
                <tr>
                    <td class="rollno"><%= rs.getString("rollno") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td>
                        <span class="badge-completed">
                            <%= rs.getInt("completed_sessions") %>
                        </span>
                    </td>
                    <td>
                        <span class="badge-pending">
                            <%= rs.getInt("pending_sessions") %>
                        </span>
                    </td>
                    <td>
                        <span class="badge-total">
                            <%= rs.getInt("total_sessions") %>
                        </span>
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