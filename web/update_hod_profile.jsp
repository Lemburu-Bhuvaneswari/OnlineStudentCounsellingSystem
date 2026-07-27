<%@page import="java.sql.*"%>

<%
String username = (String)session.getAttribute("username");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}

String name = request.getParameter("name");
String phone = request.getParameter("phone");

/* SERVER SIDE VALIDATION */
if(name == null || !name.matches("^[A-Za-z ]{2,50}$")){
    out.println("<script>alert('Invalid Name. Use only letters/spaces (2-50 chars).');history.back();</script>");
    return;
}

if(phone == null || !phone.matches("^[0-9]{10}$")){
    out.println("<script>alert('Invalid Phone Number. Must be exactly 10 digits.');history.back();</script>");
    return;
}

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling","root","root");

    PreparedStatement ps = con.prepareStatement(
        "UPDATE hod SET name=?, phone=? WHERE email=?");

    ps.setString(1, name.trim());
    ps.setString(2, phone.trim());
    ps.setString(3, username);

    int updated = ps.executeUpdate();

    ps.close();
    con.close();

    if(updated > 0){
        session.setAttribute("name", name.trim());
        response.sendRedirect("hod_profile.jsp?success=1");
    }else{
        out.println("<script>alert('Profile update failed.');history.back();</script>");
    }

}catch(Exception e){
    out.println("<script>alert('Error: "+e.getMessage()+"');history.back();</script>");
}
%>