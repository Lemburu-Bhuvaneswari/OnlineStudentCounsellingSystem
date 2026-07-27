<!--save_counselling.jsp-->

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    
String student_id = request.getParameter("student_id");
String rollno = request.getParameter("rollno");
String session_date = request.getParameter("session_date");
String problem = request.getParameter("problem");
String notes = request.getParameter("counselling_notes");
String status = request.getParameter("status");

// Optional: get logged-in staff
String username = (String) session.getAttribute("username");

Connection con = null;
PreparedStatement ps = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root");

    // ✅ Insert Query
    String query = "INSERT INTO counselling_sessions(student_roll, staff_id, session_date, problem, counselling_notes, status) VALUES (?, ?, ?, ?, ?, ?)";

    ps = con.prepareStatement(query);

   
    ps.setString(1, rollno);
     ps.setString(2, username);
    ps.setString(3, session_date);
    ps.setString(4, problem);
    ps.setString(5, notes);
    ps.setString(6, status);
    

    int i = ps.executeUpdate();

    if(i > 0){
        // ✅ Success
        response.sendRedirect("view_assigned_students.jsp?msg=success");
    } else {
        // ❌ Failed
        response.sendRedirect("view_assigned_students.jsp?msg=error");
    }

} catch(Exception e){
    out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
} finally {
    try {
        if(ps != null) ps.close();
        if(con != null) con.close();
    } catch(Exception e){}
}
%>