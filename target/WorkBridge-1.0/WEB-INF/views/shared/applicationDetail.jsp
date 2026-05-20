<c:set var="pageTitle" value="Application Details | WorkBridge" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4" style="max-width: 800px;">
    <div class="mb-3 flex justify-between align-center">
        <h2>Application Detail</h2>
        <button onclick="history.back()" class="btn btn-secondary btn-sm">Go Back</button>
    </div>

    <div class="card p-4 mb-4">
        <p>Application ID: ${param.id}</p>
        <p>Job Title: Example Job (ID from application)</p>
        <p>This is a shared view between Employer and Job Seeker.</p>
        <!-- The specific fields would be populated here by the Servlet -->
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
