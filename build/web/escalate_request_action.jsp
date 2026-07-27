<%@page import="java.sql.*"%>

<%
String username = (String) session.getAttribute("username");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}

String sessionId = request.getParameter("session_id");
String requestId = request.getParameter("request_id");
String reason = request.getParameter("escalation_reason");

Connection con = null;

try{
    Class.forName("com.mysql.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    con.setAutoCommit(false);

    PreparedStatement ps1 = con.prepareStatement(
        "UPDATE counselling_sessions SET status='Escalated' WHERE session_id=?"
    );
    ps1.setInt(1, Integer.parseInt(sessionId));
    ps1.executeUpdate();
    ps1.close();

    PreparedStatement ps2 = con.prepareStatement(
        "UPDATE counselling_request SET " +
        "status='Escalated', " +
        "escalated_to_hod='Yes', " +
        "escalation_reason=?, " +
        "escalated_by=?, " +
        "escalated_date=NOW() " +
        "WHERE request_id=?"
    );

    ps2.setString(1, reason);
    ps2.setString(2, username);
    ps2.setInt(3, Integer.parseInt(requestId));
    ps2.executeUpdate();
    ps2.close();

    con.commit();
    con.close();

    response.sendRedirect("view_counselling.jsp?escalated=success");

}catch(Exception e){

    if(con!=null){
        try{ con.rollback(); }catch(Exception ex){}
    }

    out.println("Error: " + e.getMessage());
}
%>