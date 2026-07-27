<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<%
String usertype = (String) session.getAttribute("usertype");
String username = (String) session.getAttribute("username");
if(usertype == null || !usertype.equals("staff")){
    response.sendRedirect("index.jsp");
    return;
}

String studentRoll = request.getParameter("student_roll");
String notes = request.getParameter("notes");
String counsellingDate = request.getParameter("counselling_date");
String status = request.getParameter("status");
//int requestId = Integer.parseInt(request.getParameter("request_id"));

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root"
    );

    // Insert into counselling_sessions table
    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO counselling_sessions (student_roll, staff_id, session_date, counselling_notes, status) VALUES (?, ?, ?, ?, ?)"
    );
    ps.setString(1, studentRoll);
    ps.setString(2, username);
    ps.setString(3, counsellingDate);
    ps.setString(4, notes);
    ps.setString(5, status);

    int i = ps.executeUpdate();
    ps.close();

//    // Update request status to 'Processed'
//    PreparedStatement ps2 = con.prepareStatement(
//        "UPDATE counselling_request SET status='Processed' WHERE request_id=?"
//    );
//    ps2.setInt(1, requestId);
//    ps2.executeUpdate();
//    ps2.close();

    con.close();

    if(i > 0){
%>
<script>
    alert("Counselling session added successfully!");
    window.location="viewCounsellingRequests.jsp";
</script>
<%
    } else {
%>
<script>
    alert("Failed to add session. Try again.");
    window.location="viewCounsellingRequests.jsp";
</script>
<%
    }

} catch(Exception e){
    e.printStackTrace();
%>
<script>
    alert("Error: <%= e.getMessage() %>");
    window.location="viewCounsellingRequests.jsp";
</script>
<%
}
%>