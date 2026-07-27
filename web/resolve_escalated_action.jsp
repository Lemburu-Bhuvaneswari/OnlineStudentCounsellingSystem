<!--resolve_escaleted_action.jsp-->


<%@page import="java.sql.*"%>

<%
String hodEmail = (String)session.getAttribute("username");

if(hodEmail == null){
    response.sendRedirect("index.jsp");
    return;
}

String requestId = request.getParameter("request_id");
String hodRemarks = request.getParameter("hod_remarks");

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
        "UPDATE counselling_request SET " +
        "status='Resolved by HOD', " +
        "hod_remarks=?, " +
        "resolved_by=?, " +
        "remarks=? " +
        "WHERE request_id=?"
    );

    ps1.setString(1, hodRemarks);
    ps1.setString(2, hodEmail);
    ps1.setString(3, hodRemarks);
    ps1.setInt(4, Integer.parseInt(requestId));
    ps1.executeUpdate();
    ps1.close();

    PreparedStatement ps2 = con.prepareStatement(
        "UPDATE counselling_sessions SET " +
        "status='Resolved by HOD', " +
        "counselling_notes=? " +
        "WHERE request_id=?"
    );

    ps2.setString(1, hodRemarks);
    ps2.setInt(2, Integer.parseInt(requestId));
    ps2.executeUpdate();
    ps2.close();

    con.commit();
    con.close();

    response.sendRedirect("view_escalated_requests.jsp?resolved=success");

}catch(Exception e){

    if(con != null){
        try{ con.rollback(); }catch(Exception ex){}
    }

    out.println("Error: " + e.getMessage());
}
%>