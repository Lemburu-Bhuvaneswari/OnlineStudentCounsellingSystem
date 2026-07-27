<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String usertype = (String) session.getAttribute("usertype");
if(usertype == null || !usertype.equals("staff")){
    response.sendRedirect("index.jsp");
    return;
}

// Get counselling ID from request
String idParam = request.getParameter("id");
if(idParam == null){
%>
<script>
alert("Invalid request!");
window.location = "view_counselling.jsp";
</script>
<%
    return;
}

int counsellingId = Integer.parseInt(idParam);

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root");

    // Delete counselling session
    PreparedStatement ps = con.prepareStatement(
        "DELETE FROM counselling_sessions WHERE session_id=?"
    );
    ps.setInt(1, counsellingId);

    int deleted = ps.executeUpdate();
    ps.close();
    con.close();

    if(deleted > 0){
%>
<script>
alert("Counselling session deleted successfully!");
window.location = "view_counselling.jsp"; // stays inside iframe
</script>
<%
    } else {
%>
<script>
alert("Failed to delete session. It may not exist.");
window.location = "view_counselling.jsp";
</script>
<%
    }

} catch(Exception e){
%>
<script>
alert("Error: <%= e.getMessage() %>");
window.location = "view_counselling.jsp";
</script>
<%
}
%>