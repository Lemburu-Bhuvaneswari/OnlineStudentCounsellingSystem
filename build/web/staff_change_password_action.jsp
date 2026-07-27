<%@ page import="java.sql.*" %>

<%
String username = (String) session.getAttribute("username");

if(username == null){
    response.sendRedirect("index.jsp");
    return;
}

String currentPassword = request.getParameter("currentPassword");
String newPassword = request.getParameter("newPassword");
String confirmPassword = request.getParameter("confirmPassword");

if(!newPassword.equals(confirmPassword)){
    response.sendRedirect("staff_change_password.jsp?error=Passwords do not match");
    return;
}

if(newPassword.length() < 8){
    response.sendRedirect("staff_change_password.jsp?error=Password must be at least 8 characters");
    return;
}

try{
    Class.forName("com.mysql.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_counselling",
        "root",
        "root"
    );

    PreparedStatement checkPs = con.prepareStatement(
        "SELECT * FROM staff WHERE email=? AND password=?"
    );

    checkPs.setString(1, username);
    checkPs.setString(2, currentPassword);

    ResultSet rs = checkPs.executeQuery();

    if(rs.next()){

        PreparedStatement updatePs = con.prepareStatement(
            "UPDATE staff SET password=? WHERE email=?"
        );

        updatePs.setString(1, newPassword);
        updatePs.setString(2, username);

        int updated = updatePs.executeUpdate();

        if(updated > 0){
            response.sendRedirect("staff_change_password.jsp?success=1");
        }else{
            response.sendRedirect("staff_change_password.jsp?error=Update Failed");
        }

        updatePs.close();

    }else{
        response.sendRedirect("staff_change_password.jsp?error=Current password incorrect");
    }

    rs.close();
    checkPs.close();
    con.close();

}catch(Exception e){
    response.sendRedirect("staff_change_password.jsp?error="+e.getMessage());
}
%>