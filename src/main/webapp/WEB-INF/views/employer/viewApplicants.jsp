<c:set var="pageTitle" value="Applicants | Employer" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4">

    <main class="main-content">
        <div class="page-header mb-4 flex justify-between align-center">
            <h1>Applicants for Job #${param.jobId}</h1>
            <a href="${pageContext.request.contextPath}/employer?action=myJobs" class="btn btn-secondary btn-sm">Back to My Jobs</a>
        </div>

        <div class="card p-4">
            <h3 class="mb-3">Total Applicants: ${applications.size()}</h3>
            
            <div class="table-responsive">
                <table class="table table-striped w-100">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Applied Date</th>
                            <th>Current Status</th>
                            <th>Update Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="app" items="${applications}">
                            <tr>
                                <td>App #${app.id} (User: ${app.applicantId})</td>
                                <td>
                                    <fmt:parseDate value="${app.appliedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                    <fmt:formatDate pattern="MMM dd, yyyy" value="${parsedDate}" />
                                </td>
                                <td><span class="badge badge-${app.status.name().toLowerCase()}">${app.status.displayName}</span></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/employer" method="post" class="flex gap-1" style="margin:0;">
                                        <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="applicationId" value="${app.id}">
                                        <input type="hidden" name="jobId" value="${param.jobId}">
                                        <select name="status" class="form-control" style="padding: 0.25rem; font-size: 0.875rem;">
                                            <option value="PENDING" ${app.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                                            <option value="REVIEWED" ${app.status == 'REVIEWED' ? 'selected' : ''}>Reviewed</option>
                                            <option value="SHORTLISTED" ${app.status == 'SHORTLISTED' ? 'selected' : ''}>Shortlisted</option>
                                            <option value="ACCEPTED" ${app.status == 'ACCEPTED' ? 'selected' : ''}>Accepted</option>
                                            <option value="REJECTED" ${app.status == 'REJECTED' ? 'selected' : ''}>Rejected</option>
                                        </select>
                                        <button type="submit" class="btn btn-sm btn-secondary">Update</button>
                                    </form>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/application?action=detail&id=${app.id}" class="btn btn-sm btn-primary">View Detail</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty applications}">
                            <tr><td colspan="5" class="text-center">No applicants yet.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
