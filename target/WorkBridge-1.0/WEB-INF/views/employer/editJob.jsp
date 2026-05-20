<c:set var="pageTitle" value="Edit Job | Employer" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4">

    <main class="main-content">
        <div class="page-header mb-4">
            <h1>Edit Job Listing</h1>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-error mb-4">${error}</div>
        </c:if>

        <div class="card p-4" style="max-width: 800px;">
            <form action="${pageContext.request.contextPath}/employer" method="post" id="jobForm" onsubmit="return validateJob()">
                <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                <input type="hidden" name="action" value="editJob">
                <input type="hidden" name="id" value="${job.id}">
                <input type="hidden" name="status" value="${job.status}"> <!-- keep current status -->

                <div class="form-group mb-3">
                    <label for="title">Job Title *</label>
                    <input type="text" id="title" name="title" class="form-control ${not empty fieldErrors['title'] ? 'error' : ''}" required value="${job.title}">
                    <c:if test="${not empty fieldErrors['title']}">
                        <span class="field-error">${fieldErrors['title']}</span>
                    </c:if>
                    <span class="field-error" id="err-title" style="display:none;"></span>
                </div>

                <div class="flex flex-md-row gap-3 mb-3">
                    <div class="form-group w-100">
                        <label for="categoryId">Category</label>
                        <select id="categoryId" name="categoryId" class="form-control">
                            <option value="0">Select a category...</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}" ${job.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group w-100">
                        <label for="jobType">Job Type *</label>
                        <select id="jobType" name="jobType" class="form-control" required>
                            <option value="FULL_TIME" ${job.jobType.name() == 'FULL_TIME' ? 'selected' : ''}>Full Time</option>
                            <option value="PART_TIME" ${job.jobType.name() == 'PART_TIME' ? 'selected' : ''}>Part Time</option>
                            <option value="CONTRACT" ${job.jobType.name() == 'CONTRACT' ? 'selected' : ''}>Contract</option>
                            <option value="INTERNSHIP" ${job.jobType.name() == 'INTERNSHIP' ? 'selected' : ''}>Internship</option>
                            <option value="REMOTE" ${job.jobType.name() == 'REMOTE' ? 'selected' : ''}>Remote</option>
                        </select>
                    </div>
                </div>

                <div class="flex flex-md-row gap-3 mb-3">
                    <div class="form-group w-100">
                        <label for="location">Location *</label>
                        <input type="text" id="location" name="location" class="form-control" required value="${job.location}">
                    </div>

                    <div class="form-group w-100">
                        <label for="salaryRange">Salary Range</label>
                        <input type="text" id="salaryRange" name="salaryRange" class="form-control" value="${job.salaryRange}">
                    </div>
                </div>

                <div class="form-group mb-3">
                    <label for="deadline">Application Deadline *</label>
                    <input type="date" id="deadline" name="deadline" class="form-control" required value="${job.deadline}">
                    <span class="field-error" id="err-deadline" style="display:none;"></span>
                </div>

                <div class="form-group mb-3">
                    <label for="description">Job Description *</label>
                    <textarea id="description" name="description" class="form-control" rows="6" required>${job.description}</textarea>
                </div>

                <div class="form-group mb-4">
                    <label for="requirements">Requirements</label>
                    <textarea id="requirements" name="requirements" class="form-control" rows="4">${job.requirements}</textarea>
                </div>

                <button type="submit" class="btn btn-primary">Update Job</button>
            </form>
        </div>
    </main>
</div>

<script>
    const today = new Date().toISOString().split('T')[0];
    // don't set min date dynamically here as it's an edit - they might just be changing description of existing valid job

    function validateJob() {
        let valid = true;
        
        document.querySelectorAll('span[id^="err-"]').forEach(el => el.style.display = 'none');
        
        const title = document.getElementById('title').value.trim();

        if (title.length < 3) {
            document.getElementById('err-title').textContent = 'Job title must be at least 3 characters.';
            document.getElementById('err-title').style.display = 'block';
            valid = false;
        }
        return valid;
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
