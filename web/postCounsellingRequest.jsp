<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
String username = (String) session.getAttribute("username");
if(username == null){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Post Counselling Request</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:transparent;
    padding:8px;
}

.page-title{
    font-size:28px;
    font-weight:700;
    color:#0f172a;
    margin-bottom:6px;
}

.page-subtitle{
    font-size:15px;
    color:#64748b;
    margin-bottom:24px;
}

.request-card{
    max-width:850px;
    margin:auto;
    background:#ffffff;
    border:1px solid #fce7f3;
    border-radius:24px;
    padding:32px;
    box-shadow:0 8px 24px rgba(236,72,153,.08);
}

.form-label{
    display:block;
    font-size:15px;
    font-weight:600;
    color:#334155;
    margin-bottom:10px;
}

textarea{
    width:100%;
    min-height:180px;
    border:1px solid #fbcfe8;
    border-radius:18px;
    padding:18px;
    font-size:15px;
    resize:vertical;
    outline:none;
    transition:.3s;
}

textarea:focus{
    border-color:#ff2d95;
    box-shadow:0 0 0 4px rgba(255,45,149,.12);
}

.btn-submit{
    margin-top:22px;
    width:100%;
    border:none;
    border-radius:16px;
    padding:15px;
    background:linear-gradient(90deg,#ff2d95,#ff006a);
    color:#fff;
    font-size:15px;
    font-weight:600;
    cursor:pointer;
    transition:.3s;
}

.btn-submit:hover{
    transform:translateY(-2px);
    box-shadow:0 12px 24px rgba(255,45,149,.25);
}
</style>
</head>
<body>

<div class="page-title">
    <i class="fa-solid fa-paper-plane"></i> Post Counselling Request
</div>

<div class="page-subtitle">
    Submit your issue or request to your assigned counsellor
</div>

<div class="request-card">

    <form action="postCounsellingRequest_action.jsp" method="post">

        <label class="form-label">Issue / Request Description</label>

        <textarea
            name="issue"
            placeholder="Describe your issue, academic concern, personal challenge, or request for counselling..."
            required></textarea>

        <button type="submit" class="btn-submit">
            <i class="fa-solid fa-paper-plane"></i> Submit Request
        </button>

    </form>

</div>

</body>
</html>