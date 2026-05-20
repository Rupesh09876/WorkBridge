<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="System Settings | Admin" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="dashboard-container">
    <div class="page-header">
        <div>
            <h1>System Settings</h1>
            <p>Manage application preferences, security, and global configurations.</p>
        </div>
    </div>

    <div class="dash-grid-settings">
        <!-- Settings Sidebar -->
        <div class="d-card" style="padding: 1rem 0;">
            <div style="display: flex; flex-direction: column;">
                <a href="#" class="dropdown-item active" style="padding: 0.75rem 1.5rem; background: var(--blue-50, #eff6ff); color: var(--blue-600, #2563eb); border-left: 3px solid var(--blue-600, #2563eb);">
                    <i class="ph ph-user-gear"></i> Account Settings
                </a>
                <a href="#" class="dropdown-item" style="padding: 0.75rem 1.5rem;">
                    <i class="ph ph-shield-check"></i> Security
                </a>
                <a href="#" class="dropdown-item" style="padding: 0.75rem 1.5rem;">
                    <i class="ph ph-bell"></i> Notifications
                </a>
                <a href="#" class="dropdown-item" style="padding: 0.75rem 1.5rem;">
                    <i class="ph ph-database"></i> Backup & Data
                </a>
            </div>
        </div>

        <!-- Settings Content -->
        <div class="flex flex-col gap-4">
            <div class="d-card">
                <div class="d-card-header">
                    <h3 class="d-card-title">Profile Information</h3>
                </div>
                <div style="padding: 1.5rem;">
                    <form action="${pageContext.request.contextPath}/admin" method="post" class="flex flex-col gap-4">
                        <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                        <input type="hidden" name="action" value="updateProfile">
                        
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="fullName" class="form-control" value="${sessionScope.loggedInUser.fullName}" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Email Address</label>
                            <input type="email" name="email" class="form-control" value="${sessionScope.loggedInUser.email}" readonly>
                            <small class="text-muted">Email cannot be changed by the user.</small>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <input type="text" name="phone" class="form-control" value="${sessionScope.loggedInUser.phone}">
                        </div>

                        <div class="flex justify-end mt-2">
                            <button type="submit" class="btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="d-card">
                <div class="d-card-header" style="border-bottom-color: #fee2e2;">
                    <h3 class="d-card-title" style="color: #dc2626;">Danger Zone</h3>
                </div>
                <div style="padding: 1.5rem;">
                    <div class="flex justify-between align-center">
                        <div>
                            <div class="font-bold">System Maintenance</div>
                            <div class="text-sm text-muted">Put the system into maintenance mode. Users will not be able to log in.</div>
                        </div>
                        <button class="btn-outline" style="color: #dc2626; border-color: #fca5a5;">Enable Maintenance</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
