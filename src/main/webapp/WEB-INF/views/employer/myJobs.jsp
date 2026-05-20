<c:set var="pageTitle" value="My Jobs | Employer" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4">

    <main class="main-content">
        <div class="page-header mb-4 flex justify-between align-center">
            <h1>My Job Listings</h1>
            <a href="${pageContext.request.contextPath}/employer?action=postJob" class="btn btn-primary">Post New Job</a>
        </div>

        <div class="jobs-grid">
            <c:forEach var="job" items="${jobs}">
                <div class="card job-card p-3">
                    <div class="job-card-header mb-2 flex justify-between align-center">
                        <h3 class="m-0">${job.title}</h3>
                        <c:choose>
                            <c:when test="${job.status == 'DRAFT'}">
                                <span class="badge badge-draft">DRAFT</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-${job.status.toLowerCase()}">${job.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="job-card-meta text-muted text-sm mb-3 flex gap-2 flex-wrap">
                        <span><i class="icon-location"></i> ${job.location}</span>
                        <span class="badge badge-${job.jobType.name().toLowerCase()}">${job.jobType.displayName}</span>
                        <c:if test="${not empty job.salaryRange}">
                            <span>${job.salaryRange}</span>
                        </c:if>
                        <span>Deadline: ${job.deadline}</span>
                    </div>
                    
                    <div class="mb-3 text-sm">
                        <!-- Ideally ApplicationService would append count here -->
                        <p><strong>Status:</strong> ${job.status}</p>
                    </div>

                    <div class="job-card-actions flex gap-2">
                        <a href="${pageContext.request.contextPath}/employer?action=applicants&jobId=${job.id}" class="btn btn-sm btn-primary">Applicants</a>
                        <a href="${pageContext.request.contextPath}/employer?action=editJob&id=${job.id}" class="btn btn-sm btn-secondary">Edit</a>
                        
                        <c:if test="${job.status == 'DRAFT'}">
                            <form action="${pageContext.request.contextPath}/employer" method="post" style="margin:0;">
                                <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                <input type="hidden" name="action" value="publishJob">
                                <input type="hidden" name="jobId" value="${job.id}">
                                <button type="submit" class="btn btn-sm btn-success">Publish</button>
                            </form>
                        </c:if>

                        <c:if test="${job.status == 'OPEN'}">
                            <form action="${pageContext.request.contextPath}/employer" method="post" style="margin:0;">
                                <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                <input type="hidden" name="action" value="closeJob">
                                <input type="hidden" name="id" value="${job.id}">
                                <button type="submit" class="btn btn-sm btn-warning">Close</button>
                            </form>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/employer" method="post" style="margin:0;" onsubmit="return confirm('Are you sure you want to delete this job?');">
                            <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                            <input type="hidden" name="action" value="deleteJob">
                            <input type="hidden" name="id" value="${job.id}">
                            <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <c:if test="${empty jobs}">
            <div class="card p-4 text-center">
                <p class="text-muted mb-3">You haven't posted any jobs yet.</p>
                <a href="${pageContext.request.contextPath}/employer?action=postJob" class="btn btn-primary">Post Your First Job</a>
            </div>
        </c:if>
    </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
