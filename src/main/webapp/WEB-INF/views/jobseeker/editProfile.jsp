<c:set var="pageTitle" value="Edit Profile | Job Seeker" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4">

    <main class="main-content">
        <div class="page-header mb-4">
            <h1>Edit Your Profile</h1>
        </div>

        <div class="card p-4" style="max-width: 800px;">
            <form action="${pageContext.request.contextPath}/jobseeker" method="post" onsubmit="return validateSeekerProfile()">
                <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                <input type="hidden" name="action" value="editProfile">

                <div class="form-group mb-3">
                    <label for="headline">Professional Headline *</label>
                    <input type="text" id="headline" name="headline" class="form-control" value="${profile.headline}" required>
                    <span class="field-error" id="err-headline" style="display:none;"></span>
                </div>

                <div class="flex flex-md-row gap-3 mb-3">
                    <div class="form-group w-100">
                        <label for="location">Location</label>
                        <input type="text" id="location" name="location" class="form-control" value="${profile.location}">
                    </div>
                    <div class="form-group w-100">
                        <label for="phone">Phone Number</label>
                        <input type="text" id="phone" name="phone" class="form-control" value="${profile.phone}">
                    </div>
                </div>

                <div class="flex flex-md-row gap-3 mb-3">
                    <div class="form-group w-100">
                        <label for="linkedinUrl">LinkedIn Profile URL</label>
                        <input type="url" id="linkedinUrl" name="linkedinUrl" class="form-control" value="${profile.linkedinUrl}">
                    </div>
                    <div class="form-group w-100">
                        <label for="resumeUrl">Resume Link (URL)</label>
                        <input type="url" id="resumeUrl" name="resumeUrl" class="form-control" value="${profile.resumeUrl}">
                    </div>
                </div>

                <div class="form-group mb-3">
                    <label for="summary">Professional Summary</label>
                    <textarea id="summary" name="summary" class="form-control" rows="4">${profile.summary}</textarea>
                </div>

                <div class="form-group mb-3">
                    <label for="skills">Skills (comma-separated)</label>
                    <input type="text" id="skills" name="skills" class="form-control" value="${profile.skills}">
                </div>

                <div class="form-group mb-3">
                    <label for="experience">Work Experience</label>
                    <textarea id="experience" name="experience" class="form-control" rows="5">${profile.experience}</textarea>
                </div>

                <div class="form-group mb-4">
                    <label for="education">Education</label>
                    <textarea id="education" name="education" class="form-control" rows="4">${profile.education}</textarea>
                </div>

                <button type="submit" class="btn btn-primary">Update Profile</button>
            </form>
        </div>
    </main>
</div>

<script>
    function validateSeekerProfile() {
        const headline = document.getElementById('headline').value.trim();
        if (headline === '') {
            document.getElementById('err-headline').textContent = 'Headline is required.';
            document.getElementById('err-headline').style.display = 'block';
            return false;
        }
        return true;
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
