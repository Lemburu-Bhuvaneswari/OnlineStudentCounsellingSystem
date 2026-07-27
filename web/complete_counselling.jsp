<%@ page import="java.sql.*" %>

<%
String sessionId=request.getParameter("session_id");
String notes=request.getParameter("counselling_notes");

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps=con.prepareStatement(
        "UPDATE counselling_sessions " +
        "SET counselling_notes=?, status='Completed' " +
        "WHERE session_id=?"
    );

    ps.setString(1,notes);
    ps.setInt(2,Integer.parseInt(sessionId));

    ps.executeUpdate();

    response.sendRedirect("view_counselling.jsp");

}catch(Exception e){
    out.println(e.getMessage());
}
%>