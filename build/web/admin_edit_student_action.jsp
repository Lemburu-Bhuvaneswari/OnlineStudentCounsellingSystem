<%@page import="java.sql.*"%>
<%
String studentId = request.getParameter("student_id");
String name = request.getParameter("name");
String rollno = request.getParameter("rollno");
String email = request.getParameter("email");
String phone = request.getParameter("phone");
String department = request.getParameter("department");
String year = request.getParameter("year");

try{

    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "UPDATE student SET name=?, rollno=?, email=?, phone=?, department=?, year=? WHERE student_id=?"
    );

    ps.setString(1, name);
    ps.setString(2, rollno);
    ps.setString(3, email);
    ps.setString(4, phone);
    ps.setString(5, department);
    ps.setString(6, year);
    ps.setString(7, studentId);

    int updated = ps.executeUpdate();

    if(updated > 0){
%>
        <script>
            alert("Student updated successfully!");
            parent.loadPage('view_students.jsp');
        </script>
<%
    }else{
%>
        <script>
            alert("Update failed.");
            history.back();
        </script>
<%
    }

}catch(Exception e){
    out.println("Error: " + e);
}
%>