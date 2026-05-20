<c:set var="pageTitle" value="Saved Jobs | Job Seeker" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4">

    <main class="main-content">
        <div class="page-header mb-4">
            <h1>Saved Jobs</h1>
            <p class="text-muted">Jobs you've marked for later.</p>
        </div>

        <div class="jobs-grid">
            <c:forEach var="saved" items="${savedJobs}">
                <div class="card job-card p-3">
                    <h3 class="m-0 mb-1">Job #${saved.jobId}</h3>
                    <p class="text-sm text-muted mb-3">Saved on: 
                        <fmt:parseDate value="${saved.savedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                        <fmt:formatDate pattern="MMM dd, yyyy" value="${parsedDate}" />
                    </p>
                    
                    <div class="job-card-actions flex gap-2">
                        <a href="${pageContext.request.contextPath}/jobseeker?action=jobDetail&id=${saved.jobId}" class="btn btn-sm btn-primary flex-grow text-center">View & Apply</a>
                        <form action="${pageContext.request.contextPath}/jobseeker" method="post" style="margin:0;">
                            <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                            <input type="hidden" name="action" value="unsave">
                            <input type="hidden" name="jobId" value="${saved.jobId}">
                            <button type="submit" class="btn btn-sm btn-secondary">Remove</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <c:if test="${empty savedJobs}">
            <div class="card p-4 text-center">
                <p class="text-muted mb-3">You have no saved jobs.</p>
                <a href="${pageContext.request.contextPath}/jobseeker?action=search" class="btn btn-primary">Find Jobs to Save</a>
            </div>
        </c:if>
    </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
