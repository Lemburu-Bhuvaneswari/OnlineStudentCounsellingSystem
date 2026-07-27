<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = (String)session.getAttribute("username");

String requestId = request.getParameter("request_id");
String rollno = request.getParameter("rollno");
String sessionDate = request.getParameter("session_date");
String problem = request.getParameter("problem");
String notes = request.getParameter("counselling_notes");
String status = request.getParameter("status");

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO counselling_sessions " +
        "(request_id, student_roll, staff_id, session_date, problem, counselling_notes, status) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?)"
    );

    ps.setInt(1, Integer.parseInt(requestId));
    ps.setString(2, rollno);
    ps.setString(3, username);
    ps.setString(4, sessionDate);
    ps.setString(5, problem);
    ps.setString(6, notes);
    ps.setString(7, status);

    ps.executeUpdate();

    PreparedStatement ps2 = con.prepareStatement(
        "UPDATE counselling_request SET status=? WHERE request_id=?"
    );

    ps2.setString(1, status);
    ps2.setInt(2, Integer.parseInt(requestId));
    ps2.executeUpdate();

    ps.close();
    ps2.close();
    con.close();

    response.sendRedirect("staffhome.jsp?page=view_counselling");

}catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>