<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String usertype = (String) session.getAttribute("usertype");
if(usertype == null || !usertype.equals("staff")){
    response.sendRedirect("index.jsp");
    return;
}

String idParam = request.getParameter("id");
if(idParam == null){
    response.sendRedirect("view_counselling.jsp");
    return;
}

int counsellingId = Integer.parseInt(idParam);

int studentId = 0;
String notes = "", status = "", date = "", time = "";
String studentName = "";

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root");

    // Get counselling details
    PreparedStatement ps = con.prepareStatement(
        "SELECT c.student_roll, c.session_date,  c.counselling_notes, c.status, s.name " +
        "FROM counselling_sessions c JOIN student s ON c.student_roll = s.rollno " +
        "WHERE c.session_id=?"
    );
    ps.setInt(1, counsellingId);
    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        studentId = rs.getInt("student_roll");
        date = rs.getString("counselling_date");
        
        notes = rs.getString("notes");
        status = rs.getString("status");
        studentName = rs.getString("name");
    } else {
        response.sendRedirect("view_counselling.jsp");
        return;
    }

    rs.close();
    ps.close();
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
<title>Edit Counselling Session</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
    font-family:'Poppins', sans-serif;
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
        <h4><i class="fa fa-edit"></i> Edit Counselling Session</h4>
    </div>
    <div class="card-body">
        <form action="edit_counselling_action.jsp" method="post">

            <input type="hidden" name="counselling_id" value="<%= counsellingId %>">
            <input type="hidden" name="student_id" value="<%= studentId %>">

            <div class="mb-3">
                <label class="form-label">Student Name</label>
                <input type="text" class="form-control" value="<%= studentName %>" disabled>
            </div>

            <div class="mb-3">
                <label class="form-label">Counselling Date</label>
                <input type="date" name="counselling_date" class="form-control" value="<%= date %>" required>
            </div>

<!--            <div class="mb-3">
                <label class="form-label">Counselling Time</label>
                <input type="time" name="counselling_time" class="form-control" value="<%= time %>" required>
            </div>-->

            <div class="mb-3">
                <label class="form-label">Notes / Discussion Points</label>
                <textarea name="notes" class="form-control" rows="4" required><%= notes %></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Status</label>
                <select name="status" class="form-select" required>
                    <option value="Pending" <%= "Pending".equals(status) ? "selected" : "" %>>Pending</option>
                    <option value="Completed" <%= "Completed".equals(status) ? "selected" : "" %>>Completed</option>
                </select>
            </div>

            <div class="d-flex justify-content-between">
                <a href="view_counselling.jsp" class="btn btn-secondary">
                    <i class="fa fa-arrow-left"></i> Back
                </a>
                <button type="submit" class="btn btn-success">
                    <i class="fa fa-save"></i> Update Session
                </button>
            </div>

        </form>
    </div>
</div>

</body>
</html>