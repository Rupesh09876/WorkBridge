<c:set var="pageTitle" value="View Applications | Admin" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4">

    <main class="main-content">
        <div class="page-header mb-4 flex justify-between align-center">
            <h1>All Applications</h1>
        </div>

        <div class="card p-4">
            <div class="table-responsive">
                <table class="table table-striped w-100">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Job ID</th>
                            <th>Applicant ID</th>
                            <th>Status</th>
                            <th>Applied On</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="app" items="${applications}">
                            <tr>
                                <td>${app.id}</td>
                                <td>${app.jobId}</td>
                                <td>${app.applicantId}</td>
                                <td>
                                    <span class="badge badge-${app.status.name().toLowerCase()}">
                                        ${app.status}
                                    </span>
                                </td>
                                <td>
                                    <fmt:parseDate value="${app.appliedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                    <fmt:formatDate pattern="MMM dd, yyyy" value="${parsedDate}" />
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin" method="post" style="margin:0;" onsubmit="return confirm('Are you sure you want to delete this application?');">
                                        <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                        <input type="hidden" name="action" value="deleteApplication">
                                        <input type="hidden" name="id" value="${app.id}">
                                        <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty applications}">
                            <tr><td colspan="6" class="text-center">No applications found.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
