<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Open Jobs | WorkBridge</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jobs.css">
</head>
<body>

<nav class="navbar">
    <div class="container nav-container">
        <a href="${pageContext.request.contextPath}/" class="nav-brand">
            <img src="${pageContext.request.contextPath}/images/logo.jpg" alt="WorkBridge" class="logo" onerror="this.src='https://via.placeholder.com/200x70?text=WorkBridge'">
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <a href="${pageContext.request.contextPath}/jobs" class="active">Jobs</a>
            <a href="${pageContext.request.contextPath}/companies">Companies</a>
            <a href="${pageContext.request.contextPath}/resources">Resources <i class="ph ph-caret-down"></i></a>
            <a href="${pageContext.request.contextPath}/about">About Us</a>
        </div>
        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-outline">Login</a>
            <a href="${pageContext.request.contextPath}/auth?action=register" class="btn btn-primary">Register</a>
        </div>
    </div>
</nav>

<main class="container mt-4 mb-4" style="min-height: 70vh;">
    <!-- SECTION 1 — Page header -->
    <div class="page-header mb-4 text-center">
        <h1 class="mb-1">Browse Open Jobs</h1>
        <p class="text-muted">Find your perfect role from our current listings</p>
    </div>

    <!-- SECTION 2 — Search and filter bar -->
    <div class="card p-3 mb-4">
        <form action="${pageContext.request.contextPath}/jobs" method="GET" class="flex flex-wrap gap-3 align-end">
            <div class="form-group flex-1" style="min-width: 200px; margin: 0;">
                <label for="keyword" class="text-sm">Keyword</label>
                <input type="text" id="keyword" name="keyword" class="form-control" placeholder="Job title, skills, keywords" value="${param.keyword}">
            </div>
            
            <div class="form-group flex-1" style="min-width: 200px; margin: 0;">
                <label for="location" class="text-sm">Location</label>
                <input type="text" id="location" name="location" class="form-control" placeholder="City or remote" value="${param.location}">
            </div>
            
            <div class="form-group" style="min-width: 150px; margin: 0;">
                <label for="jobType" class="text-sm">Job Type</label>
                <select id="jobType" name="jobType" class="form-control">
                    <option value="">All Types</option>
                    <option value="FULL_TIME" ${param.jobType == 'FULL_TIME' ? 'selected' : ''}>Full Time</option>
                    <option value="PART_TIME" ${param.jobType == 'PART_TIME' ? 'selected' : ''}>Part Time</option>
                    <option value="CONTRACT" ${param.jobType == 'CONTRACT' ? 'selected' : ''}>Contract</option>
                    <option value="INTERNSHIP" ${param.jobType == 'INTERNSHIP' ? 'selected' : ''}>Internship</option>
                    <option value="REMOTE" ${param.jobType == 'REMOTE' ? 'selected' : ''}>Remote</option>
                </select>
            </div>
            
            <div class="form-group" style="min-width: 200px; margin: 0;">
                <label for="categoryId" class="text-sm">Category</label>
                <select id="categoryId" name="categoryId" class="form-control">
                    <option value="0">All Categories</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}" ${param.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                    </c:forEach>
                </select>
            </div>
            
            <div style="margin: 0;">
                <button type="submit" class="btn btn-primary" style="height: 38px;">Search Jobs</button>
            </div>
        </form>
    </div>

    <!-- SECTION 3 — Results -->
    <c:choose>
        <c:when test="${empty jobs}">
            <div class="card p-5 text-center mt-4">
                <h3 class="mb-2">No jobs found matching your search.</h3>
                <p class="text-muted mb-3">Try different keywords or clear the filters.</p>
                <a href="${pageContext.request.contextPath}/jobs" class="btn btn-secondary">View all jobs</a>
            </div>
        </c:when>
        <c:otherwise>
            <p class="text-muted text-sm mb-3">Showing ${fn:length(jobs)} open position(s)</p>
            <div class="jobs-grid">
                <c:forEach var="job" items="${jobs}">
                    <div class="card job-card p-4">
                        <h3 class="m-0 mb-1" style="font-weight: 500;">${job.title}</h3>
                        
                        <div class="job-meta flex gap-2 align-center flex-wrap mb-3 mt-2">
                            <span class="text-muted text-sm"><i class="icon-location"></i> ${job.location}</span>
                            <span class="badge badge-${job.jobType.name().toLowerCase()}">${job.jobType.displayName}</span>
                        </div>
                        
                        <c:if test="${not empty job.salaryRange}">
                            <p class="text-sm text-muted mb-1"><strong>Salary:</strong> ${job.salaryRange}</p>
                        </c:if>
                        
                        <p class="text-sm text-muted mb-3">Apply by: ${job.deadline}</p>
                        
                        <div class="flex gap-2 align-center mt-auto pt-2 border-top">
                            <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-primary btn-sm">Apply Now</a>
                            <a href="${pageContext.request.contextPath}/auth?action=login" class="text-muted text-sm" style="text-decoration: none;">Login to Save</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <!-- SECTION 4 — Login prompt banner -->
            <div class="card p-4 mt-5 text-center" style="background-color: var(--bg-main);">
                <p class="mb-3 font-bold">Want to apply? Create a free account or log in.</p>
                <div class="flex justify-center gap-3">
                    <a href="${pageContext.request.contextPath}/auth?action=register" class="btn btn-primary">Register</a>
                    <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-secondary">Login</a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<!-- FOOTER -->
<footer class="landing-footer mt-auto">
    <div class="footer-left">
        <p>© 2025 WorkBridge. All rights reserved.</p>
    </div>
    <div class="footer-center">
        <p class="footer-tech">Built with Java EE · MySQL · Apache Tomcat</p>
    </div>
    <div class="footer-links">
        <a href="${pageContext.request.contextPath}/auth?action=login">Login</a>
        <a href="${pageContext.request.contextPath}/auth?action=register">Register</a>
        <a href="${pageContext.request.contextPath}/jobs">Browse Jobs</a>
    </div>
</footer>

</body>
</html>
