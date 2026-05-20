<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Job Categories | Admin" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4">

    <main class="main-content">
        <div class="page-header mb-4">
            <h1>Job Categories</h1>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-error mb-4">${error}</div>
        </c:if>
        <c:if test="${param.success == 'added'}">
            <div class="alert alert-success mb-4">Category added successfully.</div>
        </c:if>
        <c:if test="${param.success == 'updated'}">
            <div class="alert alert-success mb-4">Category updated successfully.</div>
        </c:if>
        <c:if test="${param.success == 'deleted'}">
            <div class="alert alert-success mb-4">Category deleted successfully.</div>
        </c:if>

        <div class="card p-4 mb-4">
            <h2 class="mb-3">Add New Category</h2>
            <form action="${pageContext.request.contextPath}/admin" method="post" class="flex flex-wrap gap-3 align-end">
                <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                <input type="hidden" name="action" value="addCategory">
                
                <div class="form-group flex-1 m-0" style="min-width: 200px;">
                    <label for="name">Name *</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>
                
                <div class="form-group flex-2 m-0" style="min-width: 300px;">
                    <label for="description">Description</label>
                    <input type="text" id="description" name="description" class="form-control">
                </div>
                
                <div class="form-group m-0">
                    <button type="submit" class="btn btn-primary" style="height: 38px;">Add Category</button>
                </div>
            </form>
        </div>

        <div class="card p-4">
            <div class="table-responsive">
                <table class="table w-100">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cat" items="${categories}">
                            <tr>
                                <td>${cat.id}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin" method="post" class="flex gap-2" id="editForm-${cat.id}">
                                        <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                        <input type="hidden" name="action" value="editCategory">
                                        <input type="hidden" name="id" value="${cat.id}">
                                        <input type="text" name="name" value="${cat.name}" class="form-control" required style="width: 150px; padding: 4px;">
                                </td>
                                <td>
                                        <input type="text" name="description" value="${cat.description}" class="form-control" style="width: 100%; padding: 4px;">
                                </td>
                                <td>
                                        <button type="submit" class="btn btn-sm btn-secondary">Save</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this category?');">
                                        <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                        <input type="hidden" name="action" value="deleteCategory">
                                        <input type="hidden" name="id" value="${cat.id}">
                                        <button type="submit" class="btn btn-sm btn-danger mt-1">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty categories}">
                            <tr>
                                <td colspan="4" class="text-center text-muted">No categories found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
