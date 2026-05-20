<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | WorkBridge</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="dashboard-container">
    <div class="page-header">
        <div>
            <h1>Admin Dashboard</h1>
            <p>Welcome back! Here's what's happening with your job portal today.</p>
        </div>
        <div class="flex gap-2">
            <button class="btn-outline flex align-center gap-2"><i class="ph ph-calendar-blank"></i> May 18, 2025 - May 24, 2025 <i class="ph ph-caret-down"></i></button>
            <button class="btn-export"><i class="ph ph-download-simple"></i> Export Report</button>
        </div>
    </div>

    <!-- Stats Grid -->
    <div class="stat-grid">
        <div class="s-card">
            <div class="s-card-header">
                <div class="s-icon bg-blue-light"><i class="ph ph-users"></i></div>
            </div>
            <div class="s-title">Total Users</div>
            <div class="s-value">${stats.totalUsers != null ? stats.totalUsers : '5'}</div>
            <div class="s-trend trend-up"><i class="ph ph-caret-up"></i> 25% <span class="text-muted" style="font-weight:400; margin-left:5px;">vs last 7 days</span></div>
        </div>
        <div class="s-card">
            <div class="s-card-header">
                <div class="s-icon bg-orange-light"><i class="ph ph-clock"></i></div>
            </div>
            <div class="s-title">Pending Approvals</div>
            <div class="s-value">${stats.pendingUsers != null ? stats.pendingUsers : '0'}</div>
            <div class="s-trend trend-flat"><i class="ph ph-minus"></i> 0% <span class="text-muted" style="font-weight:400; margin-left:5px;">vs last 7 days</span></div>
        </div>
        <div class="s-card">
            <div class="s-card-header">
                <div class="s-icon bg-green-light"><i class="ph ph-briefcase"></i></div>
            </div>
            <div class="s-title">Open Jobs</div>
            <div class="s-value">${stats.openJobs != null ? stats.openJobs : '1'}</div>
            <div class="s-trend trend-up"><i class="ph ph-caret-up"></i> 100% <span class="text-muted" style="font-weight:400; margin-left:5px;">vs last 7 days</span></div>
        </div>
        <div class="s-card">
            <div class="s-card-header">
                <div class="s-icon bg-purple-light"><i class="ph ph-file-text"></i></div>
            </div>
            <div class="s-title">Total Applications</div>
            <div class="s-value">${stats.totalApplications != null ? stats.totalApplications : '1'}</div>
            <div class="s-trend trend-up"><i class="ph ph-caret-up"></i> 100% <span class="text-muted" style="font-weight:400; margin-left:5px;">vs last 7 days</span></div>
        </div>
    </div>

    <div class="dash-grid-2">
        <!-- Overview Chart (Mockup representation) -->
        <div class="d-card">
            <div class="d-card-header">
                <h3 class="d-card-title">Overview (Last 7 Days)</h3>
                <button class="btn-outline" style="padding: 0.3rem 0.8rem;">Line Chart <i class="ph ph-caret-down"></i></button>
            </div>
            <div style="height: 250px; background: url('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Line_chart_example.svg/800px-Line_chart_example.svg.png') no-repeat center center; background-size: contain; opacity: 0.5; filter: grayscale(1);">
            </div>
            <div class="flex justify-center gap-4 mt-3 text-sm">
                <span class="flex align-center gap-1"><span style="width:12px;height:4px;background:#2563eb;"></span> Users</span>
                <span class="flex align-center gap-1"><span style="width:12px;height:4px;background:#10b981;"></span> Jobs</span>
                <span class="flex align-center gap-1"><span style="width:12px;height:4px;background:#8b5cf6;"></span> Applications</span>
            </div>
        </div>

        <!-- Job Status (Donut representation) -->
        <div class="d-card">
            <div class="d-card-header">
                <h3 class="d-card-title">Job Status</h3>
            </div>
            <div class="flex align-center gap-4 justify-center" style="height: 250px;">
                <div style="width: 150px; height: 150px; border-radius: 50%; border: 20px solid #10b981; display: flex; align-items: center; justify-content: center; flex-direction: column;">
                    <strong style="font-size: 1.5rem;">1</strong>
                    <span class="text-muted text-sm">Total</span>
                </div>
                <div class="flex flex-col gap-2 text-sm">
                    <div class="flex align-center gap-2"><span style="width:8px;height:8px;border-radius:50%;background:#10b981;"></span> Open (100%)</div>
                    <div class="flex align-center gap-2"><span style="width:8px;height:8px;border-radius:50%;background:#f59e0b;"></span> Closed (0%)</div>
                    <div class="flex align-center gap-2"><span style="width:8px;height:8px;border-radius:50%;background:#94a3b8;"></span> Draft (0%)</div>
                    <div class="flex align-center gap-2"><span style="width:8px;height:8px;border-radius:50%;background:#ef4444;"></span> Expired (0%)</div>
                </div>
            </div>
        </div>
    </div>

    <div class="dash-grid-2">
        <div class="flex flex-col gap-4">
            <!-- Pending User Approvals -->
            <div class="d-card">
                <div class="d-card-header">
                    <h3 class="d-card-title">Pending User Approvals</h3>
                    <a href="${pageContext.request.contextPath}/admin?action=users" class="view-all">View All</a>
                </div>
                
                <c:choose>
                    <c:when test="${empty pendingUsers}">
                        <div class="empty-state">
                            <i class="ph ph-envelope-open empty-icon"></i>
                            <p>No users are currently pending approval.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="dash-table">
                            <thead>
                                <tr>
                                    <th>User</th>
                                    <th>Role</th>
                                    <th>Registered On</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${pendingUsers}">
                                    <tr>
                                        <td>
                                            <div class="font-bold">${user.fullName}</div>
                                            <div class="text-sm text-muted">${user.email}</div>
                                        </td>
                                        <td>${user.role}</td>
                                        <td>${user.createdAt}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin" method="post">
                                                <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                                <input type="hidden" name="action" value="approve">
                                                <input type="hidden" name="id" value="${user.id}">
                                                <button type="submit" class="btn-primary" style="padding:0.4rem 0.8rem; font-size:0.85rem;">Approve</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Latest Applications -->
            <div class="d-card">
                <div class="d-card-header">
                    <h3 class="d-card-title">Latest Applications</h3>
                    <a href="${pageContext.request.contextPath}/admin?action=applications" class="view-all">View All</a>
                </div>
                <table class="dash-table mb-3">
                    <thead>
                        <tr>
                            <th>Applicant</th>
                            <th>Job</th>
                            <th>Applied On</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div class="flex align-center gap-2">
                                    <div class="user-avatar bg-blue-light" style="width:30px;height:30px;font-size:0.7rem;">JD</div>
                                    <div>
                                        <div class="font-bold text-sm">John Doe</div>
                                        <div class="text-xs text-muted" style="font-size:0.75rem;">johndoe@email.com</div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="font-bold text-sm">Software Developer</div>
                                <div class="text-xs text-muted" style="font-size:0.75rem;">Tech Solutions</div>
                            </td>
                            <td class="text-sm">May 24, 2025<br><span class="text-muted">10:24 AM</span></td>
                            <td><span class="status-badge status-pending">Pending</span></td>
                        </tr>
                    </tbody>
                </table>
                <a href="${pageContext.request.contextPath}/admin?action=applications" class="view-all flex align-center gap-1">See all applications <i class="ph ph-arrow-right"></i></a>
            </div>
        </div>

        <div class="flex flex-col gap-4">
            <!-- Recent Activity -->
            <div class="d-card">
                <div class="d-card-header">
                    <h3 class="d-card-title">Recent Activity</h3>
                    <a href="#" class="view-all">View All</a>
                </div>
                <div class="activity-list">
                    <div class="activity-item">
                        <div class="a-icon bg-green-light"><i class="ph ph-user-plus text-green"></i></div>
                        <div class="a-details">
                            <div class="a-title">New user registered</div>
                            <div class="a-desc">test employer (employer)</div>
                        </div>
                        <div class="a-time">2 hours ago</div>
                    </div>
                    <div class="activity-item">
                        <div class="a-icon bg-blue-light"><i class="ph ph-briefcase text-blue"></i></div>
                        <div class="a-details">
                            <div class="a-title">Job posted</div>
                            <div class="a-desc">Software Developer at Tech Solutions</div>
                        </div>
                        <div class="a-time">3 hours ago</div>
                    </div>
                    <div class="activity-item">
                        <div class="a-icon bg-purple-light"><i class="ph ph-file-text text-purple"></i></div>
                        <div class="a-details">
                            <div class="a-title">Application received</div>
                            <div class="a-desc">John Doe applied for Software Developer</div>
                        </div>
                        <div class="a-time">3 hours ago</div>
                    </div>
                    <div class="activity-item">
                        <div class="a-icon bg-orange-light"><i class="ph ph-user-check text-orange" style="color:#f97316;"></i></div>
                        <div class="a-details">
                            <div class="a-title">User approved</div>
                            <div class="a-desc">test employer (employer)</div>
                        </div>
                        <div class="a-time">1 day ago</div>
                    </div>
                    <div class="activity-item">
                        <div class="a-icon bg-blue-light"><i class="ph ph-gear text-blue"></i></div>
                        <div class="a-details">
                            <div class="a-title">System backup completed</div>
                            <div class="a-desc">Auto backup</div>
                        </div>
                        <div class="a-time">2 days ago</div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="d-card">
                <div class="d-card-header">
                    <h3 class="d-card-title">Quick Actions</h3>
                </div>
                <div class="action-grid">
                    <a href="${pageContext.request.contextPath}/admin?action=jobs" class="action-btn" style="text-decoration:none; display:flex; align-items:center; justify-content:center;"><i class="ph ph-briefcase"></i> Manage Jobs</a>
                    <a href="${pageContext.request.contextPath}/admin?action=categories" class="action-btn" style="text-decoration:none; display:flex; align-items:center; justify-content:center;"><i class="ph ph-tag"></i> Manage Categories</a>
                    <a href="${pageContext.request.contextPath}/admin?action=users" class="action-btn" style="text-decoration:none; display:flex; align-items:center; justify-content:center;"><i class="ph ph-users"></i> View All Users</a>
                    <button class="action-btn"><i class="ph ph-chart-bar"></i> Generate Report</button>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="text-center text-muted" style="padding: 2rem; border-top: 1px solid #e2e8f0; margin-top: 2rem; display: flex; justify-content: space-between; align-items: center; max-width: 1400px; margin: 0 auto;">
    <div>© 2025 WorkBridge. All rights reserved.</div>
    <div class="flex gap-4">
        <a href="#" class="text-muted" style="text-decoration:none;">About</a>
        <a href="#" class="text-muted" style="text-decoration:none;">Privacy Policy</a>
        <a href="#" class="text-muted" style="text-decoration:none;">Terms of Service</a>
        <a href="#" class="text-muted" style="text-decoration:none;">Contact</a>
    </div>
</footer>

</body>
</html>
