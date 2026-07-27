<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String usertype = (String) session.getAttribute("usertype");
    if(usertype == null || !usertype.equals("hod")){
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Staff Activity</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:#f4f6f9;
    padding:20px;
}
.card{
    box-shadow:0 4px 10px rgba(0,0,0,0.1);
}
.table-wrapper{
    max-height:75vh;
    overflow-y:auto;
}
.search-box{
    max-width:300px;
}
.status-completed{
    color:green;
    font-weight:600;
}
.status-pending{
    color:orange;
    font-weight:600;
}
.status-inprogress{
    color:blue;
    font-weight:600;
}
</style>

</head>
<body>

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4>Staff Activity Logs</h4>
        <input type="text" id="searchInput" class="form-control search-box" placeholder="Search staff or activity...">
    </div>

    <div class="card">
        <div class="card-body table-wrapper">
            <table class="table table-hover table-striped">
                <thead class="table-primary">
                    <tr>
                        <th>#</th>
                        <th>Staff Name</th>
                        <th>Activity</th>
                        <th>Student Name</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_counselling", "root", "root");
                        Statement stmt = conn.createStatement();

                        String sql = "SELECT staff_name, activity, student_name, date, status FROM staff_activity ORDER BY date DESC";
                        ResultSet rs = stmt.executeQuery(sql);

                        int count = 1;
                        while(rs.next()){
                            String staffName = rs.getString("staff_name");
                            String activity = rs.getString("activity");
                            String studentName = rs.getString("student_name");
                            String date = rs.getString("date");
                            String status = rs.getString("status");

                            String statusClass = "";
                            if("Completed".equalsIgnoreCase(status)) statusClass = "status-completed";
                            else if("Pending".equalsIgnoreCase(status)) statusClass = "status-pending";
                            else if("In-progress".equalsIgnoreCase(status)) statusClass = "status-inprogress";
                %>
                    <tr>
                        <td><%= count++ %></td>
                        <td><%= staffName %></td>
                        <td><%= activity %></td>
                        <td><%= studentName != null ? studentName : "-" %></td>
                        <td><%= date != null ? date : "-" %></td>
                        <td class="<%= statusClass %>"><%= status != null ? status : "Pending" %></td>
                    </tr>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch(Exception e){
                        out.println("<tr><td colspan='6'>Error: "+ e.getMessage() +"</td></tr>");
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    // Live search filter
    const searchInput = document.getElementById('searchInput');
    searchInput.addEventListener('keyup', function(){
        const filter = searchInput.value.toLowerCase();
        const rows = document.querySelectorAll('tbody tr');
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(filter) ? '' : 'none';
        });
    });
</script>

</body>
</html>