<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<title>Add Department</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:transparent;
}

.page-title{
    font-size:32px;
    font-weight:700;
    color:#0f172a;
    margin-bottom:25px;
    display:flex;
    align-items:center;
    gap:12px;
}

.form-wrapper{
    display:flex;
    justify-content:center;
    align-items:center;
    min-height:65vh;
}

.form-card{
    width:100%;
    max-width:650px;
    background:rgba(255,255,255,0.92);
    backdrop-filter:blur(14px);
    border-radius:24px;
    padding:38px;
    box-shadow:
        0 10px 30px rgba(0,0,0,0.08),
        inset 0 1px 0 rgba(255,255,255,0.6);
    border:1px solid rgba(255,255,255,0.5);
}

.form-label{
    font-weight:600;
    color:#334155;
    margin-bottom:10px;
}

.form-control{
    height:56px;
    border-radius:16px;
    border:1.5px solid #dbeafe;
    padding:0 18px;
    font-size:15px;
    transition:.3s ease;
    box-shadow:none;
}

.form-control:focus{
    border-color:#2563eb;
    box-shadow:0 0 0 4px rgba(37,99,235,0.12);
}

.btn-submit{
    background:linear-gradient(135deg,#2563eb,#06b6d4);
    border:none;
    color:white;
    padding:14px 38px;
    border-radius:50px;
    font-weight:600;
    font-size:15px;
    transition:.3s ease;
    box-shadow:0 8px 18px rgba(37,99,235,0.25);
}

.btn-submit:hover{
    transform:translateY(-2px);
    box-shadow:0 12px 24px rgba(37,99,235,0.35);
}

.success-alert{
    border-radius:14px;
    font-weight:500;
}
</style>

</head>
<body>

<div class="container-fluid">

    <h4 class="page-title">
        <i class="fa fa-building"></i>
        Add Department
    </h4>

    <% if("success".equals(request.getParameter("msg"))){ %>
        <div class="alert alert-success success-alert">
            <i class="fa fa-check-circle"></i> Department added successfully.
        </div>
    <% } %>

    <div class="form-wrapper">

        <div class="form-card">

            <form action="add_department_action.jsp" method="post">

                <div class="mb-4">
                    <label class="form-label">Department Name</label>

                    <input type="text"
                           name="dept_name"
                           class="form-control"
                           placeholder="Enter Department Name"
                           required>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-submit">
                        <i class="fa fa-save"></i> Add Department
                    </button>
                </div>

            </form>

        </div>

    </div>

</div>

</body>
</html>