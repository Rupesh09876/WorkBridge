<c:set var="pageTitle" value="Search Jobs | WorkBridge" scope="request" />
<c:set var="extraCss" value="jobs.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container mt-4 mb-5">
    <div class="text-center mb-5">
        <h1 class="mb-2">Find Your Dream Job</h1>
        <p class="text-muted">Search through thousands of open roles</p>
    </div>

    <div class="card p-4 mb-4">
        <!-- Search is accessible via JobSeekerServlet (requires auth) or JobServlet (public) -->
        <c:set var="searchAction" value="${pageContext.request.contextPath}/${sessionScope.loggedInUser != null ? 'jobseeker' : 'job'}" />
        <form action="${searchAction}" method="get" class="flex flex-col gap-3">
            <input type="hidden" name="action" value="${sessionScope.loggedInUser != null ? 'search' : 'list'}">
            
            <div class="search-bar flex flex-md-row gap-2">
                <input type="text" name="keyword" class="form-control flex-grow" placeholder="Job title, keywords, or company" value="${param.keyword}">
                <input type="text" name="location" class="form-control" placeholder="Location" value="${param.location}">
                <button type="submit" class="btn btn-primary px-4">Search</button>
            </div>
            
            <div class="filter-row flex gap-3 flex-wrap">
                <select name="jobType" class="form-control" style="width: auto;">
                    <option value="">Any Job Type</option>
                    <option value="FULL_TIME" ${param.jobType == 'FULL_TIME' ? 'selected' : ''}>Full Time</option>
                    <option value="PART_TIME" ${param.jobType == 'PART_TIME' ? 'selected' : ''}>Part Time</option>
                    <option value="CONTRACT" ${param.jobType == 'CONTRACT' ? 'selected' : ''}>Contract</option>
                    <option value="INTERNSHIP" ${param.jobType == 'INTERNSHIP' ? 'selected' : ''}>Internship</option>
                    <option value="REMOTE" ${param.jobType == 'REMOTE' ? 'selected' : ''}>Remote</option>
                </select>
                
                <c:if test="${not empty categories}">
                    <select name="categoryId" class="form-control" style="width: auto;">
                        <option value="0">All Categories</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}" ${param.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                        </c:forEach>
                    </select>
                </c:if>
            </div>
        </form>
    </div>

    <div class="jobs-grid">
        <c:forEach var="job" items="${jobs}">
            <div class="card job-card p-4">
                <div class="mb-3">
                    <h3 class="m-0 mb-1">${job.title}</h3>
                    <p class="text-muted text-sm m-0">Employer ID: ${job.employerId}</p>
                </div>
                
                <div class="job-card-meta mb-4 text-sm flex flex-wrap gap-2 text-muted">
                    <span><i class="icon-location"></i> ${job.location}</span>
                    <span class="badge badge-${job.jobType.name().toLowerCase()}">${job.jobType.displayName}</span>
                    <c:if test="${not empty job.salaryRange}">
                        <span>${job.salaryRange}</span>
                    </c:if>
                </div>
                
                <div class="job-card-actions flex gap-2 w-100">
                    <c:choose>
                        <c:when test="${sessionScope.loggedInUser != null && sessionScope.loggedInUser.role == 'JOB_SEEKER'}">
                            <a href="${pageContext.request.contextPath}/jobseeker?action=jobDetail&id=${job.id}" class="btn btn-primary flex-grow text-center">Apply Now</a>
                            <form action="${pageContext.request.contextPath}/jobseeker" method="post" style="margin:0;">
                                <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                <input type="hidden" name="action" value="save">
                                <input type="hidden" name="jobId" value="${job.id}">
                                <button type="submit" class="btn btn-secondary">Save</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/job?action=detail&id=${job.id}" class="btn btn-primary flex-grow text-center">View Details</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty jobs}">
        <div class="text-center p-5 card">
            <h3 class="text-muted mb-2">No jobs found matching your search.</h3>
            <p class="text-muted">Try different keywords or broaden your filters.</p>
        </div>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
