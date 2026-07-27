<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String usertype = (String) session.getAttribute("usertype");

    if(usertype == null || !usertype.equals("hod")){
        response.sendRedirect("index.jsp");
        return;
    }

    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String department = request.getParameter("department");
    String year = request.getParameter("year");

    try{
        Class.forName("com.mysql.jdbc.Driver");

        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/student_counselling",
            "root",
            "root"
        );

        PreparedStatement ps = conn.prepareStatement(
            "UPDATE student SET name=?, email=?, phone=?, department=?, year=? WHERE student_id=?"
        );

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, department);
        ps.setString(5, year);
        ps.setInt(6, Integer.parseInt(id));

        int rows = ps.executeUpdate();

        ps.close();
        conn.close();

        if(rows > 0){
            response.sendRedirect("view_department_students.jsp");
        }else{
            out.println("<h3>Update Failed!</h3>");
        }

    }catch(Exception e){
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    }
%>