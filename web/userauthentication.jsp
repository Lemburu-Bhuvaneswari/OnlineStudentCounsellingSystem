<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%
    // Get form data
    String usertype = request.getParameter("role"); // from hidden input
    String username = request.getParameter("username"); // for admin/staff
    //String email = request.getParameter("email");       // for HOD/student
    String password = request.getParameter("password");
    
    if(usertype == null || password == null || username==null){
        response.sendRedirect("index.jsp"); // missing data
        return;
    }

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String dbUser = "";
    String dbPass = "";
    String homePage = "";

    try {
        // Load JDBC driver (MySQL example)
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_counselling","root","root");

        // Prepare SQL based on user type
        if(usertype.equals("admin")){
            pst = con.prepareStatement("SELECT username,password, department FROM admin WHERE username=?");
            pst.setString(1, username);
            homePage = "adminhome.jsp";
        } else if(usertype.equals("hod")){
            pst = con.prepareStatement("SELECT email,password, department FROM hod WHERE email=?");
            pst.setString(1, username);
            homePage = "hodhome.jsp";
        } else if(usertype.equals("staff")){
            pst = con.prepareStatement("SELECT email,password, department  FROM staff WHERE email=?");
            pst.setString(1, username);
            homePage = "staffhome.jsp";
        } else if(usertype.equals("student")){
            pst = con.prepareStatement("SELECT email,password,department FROM student WHERE rollno=?");
            pst.setString(1, username);
            homePage = "studenthome.jsp";
        } else {
            response.sendRedirect("index.jsp"); // unknown usertype
            return;
        }

        rs = pst.executeQuery();
        if(rs.next()){
            dbUser = (usertype.equals("admin") ? rs.getString("username") : rs.getString("email"));
            dbPass = rs.getString("password");

            if(password.equals(dbPass)){
                // Successful login: store session attributes
                session.setAttribute("usertype", usertype);
                session.setAttribute("username", username);
                session.setAttribute("dname", rs.getString("department"));

                // Redirect to appropriate home page
                response.sendRedirect(homePage);
            } else {
                // Wrong password
                out.println("<script>alert('Incorrect password'); window.location='index.jsp';</script>");
            }
        } else {
            // User not found
            out.println("<script>alert('User not found'); window.location='index.jsp';</script>");
        }

    } catch(Exception e){
        e.printStackTrace();
        out.println("<script>alert('Database error'); window.location='index.jsp';</script>");
    } finally {
        try { if(rs != null) rs.close(); } catch(Exception e) {}
        try { if(pst != null) pst.close(); } catch(Exception e) {}
        try { if(con != null) con.close(); } catch(Exception e) {}
    }
%>