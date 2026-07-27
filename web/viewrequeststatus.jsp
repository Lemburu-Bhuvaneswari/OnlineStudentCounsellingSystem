<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = (String) session.getAttribute("username");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>View Request Status</title>

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

.requests-card{
    background:#fff;
    border:1px solid #fce7f3;
    border-radius:24px;
    padding:26px;
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
    font-size:14px;
    color:#334155;
    background:#fff;
    border-bottom:1px solid #fce7f3;
    vertical-align:top;
    line-height:1.6;
}

tbody tr:hover td{
    background:#fdf2f8;
}

.issue-cell{
    min-width:280px;
    font-weight:500;
    color:#0f172a;
}

.remarks-cell{
    min-width:420px;
}

.date-cell{
    white-space:nowrap;
    font-weight:500;
}

.badge-status{
    padding:8px 14px;
    border-radius:999px;
    font-size:13px;
    font-weight:600;
    display:inline-block;
}

.pending{
    background:#fff7ed;
    color:#ea580c;
}

.completed{
    background:#dcfce7;
    color:#16a34a;
}

.resolved{
    background:#ede9fe;
    color:#7c3aed;
}

.other{
    background:#fee2e2;
    color:#dc2626;
}

.no-remarks{
    color:#94a3b8;
    font-style:italic;
}
</style>
</head>
<body>

<div class="page-title">
    <i class="fa-solid fa-clipboard-list"></i> My Counselling Requests
</div>

<div class="page-subtitle">
    Track the status and remarks of your submitted counselling requests
</div>

<div class="requests-card">

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Issue</th>
                    <th>Request Date</th>
                    <th>Remarks</th>
                    <th>Status</th>
                </tr>
            </thead>

            <tbody>

<%
try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT issue, request_date, status, " +
        "COALESCE(hod_remarks, remarks) AS final_remarks " +
        "FROM counselling_request " +
        "WHERE student_roll=? " +
        "ORDER BY request_date DESC"
    );

    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();

    int count = 1;

    while(rs.next()){
        String status = rs.getString("status");
%>

                <tr>
                    <td><%=count++%></td>

                    <td class="issue-cell">
                        <%=rs.getString("issue")%>
                    </td>

                    <td class="date-cell">
                        <%=rs.getString("request_date")%>
                    </td>

                    <td class="remarks-cell">
                        <%
                        String remarks = rs.getString("final_remarks");
                        if(remarks != null && !remarks.trim().isEmpty()){
                        %>
                            <%=remarks%>
                        <%
                        }else{
                        %>
                            <span class="no-remarks">Not updated</span>
                        <%
                        }
                        %>
                    </td>

                    <td>
                        <%
                        if("Pending".equalsIgnoreCase(status)){
                        %>
                            <span class="badge-status pending">Pending</span>
                        <%
                        }else if("Completed".equalsIgnoreCase(status)){
                        %>
                            <span class="badge-status completed">Completed</span>
                        <%
                        }else if("Resolved by HOD".equalsIgnoreCase(status)){
                        %>
                            <span class="badge-status resolved">Resolved by HOD</span>
                        <%
                        }else{
                        %>
                            <span class="badge-status other"><%=status%></span>
                        <%
                        }
                        %>
                    </td>
                </tr>

<%
    }

    rs.close();
    ps.close();
    con.close();

}catch(Exception e){
%>

<tr>
    <td colspan="5" style="color:red;">
        Error: <%=e.getMessage()%>
    </td>
</tr>

<%
}
%>

            </tbody>
        </table>
    </div>

</div>

</body>
</html>