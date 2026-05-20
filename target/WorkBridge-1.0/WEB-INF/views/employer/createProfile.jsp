<c:set var="pageTitle" value="Create Profile | Employer" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4">

    <main class="main-content">
        <div class="page-header mb-4">
            <h1>Create Company Profile</h1>
            <p class="text-muted">Tell candidates about your company.</p>
        </div>

        <div class="card p-4" style="max-width: 800px;">
            <form action="${pageContext.request.contextPath}/employer" method="post" onsubmit="return validateCompany()">
                <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                <input type="hidden" name="action" value="createProfile">

                <div class="form-group mb-3">
                    <label for="companyName">Company Name *</label>
                    <input type="text" id="companyName" name="companyName" class="form-control" required>
                    <span class="field-error" id="err-companyName" style="display:none;"></span>
                </div>

                <div class="form-group mb-3">
                    <label for="industry">Industry</label>
                    <input type="text" id="industry" name="industry" class="form-control">
                </div>

                <div class="form-group mb-3">
                    <label for="location">Headquarters Location</label>
                    <input type="text" id="location" name="location" class="form-control">
                </div>

                <div class="form-group mb-3">
                    <label for="foundedYear">Founded Year</label>
                    <input type="number" id="foundedYear" name="foundedYear" class="form-control" min="1800" max="2025">
                </div>

                <div class="form-group mb-3">
                    <label for="websiteUrl">Website URL</label>
                    <input type="url" id="websiteUrl" name="websiteUrl" class="form-control" placeholder="https://example.com">
                </div>

                <div class="form-group mb-3">
                    <label for="logoUrl">Logo URL</label>
                    <input type="url" id="logoUrl" name="logoUrl" class="form-control" placeholder="https://example.com/logo.jpg">
                </div>

                <div class="form-group mb-4">
                    <label for="companyDescription">Company Description</label>
                    <textarea id="companyDescription" name="companyDescription" class="form-control" rows="5"></textarea>
                </div>

                <button type="submit" class="btn btn-primary">Save Profile</button>
            </form>
        </div>
    </main>
</div>

<script>
    function validateCompany() {
        const name = document.getElementById('companyName').value.trim();
        if (name === '') {
            document.getElementById('err-companyName').textContent = 'Company name is required.';
            document.getElementById('err-companyName').style.display = 'block';
            return false;
        }
        return true;
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
