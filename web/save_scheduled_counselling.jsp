<%@ page import="java.sql.*" %>

<%
String studentRoll=request.getParameter("student_roll");
String sessionDate=request.getParameter("session_date");
String sessionTime=request.getParameter("session_time");
String venue=request.getParameter("venue");
String problem=request.getParameter("problem");

String staffId=(String)session.getAttribute("username");

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps=con.prepareStatement(
        "INSERT INTO counselling_sessions " +
        "(student_roll,staff_id,session_date,session_time,venue,problem,status) " +
        "VALUES (?,?,?,?,?,?,?)"
    );

    ps.setString(1,studentRoll);
    ps.setString(2,staffId);
    ps.setString(3,sessionDate);
    ps.setString(4,sessionTime);
    ps.setString(5,venue);
    ps.setString(6,problem);
    ps.setString(7,"Scheduled");

    ps.executeUpdate();

    response.sendRedirect("view_assigned_students.jsp");

}catch(Exception e){
    out.println(e.getMessage());
}
%>