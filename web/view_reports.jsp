<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String usertype = (String) session.getAttribute("usertype");
    String dname = (String) session.getAttribute("dname");
    if(usertype == null || !usertype.equals("hod")){
        response.sendRedirect("index.jsp");
        return;
    }

    int totalStudents = 0, totalCounsellingCompleted = 0, totalCounsellingPending = 0;
    int totalStaffActivities = 0, staffCompleted = 0, staffPending = 0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_counselling", "root", "root");

        Statement stmt = conn.createStatement();

        // Students
        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM student where department='"+dname+"'");
        if(rs.next()) totalStudents = rs.getInt(1);
        rs.close();

        rs = stmt.executeQuery("SELECT COUNT(*) FROM counselling_sessions c, student s WHERE c.`student_roll` = s.`rollno` and  c.status='Completed' and s.department='"+dname+"'");
        if(rs.next()) totalCounsellingCompleted = rs.getInt(1);
        rs.close();

        rs = stmt.executeQuery("SELECT COUNT(*) FROM counselling_sessions c, student s WHERE c.`student_roll` = s.`rollno` and  c.status='Pending' and s.department='"+dname+"'");
        if(rs.next()) totalCounsellingPending = rs.getInt(1);
        rs.close();

        // Staff activities
        rs = stmt.executeQuery("SELECT COUNT(*) FROM staff_activity");
        if(rs.next()) totalStaffActivities = rs.getInt(1);
        rs.close();

        rs = stmt.executeQuery("SELECT COUNT(*) FROM staff_activity WHERE status='Completed'");
        if(rs.next()) staffCompleted = rs.getInt(1);
        rs.close();

        rs = stmt.executeQuery("SELECT COUNT(*) FROM staff_activity WHERE status='Pending'");
        if(rs.next()) staffPending = rs.getInt(1);
        rs.close();

        stmt.close();
        conn.close();
    } catch(Exception e){
        out.println("Error: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reports</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
body{
    font-family:'Poppins', sans-serif;
    background:#f4f6f9;
    padding:20px;
}
.card{
    box-shadow:0 4px 10px rgba(0,0,0,0.1);
}
.report-title{
    margin-bottom:20px;
}
body{
    font-family:'Poppins', sans-serif;
    background:#f4f6f9;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
}
</style>
</head>
<body>

<div class="container-fluid">
    <h4 class="report-title">Counselling & Staff Reports</h4>

<!--    <div class="row g-4">
         Counselling Summary 
        <div class="col-md-6">-->
<div class="row">
    <div class="col-md-12">
<!--            <div class="card p-3">-->
<div class="card p-4">
    <h5 class="text-center">Student Counselling Summary</h5>

    <ul class="list-group list-group-flush mb-3 text-center">
        <li class="list-group-item">Total Students: <strong><%= totalStudents %></strong></li>
        <li class="list-group-item">Completed Counselling: <strong><%= totalCounsellingCompleted %></strong></li>
        <li class="list-group-item">Pending Counselling: <strong><%= totalCounsellingPending %></strong></li>
    </ul>

    <div class="d-flex justify-content-center">
        <div class="chart-container">
            <canvas id="counsellingChart"></canvas>
        </div>
    </div>
</div>
<!--         Staff Activity Summary 
        <div class="col-md-6">
            <div class="card p-3">
                <h5>Staff Activity Summary</h5>
                <ul class="list-group list-group-flush mb-3">
                    <li class="list-group-item">Total Activities: <strong><%= totalStaffActivities %></strong></li>
                    <li class="list-group-item">Completed: <strong><%= staffCompleted %></strong></li>
                    <li class="list-group-item">Pending: <strong><%= staffPending %></strong></li>
                </ul>
                <div class="chart-container">
                    <canvas id="staffChart"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>-->

<script>
    // Counselling Status Chart
    const ctx1 = document.getElementById('counsellingChart').getContext('2d');
    const counsellingChart = new Chart(ctx1, {
        type: 'doughnut',
        data: {
            labels: ['Completed', 'Pending'],
            datasets: [{
                data: [<%= totalCounsellingCompleted %>, <%= totalCounsellingPending %>],
                backgroundColor: ['#28a745', '#ffc107']
            }]
        },
        options: {
            responsive:true,
            plugins: { legend: { position:'bottom' } }
        }
    });

    // Staff Activity Chart
//    const ctx2 = document.getElementById('staffChart').getContext('2d');
//    const staffChart = new Chart(ctx2, {
//        type: 'doughnut',
//        data: {
//            labels: ['Completed', 'Pending'],
//            datasets: [{
//                data: [<%= staffCompleted %>, <%= staffPending %>],
//                backgroundColor: ['#28a745', '#ffc107']
//            }]
//        },
//        options: {
//            responsive:true,
//            plugins: { legend: { position:'bottom' } }
//        }
//    });
</script>

</body>
</html>