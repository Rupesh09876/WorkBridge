<c:set var="pageTitle" value="Manage Users | Admin" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4">

    <main class="main-content">
        <div class="page-header mb-4 flex justify-between align-center">
            <h1>Manage Users</h1>
        </div>

        <div class="card p-4">
            <div class="table-responsive">
                <table class="table table-striped w-100">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Joined</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.fullName}</td>
                                <td>${user.email}</td>
                                <td>${user.phone}</td>
                                <td>${user.role}</td>
                                <td>
                                    <span class="badge badge-${user.status.name().toLowerCase()}">
                                        ${user.status}
                                    </span>
                                </td>
                                <td><fmt:parseDate value="${user.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                    <fmt:formatDate pattern="MMM dd, yyyy" value="${parsedDate}" /></td>
                                <td class="flex gap-1">
                                    <c:if test="${user.status == 'PENDING'}">
                                        <form action="${pageContext.request.contextPath}/admin" method="post" style="margin:0;">
                                            <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                            <input type="hidden" name="action" value="approve">
                                            <input type="hidden" name="id" value="${user.id}">
                                            <button type="submit" class="btn btn-sm btn-success">Approve</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${user.status == 'ACTIVE' && user.role != 'ADMIN'}">
                                        <form action="${pageContext.request.contextPath}/admin" method="post" style="margin:0;">
                                            <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                            <input type="hidden" name="action" value="suspend">
                                            <input type="hidden" name="id" value="${user.id}">
                                            <button type="submit" class="btn btn-sm btn-warning">Suspend</button>
                                        </form>
                                    </c:if>
                                    <form action="${pageContext.request.contextPath}/admin" method="post" style="margin:0;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                        <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                        <input type="hidden" name="action" value="deleteUser">
                                        <input type="hidden" name="id" value="${user.id}">
                                        <button type="submit" class="btn btn-sm btn-danger" ${user.role == 'ADMIN' ? 'disabled title="Cannot delete ADMIN"' : ''}>Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty users}">
                            <tr><td colspan="8" class="text-center">No users found.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
