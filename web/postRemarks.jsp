<%@ page import="java.sql.*" %>

<%
String usertype = (String) session.getAttribute("usertype");
String username = (String) session.getAttribute("username");
String issue = request.getParameter("issue");

if(usertype == null || !usertype.equals("staff")){
    response.sendRedirect("index.jsp");
    return;
}

String studentRoll = request.getParameter("student_roll");
String remarks = request.getParameter("remarks");
String counsellingDate = request.getParameter("counselling_date");
String status = request.getParameter("status");
int requestId = Integer.parseInt(request.getParameter("request_id"));

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO counselling_sessions " +
        "(request_id, student_roll, staff_id, session_date, problem, counselling_notes, status) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?)"
    );

    ps.setInt(1, requestId);
    ps.setString(2, studentRoll);
    ps.setString(3, username);
    ps.setString(4, counsellingDate);
    ps.setString(5, issue);
    ps.setString(6, remarks);
    ps.setString(7, status);

    int inserted = ps.executeUpdate();
    ps.close();

    if(inserted > 0){

        PreparedStatement ps2 = con.prepareStatement(
            "UPDATE counselling_request SET status=? WHERE request_id=?"
        );

        ps2.setString(1, status);
        ps2.setInt(2, requestId);
        ps2.executeUpdate();
        ps2.close();
    }

    con.close();

    response.sendRedirect("viewCounsellingRequests.jsp?processed=1");

}catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>