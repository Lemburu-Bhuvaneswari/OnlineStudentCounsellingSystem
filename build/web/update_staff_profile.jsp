<%@page import="java.sql.*"%>

<%
String username = (String)session.getAttribute("username");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}

String name = request.getParameter("name");
String designation = request.getParameter("designation");
String phone = request.getParameter("phone");

/* Server-Side Validation */
if(name == null || !name.matches("^[A-Za-z\\s]{3,50}$")){
    out.println("<script>alert('Invalid Name');history.back();</script>");
    return;
}

if(designation == null || designation.trim().length() < 2){
    out.println("<script>alert('Invalid Designation');history.back();</script>");
    return;
}

if(phone == null || !phone.matches("^[0-9]{10}$")){
    out.println("<script>alert('Invalid Phone Number');history.back();</script>");
    return;
}

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "UPDATE staff SET name=?, designation=?, phone=? WHERE email=?"
    );

    ps.setString(1, name);
    ps.setString(2, designation);
    ps.setString(3, phone);
    ps.setString(4, username);

    ps.executeUpdate();

    session.setAttribute("name", name);

    con.close();

    response.sendRedirect("staff_profile.jsp?success=1");

}catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>