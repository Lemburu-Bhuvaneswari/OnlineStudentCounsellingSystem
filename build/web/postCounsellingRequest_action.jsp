<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>

<%
String username = (String) session.getAttribute("username");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}

String issue = request.getParameter("issue");

if(issue == null || issue.trim().isEmpty()){
%>
<script>
    alert("Please enter your issue.");
    window.location="postCounsellingRequest.jsp";
</script>
<%
    return;
}

String requestDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO counselling_request (student_roll, issue, request_date, status) VALUES (?, ?, ?, ?)"
    );

    ps.setString(1, username);
    ps.setString(2, issue);
    ps.setString(3, requestDate);
    ps.setString(4, "Pending");

    int i = ps.executeUpdate();

    ps.close();
    con.close();

    if(i > 0){
%>
<script>
    alert("Counselling request submitted successfully!");
    window.location="student_welcome.jsp";
</script>
<%
    }else{
%>
<script>
    alert("Failed to submit request.");
    window.location="postCounsellingRequest.jsp";
</script>
<%
    }

}catch(Exception e){
%>
<script>
    alert("Error: <%= e.getMessage() %>");
    window.location="postCounsellingRequest.jsp";
</script>
<%
}
%>