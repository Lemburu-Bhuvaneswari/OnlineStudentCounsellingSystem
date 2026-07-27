
<%@page import="java.sql.*"%>

<%

String id=request.getParameter("id");

try{

Class.forName("com.mysql.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/student_counselling","root","root");

PreparedStatement ps=con.prepareStatement(
"delete from student where student_id=?");

ps.setString(1,id);

ps.executeUpdate();

response.sendRedirect("view_students.jsp");

}catch(Exception e){

out.println(e);

}

%>

