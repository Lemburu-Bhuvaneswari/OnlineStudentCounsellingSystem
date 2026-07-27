<%@page import="java.sql.*"%>
<%
String id=request.getParameter("staff_id");
String name=request.getParameter("name");
String department=request.getParameter("department");
String designation=request.getParameter("designation");
String email=request.getParameter("email");
String phone=request.getParameter("phone");

try{

    Class.forName("com.mysql.jdbc.Driver");

    Connection con=DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/student_counselling","root","root");

    PreparedStatement ps=con.prepareStatement(
    "UPDATE staff SET name=?, department=?, designation=?, email=?, phone=? WHERE staff_id=?");

    ps.setString(1,name);
    ps.setString(2,department);
    ps.setString(3,designation);
    ps.setString(4,email);
    ps.setString(5,phone);
    ps.setString(6,id);

    ps.executeUpdate();
%>

<script>
alert("Staff Updated Successfully");
parent.loadPage('view_staff.jsp');
</script>

<%
}catch(Exception e){
    out.println(e);
}
%>