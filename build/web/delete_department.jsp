
<%@page import="java.sql.*"%>

<%

String id=request.getParameter("id");

try{

Class.forName("com.mysql.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/student_counselling_system","root","root");

PreparedStatement ps=con.prepareStatement(
"delete from department where dept_id=?");

ps.setString(1,id);

ps.executeUpdate();

response.sendRedirect("view_departments.jsp");

}catch(Exception e){

out.println(e);

}

%>

