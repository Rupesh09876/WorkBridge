<c:set var="pageTitle" value="${job.title} | WorkBridge" scope="request" />
<c:set var="extraCss" value="jobs.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4 mb-5 job-detail-layout">
    <main class="job-main">
        <div class="card p-4 mb-4">
            <div class="flex justify-between align-start flex-wrap gap-3">
                <div>
                    <h1 class="mb-1">${job.title}</h1>
                    <p class="text-muted text-lg mb-3">Location: ${job.location}</p>
                    <div class="flex gap-2 flex-wrap">
                        <span class="badge badge-${job.jobType.name().toLowerCase()}">${job.jobType.displayName}</span>
                        <c:if test="${not empty job.salaryRange}">
                            <span class="badge badge-draft">${job.salaryRange}</span>
                        </c:if>
                        <span class="badge badge-info">Deadline: ${job.deadline}</span>
                    </div>
                </div>
                
                <c:if test="${sessionScope.loggedInUser != null && sessionScope.loggedInUser.role == 'JOB_SEEKER'}">
                    <form action="${pageContext.request.contextPath}/jobseeker" method="post" style="margin:0;">
                        <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                        <input type="hidden" name="action" value="${isSaved ? 'unsave' : 'save'}">
                        <input type="hidden" name="jobId" value="${job.id}">
                        <button type="submit" class="btn ${isSaved ? 'btn-secondary' : 'btn-primary'}">
                            ${isSaved ? 'Remove from Saved' : 'Save Job'}
                        </button>
                    </form>
                </c:if>
            </div>
        </div>

        <div class="card p-4 mb-4">
            <h2 class="mb-3 border-bottom pb-2">Job Description</h2>
            <div class="text-content mb-4" style="white-space: pre-wrap;">${job.description}</div>

            <c:if test="${not empty job.requirements}">
                <h2 class="mb-3 border-bottom pb-2">Requirements</h2>
                <div class="text-content" style="white-space: pre-wrap;">${job.requirements}</div>
            </c:if>
        </div>
        
        <c:if test="${sessionScope.loggedInUser != null && sessionScope.loggedInUser.role == 'JOB_SEEKER'}">
            <!-- Checking if applied logic can be improved in JSP, but relying on controller passes -->
            <c:set var="alreadyApplied" value="false" />
            <c:forEach var="app" items="${applications}">
                <c:if test="${app.jobId == job.id}">
                    <c:set var="alreadyApplied" value="true" />
                </c:if>
            </c:forEach>

            <div class="card p-4" id="apply-section">
                <c:choose>
                    <c:when test="${alreadyApplied}">
                        <div class="alert alert-success text-center">
                            <h3 class="m-0">You have already applied for this job.</h3>
                            <a href="${pageContext.request.contextPath}/jobseeker?action=myApplications" class="btn btn-sm btn-secondary mt-2">View My Applications</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <h2 class="mb-3">Apply for this Job</h2>
                        <form action="${pageContext.request.contextPath}/jobseeker" method="post" class="apply-form" onsubmit="return validateApplication()">
                            <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                            <input type="hidden" name="action" value="apply">
                            <input type="hidden" name="jobId" value="${job.id}">

                            <div class="form-group mb-3">
                                <label for="resumeUrl">Resume Link (URL)</label>
                                <input type="url" id="resumeUrl" name="resumeUrl" class="form-control" placeholder="E.g. Google Drive link" required>
                            </div>

                            <div class="form-group mb-4">
                                <label for="coverLetter">Cover Letter *</label>
                                <textarea id="coverLetter" name="coverLetter" class="form-control" rows="6" placeholder="Why are you a great fit?" required></textarea>
                                <span class="field-error" id="err-coverLetter" style="display:none;"></span>
                                <small class="text-muted">Minimum 50 characters.</small>
                            </div>

                            <button type="submit" class="btn btn-primary w-100">Submit Application</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        <c:if test="${sessionScope.loggedInUser == null}">
            <div class="card p-4 text-center">
                <h3 class="mb-2">Interested in this role?</h3>
                <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-primary">Login to Apply</a>
            </div>
        </c:if>
    </main>
</div>

<script>
    function validateApplication() {
        const coverLetter = document.getElementById('coverLetter').value.trim();
        if (coverLetter.length < 50) {
            document.getElementById('err-coverLetter').textContent = 'Cover letter must be at least 50 characters.';
            document.getElementById('err-coverLetter').style.display = 'block';
            return false;
        }
        return true;
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
