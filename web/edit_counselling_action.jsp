<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String usertype = (String) session.getAttribute("usertype");
if(usertype == null || !usertype.equals("staff")){
    response.sendRedirect("index.jsp");
    return;
}

// Get parameters from form
String counsellingIdParam = request.getParameter("counselling_id");
String studentIdParam = request.getParameter("student_id");
String counsellingDate = request.getParameter("counselling_date");
String notes = request.getParameter("notes");
String status = request.getParameter("status");

if(counsellingIdParam == null || studentIdParam == null){
%>
<script>
alert("Invalid request!");
window.location = "view_counselling.jsp";
</script>
<%
    return;
}

int counsellingId = Integer.parseInt(counsellingIdParam);
int studentId = Integer.parseInt(studentIdParam);

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root");

    // Update counselling session
    PreparedStatement ps = con.prepareStatement(
        "UPDATE counselling_sessions SET session_date=?, counselling_notes=?, status=? WHERE session_id=? AND student_roll=?"
    );
    ps.setString(1, counsellingDate);
    ps.setString(2, notes);
    ps.setString(3, status);
    ps.setInt(4, counsellingId);
    ps.setInt(5, studentId);

    int updated = ps.executeUpdate();

    ps.close();
    con.close();

    if(updated > 0){
%>
<script>
alert("Counselling session updated successfully!");
window.location = "view_counselling.jsp"; // stays inside iframe
</script>
<%
    } else {
%>
<script>
alert("Failed to update session. Please try again!");
window.location = "edit_counselling.jsp?id=<%=counsellingId%>";
</script>
<%
    }

} catch(Exception e){
%>
<script>
alert("Error: <%=e.getMessage()%>");
window.location = "edit_counselling.jsp?id=<%=counsellingId%>";
</script>
<%
}
%>