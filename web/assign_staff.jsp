<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Assign Staff</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
*{
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    margin:0;
    padding:20px;
    background:transparent;
}

/* PAGE WRAPPER */
.page-wrapper{
    width:100%;
    display:flex;
    flex-direction:column;
    align-items:center;
}

/* HEADER */
.page-header{
    width:100%;
    max-width:1000px;
    text-align:center;
    margin-bottom:24px;
}

.page-header h2{
    font-size:28px;
    font-weight:700;
    margin:0;
    color:#0f172a;
}

.page-header p{
    margin:6px 0 0;
    font-size:14px;
    color:#64748b;
}

/* CARD */
.assign-card{
    width:100%;
    max-width:1000px;
    background:#fff;
    border-radius:24px;
    padding:32px;
    border:1px solid #e5e7eb;
    box-shadow:0 10px 30px rgba(15,23,42,0.06);
}

/* TOP TITLE */
.form-title{
    display:flex;
    align-items:center;
    gap:14px;
    margin-bottom:26px;
}

.form-icon{
    width:52px;
    height:52px;
    border-radius:16px;
    background:linear-gradient(135deg,#ede9fe,#f3e8ff);
    display:flex;
    align-items:center;
    justify-content:center;
    color:#9333ea;
    font-size:20px;
}

.form-title h4{
    margin:0;
    font-size:22px;
    font-weight:700;
    color:#0f172a;
}

.form-title p{
    margin:3px 0 0;
    font-size:13px;
    color:#64748b;
}

/* FORM */
.form-group{
    margin-bottom:20px;
}

label{
    display:block;
    margin-bottom:8px;
    font-size:14px;
    font-weight:600;
    color:#334155;
}

.form-control{
    width:100%;
    height:52px;
    border:1px solid #e2e8f0;
    border-radius:14px;
    padding:0 16px;
    font-size:14px;
    background:#f8fafc;
    outline:none;
    transition:.25s;
}

.form-control:focus{
    border-color:#8b5cf6;
    background:#fff;
    box-shadow:0 0 0 4px rgba(139,92,246,0.10);
}

/* GRID */
.roll-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:20px;
}

/* BUTTON */
.assign-btn{
    border:none;
    height:52px;
    padding:0 30px;
    border-radius:14px;
    background:linear-gradient(135deg,#9333ea,#2563eb);
    color:#fff;
    font-weight:600;
    font-size:15px;
    display:inline-flex;
    align-items:center;
    gap:10px;
    box-shadow:0 8px 20px rgba(147,51,234,0.22);
    transition:.25s;
}

.assign-btn:hover{
    transform:translateY(-2px);
}

/* MOBILE */
@media(max-width:768px){
    .roll-grid{
        grid-template-columns:1fr;
    }

    .assign-card{
        padding:20px;
    }

    .page-header h2{
        font-size:24px;
    }
}
</style>

</head>
<body>

<div class="page-wrapper">

    <div class="page-header">
        <h2>Assign Staff to Students</h2>
        <p>Manage counselor assignments and student roll ranges</p>
    </div>

    <div class="assign-card">

        <div class="form-title">
            <div class="form-icon">
                <i class="fa fa-user-plus"></i>
            </div>
            <div>
                <h4>New Assignment</h4>
                <p>Select staff and assign roll range</p>
            </div>
        </div>

        <form action="assign_staff_action.jsp" method="post">

            <div class="form-group">
                <label>Select Staff</label>
                <select name="staff_email" class="form-control" required>
                    <option value="">-- Select Staff --</option>

                    <%
                        String dname = (String) session.getAttribute("dname");

                        try{
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection(
                                "jdbc:mysql://localhost:3306/student_counselling",
                                "root",
                                "root"
                            );

                            Statement st = con.createStatement();
                            ResultSet rs = st.executeQuery(
                                "SELECT email,name FROM staff WHERE department='"+dname+"'"
                            );

                            while(rs.next()){
                    %>
                        <option value="<%=rs.getString("email")%>">
                            <%=rs.getString("name")%>
                        </option>
                    <%
                            }

                            con.close();

                        }catch(Exception e){}
                    %>

                </select>
            </div>

            <div class="roll-grid">

                <div class="form-group">
                    <label>Start Roll Number</label>
                    <input type="text"
                           name="start_rollno"
                           class="form-control"
                           placeholder="e.g. 22711A0501"
                           required>
                </div>

                <div class="form-group">
                    <label>End Roll Number</label>
                    <input type="text"
                           name="end_rollno"
                           class="form-control"
                           placeholder="e.g. 22711A0550"
                           required>
                </div>

            </div>

            <button type="submit" class="assign-btn">
                <i class="fa fa-save"></i>
                Assign Staff
            </button>

        </form>

    </div>

</div>

</body>
</html>