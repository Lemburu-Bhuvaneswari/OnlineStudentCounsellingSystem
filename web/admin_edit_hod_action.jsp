<%@page import="java.sql.*"%>
<%
String id=request.getParameter("hod_id");
String name=request.getParameter("name");
String department=request.getParameter("department");
String email=request.getParameter("email");
String phone=request.getParameter("phone");

try{

    Class.forName("com.mysql.jdbc.Driver");

    Connection con=DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/student_counselling","root","root");

    PreparedStatement ps=con.prepareStatement(
    "UPDATE hod SET name=?, department=?, email=?, phone=? WHERE hod_id=?");

    ps.setString(1,name);
    ps.setString(2,department);
    ps.setString(3,email);
    ps.setString(4,phone);
    ps.setString(5,id);

    ps.executeUpdate();
%>

<script>
alert("HOD Updated Successfully");
parent.loadPage('view_hod.jsp');
</script>

<%
}catch(Exception e){
    out.println(e);
}
%>