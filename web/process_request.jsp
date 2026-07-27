<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>

<%
String usertype = (String)session.getAttribute("usertype");
String username = (String)session.getAttribute("username");

if(usertype == null || !usertype.equals("staff")){
    response.sendRedirect("index.jsp");
    return;
}

String requestIdStr = request.getParameter("id");

if(requestIdStr == null){
    response.sendRedirect("staffhome.jsp?page=view_requests");
    return;
}

int requestId = Integer.parseInt(requestIdStr);

String studentRoll = "";
String issue = "";

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT student_roll, issue FROM counselling_request WHERE request_id=?"
    );

    ps.setInt(1, requestId);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        studentRoll = rs.getString("student_roll");
        issue = rs.getString("issue");
    }

    rs.close();
    ps.close();
    con.close();

}catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Process Counselling Request</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    background:transparent;
    font-family:'Poppins',sans-serif;
    padding:20px;
}

.process-card{
    background:#ffffff;
    border-radius:26px;
    padding:35px;
    border:1px solid #d9f4ef;
    box-shadow:0 10px 25px rgba(0,0,0,0.04);
}

.page-title{
    font-size:34px;
    font-weight:700;
    color:#0f172a;
    display:flex;
    align-items:center;
    gap:14px;
    margin-bottom:28px;
}

.page-title i{
    color:#14b8a6;
}

.form-label{
    font-weight:600;
    color:#334155;
    margin-bottom:8px;
}

.form-control,
.form-select{
    border-radius:14px;
    padding:14px 16px;
    border:1px solid #d1d5db;
    font-size:15px;
}

.form-control:focus,
.form-select:focus{
    border-color:#14b8a6;
    box-shadow:0 0 0 0.2rem rgba(20,184,166,.15);
}

textarea.form-control{
    resize:none;
}

.submit-btn{
    background:linear-gradient(135deg,#14b8a6,#0f766e);
    color:white;
    border:none;
    padding:14px 28px;
    border-radius:14px;
    font-weight:600;
    font-size:15px;
    transition:.3s;
}

.submit-btn:hover{
    transform:translateY(-2px);
    box-shadow:0 10px 20px rgba(20,184,166,.25);
}

.info-box{
    background:#f0fdfa;
    border:1px solid #ccfbf1;
    padding:14px 18px;
    border-radius:14px;
    margin-bottom:20px;
    color:#0f766e;
    font-weight:500;
}
</style>
</head>
<body>

<div class="process-card">

    <h2 class="page-title">
        <i class="fa fa-file-circle-check"></i>
        Process Counselling Request
    </h2>

    <div class="info-box">
        Review the request details and schedule counselling for the student.
    </div>

    <form action="add_counselling_from_request.jsp" method="post">

        <input type="hidden" name="request_id" value="<%=requestId%>">

        <div class="mb-3">
            <label class="form-label">Student Roll Number</label>
            <input type="text"
                   name="rollno"
                   class="form-control"
                   value="<%=studentRoll%>"
                   readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">Issue / Request</label>
            <textarea name="problem"
                      class="form-control"
                      rows="4"
                      readonly><%=issue%></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Session Date</label>
            <input type="date"
                   name="session_date"
                   class="form-control"
                   required>
        </div>

        <div class="mb-3">
            <label class="form-label">Counselling Notes</label>
            <textarea name="counselling_notes"
                      class="form-control"
                      rows="5"
                      placeholder="Enter counselling remarks / preparation notes..."
                      required></textarea>
        </div>

       <div class="mb-4">
    <label class="form-label">Status</label>
    <select name="status" class="form-select">
        <option value="Pending" selected>Pending</option>
        <option value="Completed">Completed</option>
   
    </select>
</div>

        <button type="submit" class="submit-btn">
            <i class="fa fa-save"></i>
            Save Counselling Session
        </button>

    </form>

</div>

</body>
</html>