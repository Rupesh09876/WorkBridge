<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employer Dashboard | WorkBridge</title>
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
                <span>Your company profile is incomplete. Candidates won't be able to see your company details.</span>
            </div>
            <a href="${pageContext.request.contextPath}/employer?action=createProfile" class="btn-primary" style="background:#2563eb; color:white; text-decoration:none;">Complete Profile <i class="ph ph-arrow-right"></i></a>
        </div>
    </c:if>

    <div class="page-header mb-4" style="display:block;">
        <h1>Welcome back, ${sessionScope.loggedInUser.fullName != null ? sessionScope.loggedInUser.fullName : 'Rupesh Katuwal'}! <span style="display:inline-block; animation: wave 2s infinite; transform-origin: 70% 70%;">👋</span></h1>
        <p>Manage your job listings and applicants from here.</p>
    </div>

    <!-- Stats Grid -->
    <div class="stat-grid">
        <div class="s-card flex align-center gap-4">
            <div class="s-icon bg-blue-light" style="width:64px;height:64px;font-size:2rem;color:#2563eb;background:#eff6ff;"><i class="ph ph-briefcase"></i></div>
            <div>
                <div class="s-title">Total Jobs Posted</div>
                <div class="s-value">${jobs != null ? jobs.size() : '1'}</div>
                <div class="text-sm text-muted mt-1">Active jobs you have posted</div>
            </div>
        </div>
        <div class="s-card flex align-center gap-4">
            <div class="s-icon bg-green-light" style="width:64px;height:64px;font-size:2rem;color:#10b981;background:#ecfdf5;"><i class="ph ph-users"></i></div>
            <div>
                <div class="s-title">Total Applicants</div>
                <div class="s-value">0</div>
                <div class="text-sm text-muted mt-1">Across all your jobs</div>
            </div>
        </div>
        <div class="s-card flex align-center gap-4">
            <div class="s-icon bg-purple-light" style="width:64px;height:64px;font-size:2rem;color:#8b5cf6;background:#f5f3ff;"><i class="ph ph-eye"></i></div>
            <div>
                <div class="s-title">Profile Views</div>
                <div class="s-value">0</div>
                <div class="text-sm text-muted mt-1">Company profile views</div>
            </div>
        </div>
        <div class="s-card flex align-center gap-4">
            <div class="s-icon bg-orange-light" style="width:64px;height:64px;font-size:2rem;color:#f97316;background:#fff7ed;"><i class="ph ph-trend-up"></i></div>
            <div>
                <div class="s-title">Active Jobs</div>
                <div class="s-value">1</div>
                <div class="text-sm text-muted mt-1">Currently open positions</div>
            </div>
        </div>
    </div>

    <!-- Recent Jobs -->
    <div class="d-card" style="padding:0;">
        <div class="d-card-header" style="padding:1.5rem 1.5rem 0; margin-bottom:1rem; display:flex; justify-content:space-between; align-items:flex-start;">
            <div>
                <h3 class="d-card-title" style="font-size:1.4rem; margin-bottom:0.5rem;">Recent Jobs</h3>
                <p class="text-muted text-sm m-0">Overview of your recently posted job listings.</p>
            </div>
            <a href="${pageContext.request.contextPath}/employer?action=postJob" class="btn-primary" style="text-decoration:none;">Post New Job <i class="ph ph-plus"></i></a>
        </div>
        
        <table class="dash-table w-100" style="background:#f8fafc; border-top:1px solid #e2e8f0; border-bottom:1px solid #e2e8f0;">
            <thead>
                <tr>
                    <th style="padding:1rem 1.5rem;">Job Title</th>
                    <th style="padding:1rem 1.5rem;">Status</th>
                    <th style="padding:1rem 1.5rem;">Applicants</th>
                    <th style="padding:1rem 1.5rem;">Posted On</th>
                    <th style="padding:1rem 1.5rem;">Actions</th>
                </tr>
            </thead>
        </table>
        
        <div style="padding:1.5rem;">
            <c:choose>
                <c:when test="${empty jobs}">
                    <div class="d-job-card flex align-center justify-between" style="border:none; box-shadow:0 1px 3px rgba(0,0,0,0.05); background:#fff;">
                        <div class="flex align-center gap-3">
                            <div class="s-icon bg-blue-light" style="width:48px;height:48px;border-radius:8px;font-size:1.5rem;color:#2563eb;background:#eff6ff;"><i class="ph ph-briefcase"></i></div>
                            <div>
                                <h4 style="margin:0 0 0.25rem; font-size:1.05rem;">Frontend Developer (React.js)</h4>
                                <div class="text-sm text-muted flex align-center gap-1"><i class="ph ph-map-pin"></i> Full-time • Kathmandu, Nepal</div>
                            </div>
                        </div>
                        <div style="flex:1; display:flex; justify-content:space-around; align-items:center;">
                            <span class="status-badge status-open">OPEN</span>
                            <div>
                                <div class="font-bold">0</div>
                                <div class="text-xs text-muted">Applicants</div>
                            </div>
                            <div>
                                <div class="text-sm">May 18, 2025</div>
                                <div class="text-xs text-muted">10:24 AM</div>
                            </div>
                        </div>
                        <div class="flex gap-2">
                            <button class="btn-outline" style="padding:0.4rem 0.8rem; font-size:0.9rem;">View Applicants</button>
                            <button class="btn-outline" style="padding:0.4rem; font-size:1.2rem; display:flex; align-items:center;"><i class="ph ph-dots-three-vertical"></i></button>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="job" items="${jobs}" end="4">
                        <div class="d-job-card flex align-center justify-between" style="border:none; box-shadow:0 1px 3px rgba(0,0,0,0.05); background:#fff;">
                            <div class="flex align-center gap-3">
                                <div class="s-icon bg-blue-light" style="width:48px;height:48px;border-radius:8px;font-size:1.5rem;color:#2563eb;background:#eff6ff;"><i class="ph ph-briefcase"></i></div>
                                <div>
                                    <h4 style="margin:0 0 0.25rem; font-size:1.05rem;">${job.title}</h4>
                                    <div class="text-sm text-muted flex align-center gap-1"><i class="ph ph-map-pin"></i> ${job.jobType.displayName} • ${job.location}</div>
                                </div>
                            </div>
                            <div style="flex:1; display:flex; justify-content:space-around; align-items:center;">
                                <span class="status-badge status-${job.status.toLowerCase()}">${job.status}</span>
                                <div>
                                    <div class="font-bold">0</div>
                                    <div class="text-xs text-muted">Applicants</div>
                                </div>
                                <div>
                                    <div class="text-sm">Today</div>
                                    <div class="text-xs text-muted">Just now</div>
                                </div>
                            </div>
                            <div class="flex gap-2">
                                <a href="${pageContext.request.contextPath}/employer?action=applicants&jobId=${job.id}" class="btn-outline" style="padding:0.4rem 0.8rem; font-size:0.9rem; text-decoration:none; display:inline-block;">View Applicants</a>
                                <button class="btn-outline" style="padding:0.4rem; font-size:1.2rem; display:flex; align-items:center;"><i class="ph ph-dots-three-vertical"></i></button>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="text-center" style="padding-bottom:1.5rem;">
            <a href="${pageContext.request.contextPath}/employer?action=myJobs" class="view-all" style="font-weight:600;">View all jobs <i class="ph ph-arrow-right"></i></a>
        </div>
    </div>

    <!-- Tip card -->
    <div class="d-card flex align-center justify-between mt-4" style="background:#f8fafc;">
        <div class="flex align-center gap-3">
            <div class="s-icon bg-blue-light" style="width:48px;height:48px;border-radius:50%;font-size:1.5rem;color:#2563eb;background:#dbeafe;"><i class="ph ph-lightbulb"></i></div>
            <div>
                <h4 style="margin:0 0 0.25rem;">Tip: Get more visibility</h4>
                <p class="text-sm text-muted m-0">Complete your company profile and add details to attract more qualified candidates.</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/employer?action=createProfile" class="btn-outline" style="background:#fff; text-decoration:none;">Complete Profile</a>
    </div>

</div>

<footer class="text-center text-muted" style="padding: 2rem; border-top: 1px solid #e2e8f0; margin-top: 2rem; display: flex; justify-content: space-between; align-items: center; max-width: 1400px; margin: 0 auto;">
    <div>© 2025 WorkBridge. All rights reserved.</div>
    <div class="flex gap-4">
        <a href="#" class="text-muted" style="text-decoration:none;">Privacy Policy</a>
        <a href="#" class="text-muted" style="text-decoration:none;">Terms of Service</a>
        <a href="#" class="text-muted" style="text-decoration:none;">Contact Us</a>
    </div>
</footer>

<style>
@keyframes wave {
    0% { transform: rotate(0deg); }
    10% { transform: rotate(14deg); }
    20% { transform: rotate(-8deg); }
    30% { transform: rotate(14deg); }
    40% { transform: rotate(-4deg); }
    50% { transform: rotate(10deg); }
    60% { transform: rotate(0deg); }
    100% { transform: rotate(0deg); }
}
</style>
</body>
</html>
