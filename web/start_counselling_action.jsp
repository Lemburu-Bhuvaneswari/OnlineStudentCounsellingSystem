<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String studentId = request.getParameter("student_id");
String staffId = request.getParameter("staff_id");
String date = request.getParameter("counselling_date");
//String time = request.getParameter("counselling_time");
String notes = request.getParameter("notes");
String status = request.getParameter("status");
//added row
String requestId = request.getParameter("request_id"); 
if(studentId == null || staffId == null){
%>
<script>
alert("Invalid session data!");
window.location = "view_assigned_students.jsp";
</script>
<%
    return;
}

try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root");

//    PreparedStatement ps = con.prepareStatement(
//        "INSERT INTO counselling_sessions (student_roll, staff_id, counselling_date, notes, status) VALUES (?,?,?,?,?)"
//    );
//    changed one is below
    PreparedStatement ps = con.prepareStatement(
    "INSERT INTO counselling_sessions (request_id, student_roll, staff_id, counselling_date, counselling_notes, status) VALUES (?,?,?,?,?,?)"
);
//these are before
//    ps.setInt(1, Integer.parseInt(studentId));
//    ps.setInt(2, Integer.parseInt(staffId));
//    ps.setString(3, date);
//    
//    ps.setString(4, notes);
//    ps.setString(5, status);
//after change
    ps.setInt(1, Integer.parseInt(requestId));
ps.setInt(2, Integer.parseInt(studentId));
ps.setInt(3, Integer.parseInt(staffId));
ps.setString(4, date);
ps.setString(5, notes);
ps.setString(6, status);
    int i = ps.executeUpdate();

    ps.close();
    con.close();

    if(i > 0){
%>
<script>
alert("Counselling session saved successfully!");
// Redirect inside the iframe
window.location = "view_assigned_students.jsp";
</script>
<%
    } else {
%>
<script>
alert("Failed to save counselling session!");
window.location = "start_counselling.jsp?id=<%=studentId%>";
</script>
<%
    }

} catch(Exception e){
%>
<script>
alert("Error: <%= e.getMessage() %>");
window.location = "start_counselling.jsp?id=<%=studentId%>";
</script>
<%
}
%>