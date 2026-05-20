<c:set var="pageTitle" value="Edit Profile | Employer" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4">

    <main class="main-content">
        <div class="page-header mb-4">
            <h1>Edit Company Profile</h1>
        </div>

        <div class="card p-4" style="max-width: 800px;">
            <form action="${pageContext.request.contextPath}/employer" method="post" onsubmit="return validateCompany()">
                <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                <input type="hidden" name="action" value="editProfile">

                <div class="form-group mb-3">
                    <label for="companyName">Company Name *</label>
                    <input type="text" id="companyName" name="companyName" class="form-control" value="${profile.companyName}" required>
                </div>

                <div class="form-group mb-3">
                    <label for="industry">Industry</label>
                    <input type="text" id="industry" name="industry" class="form-control" value="${profile.industry}">
                </div>

                <div class="form-group mb-3">
                    <label for="location">Headquarters Location</label>
                    <input type="text" id="location" name="location" class="form-control" value="${profile.location}">
                </div>

                <div class="form-group mb-3">
                    <label for="foundedYear">Founded Year</label>
                    <input type="number" id="foundedYear" name="foundedYear" class="form-control" min="1800" max="2025" value="${profile.foundedYear}">
                </div>

                <div class="form-group mb-3">
                    <label for="websiteUrl">Website URL</label>
                    <input type="url" id="websiteUrl" name="websiteUrl" class="form-control" value="${profile.websiteUrl}">
                </div>

                <div class="form-group mb-3">
                    <label for="logoUrl">Logo URL</label>
                    <input type="url" id="logoUrl" name="logoUrl" class="form-control" value="${profile.logoUrl}">
                    <c:if test="${not empty profile.logoUrl}">
                        <div class="mt-2">
                            <img src="${profile.logoUrl}" alt="Logo Preview" style="max-height: 50px;">
                        </div>
                    </c:if>
                </div>

                <div class="form-group mb-4">
                    <label for="companyDescription">Company Description</label>
                    <textarea id="companyDescription" name="companyDescription" class="form-control" rows="5">${profile.companyDescription}</textarea>
                </div>

                <button type="submit" class="btn btn-primary">Update Profile</button>
            </form>
        </div>
    </main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
