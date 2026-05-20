<c:set var="pageTitle" value="Manage Jobs | Admin" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4">

    <main class="main-content">
        <div class="page-header mb-4 flex justify-between align-center">
            <h1>Manage Job Listings</h1>
        </div>

        <div class="card p-4">
            <div class="table-responsive">
                <table class="table table-striped w-100">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Employer ID</th>
                            <th>Job Type</th>
                            <th>Status</th>
                            <th>Posted Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="job" items="${jobs}">
                            <tr>
                                <td>${job.id}</td>
                                <td>${job.title}</td>
                                <td>${job.employerId}</td>
                                <td><span class="badge badge-${job.jobType.name().toLowerCase()}">${job.jobType.displayName}</span></td>
                                <td><span class="badge badge-${job.status.toLowerCase()}">${job.status}</span></td>
                                <td><fmt:parseDate value="${job.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                    <fmt:formatDate pattern="MMM dd, yyyy" value="${parsedDate}" /></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin" method="post" style="margin:0;" onsubmit="return confirm('Are you sure you want to delete this job listing?');">
                                        <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                        <input type="hidden" name="action" value="deleteJob">
                                        <input type="hidden" name="id" value="${job.id}">
                                        <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty jobs}">
                            <tr><td colspan="7" class="text-center">No jobs found.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
