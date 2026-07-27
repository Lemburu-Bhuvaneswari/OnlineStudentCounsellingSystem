<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = (String) session.getAttribute("username");
if(username == null){
    response.sendRedirect("index.jsp");
    return;
}

String idParam = request.getParameter("id");
if(idParam == null){
    response.sendRedirect("view_assigned_students.jsp");
    return;
}

int studentId = Integer.parseInt(idParam);

// Initialize student details
String studentName = "", studentEmail = "", studentDepartment = "", studentYear = "";

int staffId = 0;

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling", "root", "root");

    // Get staff_id of logged-in user
    PreparedStatement psStaff = con.prepareStatement(
        "SELECT staff_id FROM staff WHERE email=?");
    psStaff.setString(1, username);
    ResultSet rsStaff = psStaff.executeQuery();
    if(rsStaff.next()){
        staffId = rsStaff.getInt("staff_id");
    }
    rsStaff.close();
    psStaff.close();

    // Get student details
    PreparedStatement psStudent = con.prepareStatement(
        "SELECT name, email, department, year FROM student WHERE student_id=? AND assigned_staff=?");
    psStudent.setInt(1, studentId);
    psStudent.setInt(2, staffId);
    ResultSet rsStudent = psStudent.executeQuery();
    if(rsStudent.next()){
        studentName = rsStudent.getString("name");
        studentEmail = rsStudent.getString("email");
        studentDepartment = rsStudent.getString("department");
        studentYear = rsStudent.getString("year");
    } else {
        response.sendRedirect("view_assigned_students.jsp");
        return;
    }
    rsStudent.close();
    psStudent.close();

    con.close();
} catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Start Counselling Session</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
    font-family:'Poppins',sans-serif;
    background:#f4f6f9;
    padding:20px;
}
.card {
    max-width:700px;
    margin:auto;
    padding:25px;
    border-radius:15px;
    box-shadow:0 4px 10px rgba(0,0,0,0.1);
}
</style>
</head>
<body>

<div class="card">
    <div class="card-header bg-primary text-white">
        <h4><i class="fa fa-comment-dots"></i> Counselling Session</h4>
    </div>
    <div class="card-body">
        <form action="start_counselling_action.jsp" method="post">
            <input type="hidden" name="student_id" value="<%= studentId %>">
            <input type="hidden" name="staff_id" value="<%= staffId %>">

            <div class="mb-3">
                <label class="form-label">Student Name</label>
                <input type="text" class="form-control" value="<%= studentName %>" disabled>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="text" class="form-control" value="<%= studentEmail %>" disabled>
            </div>

            <div class="mb-3">
                <label class="form-label">Department</label>
                <input type="text" class="form-control" value="<%= studentDepartment %>" disabled>
            </div>

            <div class="mb-3">
                <label class="form-label">Year</label>
                <input type="text" class="form-control" value="<%= studentYear %>" disabled>
            </div>

            <div class="mb-3">
                <label class="form-label">Counselling Date</label>
                <input type="date" name="counselling_date" class="form-control" required>
            </div>

<!--            <div class="mb-3">
                <label class="form-label">Counselling Time</label>
                <input type="time" name="counselling_time" class="form-control" required>
            </div>-->

            <div class="mb-3">
                <label class="form-label">Notes / Discussion Points</label>
                <textarea name="notes" class="form-control" rows="4" placeholder="Enter notes..." required></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Status</label>
                <select name="status" class="form-select" required>
                    <option value="Pending">Pending</option>
                    <option value="Completed">Completed</option>
                </select>
            </div>

            <div class="d-flex justify-content-between">
                <a href="view_assigned_students.jsp" class="btn btn-secondary">
                    <i class="fa fa-arrow-left"></i> Back
                </a>
                <button type="submit" class="btn btn-success">
                    <i class="fa fa-save"></i> Save Session
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>