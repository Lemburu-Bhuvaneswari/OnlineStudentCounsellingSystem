<!--escalate_request.jsp-->
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
String sessionId = request.getParameter("session_id");
String requestId = request.getParameter("request_id");

if(sessionId == null || requestId == null){
%>
    <div class="alert alert-danger">
        Invalid escalation request.
    </div>
<%
    return;
}
%>

<div class="content-card">
    <div class="page-header">
        <h2>
            <i class="fa fa-arrow-up text-warning"></i>
            Escalate Case to HOD
        </h2>
        <p>Provide a reason for escalating this counselling case.</p>
    </div>

    <form action="escalate_request_action.jsp" method="post">

        <input type="hidden" name="session_id" value="<%=sessionId%>">
        <input type="hidden" name="request_id" value="<%=requestId%>">

        <div class="mb-3">
            <label class="form-label">Escalation Reason</label>
            <textarea name="escalation_reason"
                      class="form-control"
                      rows="6"
                      required
                      placeholder="Enter reason for escalation..."></textarea>
        </div>

        <button type="submit" class="btn btn-warning">
            <i class="fa fa-arrow-up"></i> Submit Escalation
        </button>

    </form>
</div>