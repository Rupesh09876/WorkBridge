<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Seeker Dashboard | WorkBridge</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>

<!-- Dashboard Nav -->
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="dashboard-container">
    <c:if test="${profileIncomplete != null ? profileIncomplete : true}">
        <div class="alert-banner mb-4">
            <div class="alert-content">
                <i class="ph ph-warning"></i>
                <span>Your profile is ${profileCompletion != null ? profileCompletion : '80'}% complete. Complete your profile to get better job recommendations.</span>
            </div>
            <a href="${pageContext.request.contextPath}/jobseeker?action=createProfile" class="btn-primary">Complete Profile</a>
        </div>
    </c:if>

    <!-- Stats Grid -->
    <div class="stat-grid">
        <div class="s-card">
            <div class="s-card-header" style="margin-bottom:0.5rem;">
                <div class="s-icon bg-blue-light"><i class="ph ph-briefcase text-blue"></i></div>
                <div class="s-title" style="margin:0;">Total Applications</div>
            </div>
            <div class="s-value">1</div>
            <div class="text-sm text-muted mt-2">Jobs you have applied for</div>
        </div>
        <div class="s-card">
            <div class="s-card-header" style="margin-bottom:0.5rem;">
                <div class="s-icon bg-orange-light"><i class="ph ph-clock text-orange" style="color:#f97316;"></i></div>
                <div class="s-title" style="margin:0;">Pending</div>
            </div>
            <div class="s-value">1</div>
            <div class="text-sm text-muted mt-2">Applications in progress</div>
        </div>
        <div class="s-card">
            <div class="s-card-header" style="margin-bottom:0.5rem;">
                <div class="s-icon bg-green-light"><i class="ph ph-check-circle text-green"></i></div>
                <div class="s-title" style="margin:0;">Shortlisted</div>
            </div>
            <div class="s-value">0</div>
            <div class="text-sm text-muted mt-2">Applications shortlisted</div>
        </div>
        <div class="s-card">
            <div class="s-card-header" style="margin-bottom:0.5rem;">
                <div class="s-icon bg-red-light"><i class="ph ph-x-circle text-red"></i></div>
                <div class="s-title" style="margin:0;">Rejected</div>
            </div>
            <div class="s-value">0</div>
            <div class="text-sm text-muted mt-2">Applications not selected</div>
        </div>
    </div>

    <div class="dash-grid-2">
        <!-- Recent Applications -->
        <div class="d-card">
            <div class="d-card-header">
                <h3 class="d-card-title">Recent Applications</h3>
                <a href="${pageContext.request.contextPath}/jobseeker?action=myApplications" class="view-all">View all</a>
            </div>
            
            <c:choose>
                <c:when test="${empty recentApplications}">
            <div class="table-responsive">
                <table class="dash-table">
                    <thead>
                        <tr>
                            <th>Job Title</th>
                            <th>Company</th>
                            <th>Applied On</th>
                            <th>Status</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="font-bold">Frontend Developer (React.js)</td>
                            <td>Tech Solutions</td>
                            <td>May 18, 2025</td>
                            <td><span class="status-badge status-pending">PENDING</span></td>
                            <td><i class="ph ph-caret-right text-muted"></i></td>
                        </tr>
                    </tbody>
                </table>
            </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="dash-table">
                            <thead>
                                <tr>
                                    <th>Job Title</th>
                                    <th>Company</th>
                                    <th>Applied On</th>
                                    <th>Status</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="app" items="${recentApplications}" end="2">
                                    <tr>
                                        <td class="font-bold">Job #${app.jobId}</td>
                                        <td>Company</td>
                                        <td>
                                            <fmt:parseDate value="${app.appliedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                            <fmt:formatDate pattern="MMM dd, yyyy" value="${parsedDate}" />
                                        </td>
                                        <td><span class="status-badge status-${app.status.name().toLowerCase()}">${app.status.displayName}</span></td>
                                        <td><i class="ph ph-caret-right text-muted"></i></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Latest Open Jobs -->
        <div class="d-card">
            <div class="d-card-header">
                <h3 class="d-card-title">Latest Open Jobs</h3>
                <a href="${pageContext.request.contextPath}/jobseeker?action=search" class="view-all">Browse all</a>
            </div>
            
            <c:choose>
                <c:when test="${empty latestJobs}">
                    <div class="d-job-card flex-col align-start gap-2">
                        <div class="w-100 flex flex-col gap-1">
                            <h4 style="font-size:1.05rem;">Frontend Developer (React.js)</h4>
                            <div class="text-sm text-muted">Kathmandu, Nepal</div>
                            <div class="mt-2 mb-3"><span class="j-tag gray" style="background:#f1f5f9; padding:2px 8px; border-radius:4px; font-size:0.75rem; font-weight:600;">FULL TIME</span></div>
                        </div>
                        <a href="#" class="btn-primary w-100 text-center justify-center">View Job</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="job" items="${latestJobs}" end="1">
                        <div class="d-job-card flex-col align-start gap-2">
                            <div class="w-100 flex flex-col gap-1">
                                <h4 style="font-size:1.05rem;">${job.title}</h4>
                                <div class="text-sm text-muted">${job.location}</div>
                                <div class="mt-2 mb-3"><span class="j-tag gray" style="background:#f1f5f9; padding:2px 8px; border-radius:4px; font-size:0.75rem; font-weight:600; text-transform:uppercase;">${job.jobType.displayName}</span></div>
                            </div>
                            <a href="${pageContext.request.contextPath}/jobseeker?action=jobDetail&id=${job.id}" class="btn-primary w-100 text-center justify-center">View Job</a>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="dash-grid-3">
        <!-- Saved Jobs -->
        <div class="d-card">
            <div class="d-card-header">
                <h3 class="d-card-title">Saved Jobs</h3>
                <a href="#" class="view-all">View all</a>
            </div>
            <div class="empty-state" style="padding: 3rem 0;">
                <div class="s-icon bg-blue-light" style="margin: 0 auto 1rem; color:#64748b; background:#f1f5f9;"><i class="ph ph-bookmark-simple"></i></div>
                <div class="font-bold text-sm mb-1">You haven't saved any jobs yet.</div>
                <div class="text-xs text-muted" style="font-size:0.8rem;">Save jobs you like to apply later.</div>
            </div>
        </div>

        <!-- Application Activity -->
        <div class="d-card">
            <div class="d-card-header">
                <h3 class="d-card-title">Application Activity</h3>
                <a href="#" class="view-all">View all</a>
            </div>
            <div class="activity-list">
                <div class="activity-item" style="position:relative; padding-bottom:1.5rem;">
                    <div style="position:absolute; left:18px; top:36px; bottom:0; width:1px; background:#e2e8f0;"></div>
                    <div class="a-icon bg-green-light"><i class="ph ph-briefcase text-green"></i></div>
                    <div class="a-details">
                        <div class="a-title">Application submitted</div>
                        <div class="a-desc">Frontend Developer (React.js) at Tech Solutions</div>
                    </div>
                    <div class="a-time text-right" style="font-size:0.75rem;">May 18, 2025<br>10:24 AM</div>
                </div>
            </div>
        </div>

        <!-- Quick Links -->
        <div class="d-card">
            <div class="d-card-header">
                <h3 class="d-card-title">Quick Links</h3>
            </div>
            <div class="action-grid">
                <a href="${pageContext.request.contextPath}/jobseeker?action=search" class="action-btn" style="text-decoration:none;"><i class="ph ph-magnifying-glass"></i> Search Jobs</a>
                <a href="${pageContext.request.contextPath}/jobseeker?action=myApplications" class="action-btn" style="text-decoration:none;"><i class="ph ph-file-text"></i> My Applications</a>
                <a href="#" class="action-btn" style="text-decoration:none;"><i class="ph ph-bookmark-simple"></i> Saved Jobs</a>
                <a href="${pageContext.request.contextPath}/jobseeker?action=createProfile" class="action-btn" style="text-decoration:none;"><i class="ph ph-user"></i> Edit Profile</a>
            </div>
        </div>
    </div>
</div>

<footer class="text-center text-muted" style="padding: 2rem; border-top: 1px solid #e2e8f0; margin-top: 2rem; display: flex; justify-content: space-between; align-items: center; max-width: 1400px; margin: 0 auto;">
    <div>© 2025 WorkBridge. All rights reserved.</div>
    <div class="flex gap-4">
        <a href="#" class="text-muted" style="text-decoration:none;">Privacy Policy</a>
        <a href="#" class="text-muted" style="text-decoration:none;">Terms of Service</a>
        <a href="#" class="text-muted" style="text-decoration:none;">Contact</a>
    </div>
</footer>

</body>
</html>
