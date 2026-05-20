<c:set var="pageTitle" value="My Applications | Job Seeker" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4">

    <main class="main-content">
        <div class="page-header mb-4">
            <h1>My Applications</h1>
            <p class="text-muted">Track the status of jobs you've applied to.</p>
        </div>

        <div class="card p-4">
            <div class="table-responsive">
                <table class="table table-striped w-100">
                    <thead>
                        <tr>
                            <th>Job ID</th>
                            <th>Applied Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="app" items="${applications}">
                            <tr>
                                <td>Job #${app.jobId}</td>
                                <td>
                                    <fmt:parseDate value="${app.appliedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                    <fmt:formatDate pattern="MMM dd, yyyy" value="${parsedDate}" />
                                </td>
                                <td>
                                    <span class="badge badge-${app.status.name().toLowerCase()}">${app.status.displayName}</span>
                                </td>
                                <td class="flex gap-2">
                                    <a href="${pageContext.request.contextPath}/application?action=detail&id=${app.id}" class="btn btn-sm btn-primary">View Detail</a>
                                    
                                    <c:if test="${app.status == 'PENDING'}">
                                        <form action="${pageContext.request.contextPath}/jobseeker" method="post" style="margin:0;" onsubmit="return confirm('Withdraw application?');">
                                            <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                            <input type="hidden" name="action" value="withdraw">
                                            <input type="hidden" name="applicationId" value="${app.id}">
                                            <button type="submit" class="btn btn-sm btn-danger">Withdraw</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty applications}">
                            <tr><td colspan="4" class="text-center">You haven't applied to any jobs yet.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
