<c:set var="pageTitle" value="Error | WorkBridge" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<c:if test="${not empty sessionScope.loggedInUser}">
    <%@ include file="/WEB-INF/views/common/navbar.jsp" %>
</c:if>

<div class="container layout p-4 flex justify-center align-center" style="min-height: 70vh;">
    <div class="card error-card text-center" style="max-width: 500px; padding: 3rem;">
        <h1 class="text-danger mb-2">Oops!</h1>
        <c:if test="${not empty pageContext.errorData.statusCode}">
            <h2 class="text-muted mb-2">Error Code: ${pageContext.errorData.statusCode}</h2>
        </c:if>
        
        <div class="alert alert-error mb-4">
            <c:choose>
                <c:when test="${not empty requestScope.error}">
                    ${requestScope.error}
                </c:when>
                <c:otherwise>
                    An unexpected error occurred. Please try again later.
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="flex gap-2 justify-center">
            <button onclick="history.back()" class="btn btn-secondary">Go Back</button>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Return to Dashboard</a>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
