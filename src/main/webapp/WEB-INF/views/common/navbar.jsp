<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

            <%-- Map role to correct servlet URL path --%>
                <c:choose>
                    <c:when test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                        <c:set var="roleUrl" value="admin" />
                    </c:when>
                    <c:when test="${sessionScope.loggedInUser.role == 'EMPLOYER'}">
                        <c:set var="roleUrl" value="employer" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="roleUrl" value="jobseeker" />
                    </c:otherwise>
                </c:choose>

                <nav class="dash-nav">
                    <input type="checkbox" id="dash-nav-toggle" class="dash-nav-toggle" style="display: none;">
                    <div class="d-brand">
                        <a href="${pageContext.request.contextPath}/">
                            <img src="${pageContext.request.contextPath}/images/logo.jpg" alt="WorkBridge"
                                onerror="this.src='https://via.placeholder.com/200x70?text=WorkBridge'">
                        </a>
                    </div>

                    <div class="d-links">
                        <c:set var="currentAction" value="${param.action != null ? param.action : 'dashboard'}" />
                        <c:choose>
                            <c:when test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                                <a href="${pageContext.request.contextPath}/admin"
                                    class="d-link ${currentAction == 'dashboard' ? 'active' : ''}"><i
                                        class="ph ph-squares-four"></i> Dashboard</a>
                                <a href="${pageContext.request.contextPath}/admin?action=users"
                                    class="d-link ${currentAction == 'users' ? 'active' : ''}"><i
                                        class="ph ph-users"></i> Users</a>
                                <a href="${pageContext.request.contextPath}/admin?action=jobs"
                                    class="d-link ${currentAction == 'jobs' ? 'active' : ''}"><i
                                        class="ph ph-briefcase"></i> Jobs</a>
                                <a href="${pageContext.request.contextPath}/admin?action=applications"
                                    class="d-link ${currentAction == 'applications' ? 'active' : ''}"><i
                                        class="ph ph-file-text"></i> Applications</a>
                                <a href="${pageContext.request.contextPath}/admin?action=settings"
                                    class="d-link ${currentAction == 'settings' ? 'active' : ''}"><i
                                        class="ph ph-gear"></i> Settings</a>
                            </c:when>
                            <c:when test="${sessionScope.loggedInUser.role == 'EMPLOYER'}">
                                <a href="${pageContext.request.contextPath}/employer"
                                    class="d-link ${currentAction == 'dashboard' ? 'active' : ''}"><i
                                        class="ph ph-house"></i> Dashboard</a>
                                <a href="${pageContext.request.contextPath}/employer?action=postJob"
                                    class="d-link ${currentAction == 'postJob' ? 'active' : ''}"><i
                                        class="ph ph-plus-square"></i> Post Job</a>
                                <a href="${pageContext.request.contextPath}/employer?action=myJobs"
                                    class="d-link ${currentAction == 'myJobs' ? 'active' : ''}"><i
                                        class="ph ph-briefcase"></i> My Jobs</a>
                                <a href="${pageContext.request.contextPath}/employer?action=createProfile"
                                    class="d-link ${currentAction == 'createProfile' || currentAction == 'editProfile' ? 'active' : ''}"><i
                                        class="ph ph-buildings"></i> Company Profile</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/jobseeker"
                                    class="d-link ${currentAction == 'dashboard' ? 'active' : ''}"><i
                                        class="ph ph-house"></i> Dashboard</a>
                                <a href="${pageContext.request.contextPath}/jobseeker?action=search"
                                    class="d-link ${currentAction == 'search' ? 'active' : ''}"><i
                                        class="ph ph-magnifying-glass"></i> Search Jobs</a>
                                <a href="${pageContext.request.contextPath}/jobseeker?action=myApplications"
                                    class="d-link ${currentAction == 'myApplications' ? 'active' : ''}"><i
                                        class="ph ph-file-text"></i> My Applications</a>
                                <a href="${pageContext.request.contextPath}/jobseeker?action=savedJobs"
                                    class="d-link ${currentAction == 'savedJobs' ? 'active' : ''}"><i
                                        class="ph ph-bookmark-simple"></i> Saved Jobs</a>
                                <a href="${pageContext.request.contextPath}/jobseeker?action=createProfile"
                                    class="d-link ${currentAction == 'createProfile' || currentAction == 'editProfile' ? 'active' : ''}"><i
                                        class="ph ph-user"></i> My Profile</a>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div style="display: flex; align-items: center; gap: 1.5rem;">
                        <%-- Notification Bell with Popup --%>
                            <div class="notification-wrapper" id="notifTrigger"
                                style="position: relative; cursor: pointer; padding: 0.5rem;">
                                <i class="ph ph-bell" style="font-size: 1.4rem;"></i>
                                <c:if test="${not empty unreadCount && unreadCount > 0}">
                                    <span id="notifBadge"
                                        style="position: absolute; top: 0; right: 0; background: #ef4444; color: white; font-size: 0.65rem; padding: 2px 5px; border-radius: 10px; border: 2px solid white;">
                                        ${unreadCount > 9 ? '9+' : unreadCount}
                                    </span>
                                </c:if>

                                <div class="dropdown-menu notif-dropdown" id="notifDropdown"
                                    style="width: 360px; right: 0; top: 100%; padding: 0;">
                                    <div
                                        style="padding: 1rem 1.2rem; border-bottom: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center;">
                                        <span
                                            style="font-weight: 700; font-size: 1rem; color: #1e293b;">Notifications</span>
                                        <a href="#" id="markAllReadBtn" onclick="markAllAsRead(event)"
                                            style="font-size: 0.75rem; color: #2563eb; text-decoration: none; font-weight: 500; cursor: pointer;">Mark
                                            all as read</a>
                                    </div>
                                    <div id="notifContent"
                                        style="max-height: 400px; overflow-y: auto; padding: 0.5rem;">
                                        <div style="padding: 2rem; text-align: center; color: #64748b;">
                                            <i class="ph ph-circle-notch ph-spin" style="font-size: 1.5rem;"></i>
                                        </div>
                                    </div>
                                    <div style="padding: 0.8rem; border-top: 1px solid #e2e8f0; text-align: center;">
                                        <a href="${pageContext.request.contextPath}/notifications"
                                            style="font-size: 0.85rem; font-weight: 600; color: #2563eb; text-decoration: none;">View
                                            All Notifications</a>
                                    </div>
                                </div>
                            </div>

                                <div class="d-user" id="userDropdownTrigger"
                                    style="display: flex; align-items: center; gap: 0.8rem; padding: 0.4rem 0.8rem; border-radius: 10px; transition: all 0.2s; cursor: pointer;">
                                    <div class="user-info" style="text-align: right; line-height: 1.1;">
                                        <div class="user-name"
                                            style="font-weight: 700; font-size: 0.95rem; color: #1e293b;">Hi, ${not
                                            empty sessionScope.loggedInUser.fullName ?
                                            sessionScope.loggedInUser.fullName : 'User'}</div>
                                        <div class="user-role"
                                            style="text-transform: uppercase; font-size: 0.65rem; color: #94a3b8; font-weight: 700; margin-top: 2px; letter-spacing: 0.02em;">
                                            ${fn:replace(sessionScope.loggedInUser.role, '_', ' ')}</div>
                                    </div>
                                    <div class="user-avatar"
                                        style="width: 36px; height: 36px; background: #2563eb; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.85rem; box-shadow: 0 2px 4px rgba(37, 99, 235, 0.2);">
                                        ${not empty sessionScope.loggedInUser.fullName ?
                                        sessionScope.loggedInUser.fullName.substring(0,2).toUpperCase() : 'U'}
                                    </div>
                                    <i class="ph ph-caret-down" style="color: #cbd5e1; font-size: 0.8rem;"></i>

                                    <div class="dropdown-menu" id="userDropdown">
                                        <a href="${pageContext.request.contextPath}/${roleUrl}?action=createProfile"
                                            class="dropdown-item">
                                            <i class="ph ph-user-circle"></i> View Profile
                                        </a>
                                        <form action="${pageContext.request.contextPath}/auth" method="post"
                                            id="logoutFormNavbar" style="margin:0;">
                                            <%@ include file="/WEB-INF/views/common/csrf_token.jspf" %>
                                                <input type="hidden" name="action" value="logout">
                                                <a href="#"
                                                    onclick="document.getElementById('logoutFormNavbar').submit();"
                                                    class="dropdown-item logout">
                                                    <i class="ph ph-sign-out"></i> Logout
                                                </a>
                                        </form>
                                    </div>
                                </div>
                                
                                <label for="dash-nav-toggle" class="dash-nav-toggle-label">
                                    <span></span>
                                </label>
                    </div>
                </nav>

                <script>
                    // User Dropdown Toggle
                    (function () {
                        var trigger = document.getElementById('userDropdownTrigger');
                        if (trigger && !trigger.hasAttribute('data-listener')) {
                            trigger.setAttribute('data-listener', 'true');
                            trigger.addEventListener('click', function (e) {
                                e.stopPropagation();
                                document.getElementById('userDropdown').classList.toggle('show');
                                document.getElementById('notifDropdown').classList.remove('show');
                            });
                        }
                    })();

                    // Notification Dropdown Toggle
                    (function () {
                        var notifTrigger = document.getElementById('notifTrigger');
                        var notifDropdown = document.getElementById('notifDropdown');

                        if (notifTrigger) {
                            notifTrigger.addEventListener('click', function (e) {
                                e.stopPropagation();
                                var isOpening = !notifDropdown.classList.contains('show');
                                notifDropdown.classList.toggle('show');
                                document.getElementById('userDropdown').classList.remove('show');
                                if (isOpening) {
                                    fetchNotifications();
                                }
                            });
                        }
                    })();

                    // Build a single notification item HTML
                    function renderNotifItem(n) {
                        var time = new Date(n.createdAt).toLocaleString([], { month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' });
                        var borderStyle = n.read ? 'border-left: 3px solid transparent;' : 'border-left: 3px solid #3b82f6;';
                        var bgStyle = n.read ? 'background: #ffffff;' : 'background: #f0f9ff;';
                        var iconColor = n.read ? '#94a3b8' : '#3b82f6';
                        var iconBg = n.read ? '#f1f5f9' : '#dbeafe';
                        var fontWeight = n.read ? 'font-weight: 400;' : 'font-weight: 600;';

                        return '<div class="notif-item" style="padding: 0.75rem 1rem; border-radius: 8px; margin-bottom: 0.3rem; display: flex; gap: 0.8rem; align-items: flex-start; transition: all 0.3s ease; ' + borderStyle + ' ' + bgStyle + '">'
                            + '<div style="width: 30px; height: 30px; border-radius: 50%; background: ' + iconBg + '; display: flex; align-items: center; justify-content: center; flex-shrink: 0;">'
                            + '<i class="ph ph-bell" style="color: ' + iconColor + '; font-size: 0.9rem;"></i>'
                            + '</div>'
                            + '<div style="flex: 1; min-width: 0;">'
                            + '<div style="font-size: 0.84rem; color: #1e293b; line-height: 1.4; ' + fontWeight + '">' + n.message + '</div>'
                            + '<div style="font-size: 0.7rem; color: #94a3b8; margin-top: 3px;">' + time + '</div>'
                            + '</div>'
                            + '</div>';
                    }

                    // Fetch notifications from the API
                    function fetchNotifications() {
                        var content = document.getElementById('notifContent');
                        content.innerHTML = '<div style="padding: 2rem; text-align: center; color: #64748b;"><i class="ph ph-circle-notch ph-spin" style="font-size: 1.5rem;"></i></div>';

                        fetch('${pageContext.request.contextPath}/notifications?action=api_list')
                            .then(function (resp) { return resp.json(); })
                            .then(function (data) {
                                if (!data || data.length === 0) {
                                    content.innerHTML = '<div style="padding: 2.5rem 1rem; text-align: center; color: #94a3b8;">'
                                        + '<i class="ph ph-bell-slash" style="font-size: 2rem; display: block; margin-bottom: 0.5rem;"></i>'
                                        + 'No notifications yet</div>';
                                    return;
                                }
                                var html = '';
                                for (var i = 0; i < data.length; i++) {
                                    html += renderNotifItem(data[i]);
                                }
                                content.innerHTML = html;
                            })
                            .catch(function (err) {
                                console.error('Notification fetch error:', err);
                                content.innerHTML = '<div style="padding: 1.5rem; text-align: center; color: #ef4444;">'
                                    + '<i class="ph ph-warning" style="font-size: 1.2rem;"></i> Failed to load notifications</div>';
                            });
                    }

                    // Mark all notifications as read (AJAX, no page redirect)
                    function markAllAsRead(e) {
                        e.preventDefault();
                        e.stopPropagation();

                        fetch('${pageContext.request.contextPath}/notifications?action=api_markRead')
                            .then(function (resp) { return resp.json(); })
                            .then(function (result) {
                                // Remove blue borders and highlights from all notification items
                                var items = document.querySelectorAll('#notifContent .notif-item');
                                for (var i = 0; i < items.length; i++) {
                                    items[i].style.borderLeft = '3px solid transparent';
                                    items[i].style.background = '#ffffff';
                                    // Update icon background
                                    var iconWrap = items[i].querySelector('div:first-child');
                                    if (iconWrap) iconWrap.style.background = '#f1f5f9';
                                    // Update icon color
                                    var icon = items[i].querySelector('.ph-bell');
                                    if (icon) icon.style.color = '#94a3b8';
                                    // Update text weight
                                    var msgDiv = items[i].querySelector('div:nth-child(2) > div:first-child');
                                    if (msgDiv) msgDiv.style.fontWeight = '400';
                                }
                                // Hide the red badge counter
                                var badge = document.getElementById('notifBadge');
                                if (badge) badge.style.display = 'none';
                            })
                            .catch(function (err) {
                                console.error('Mark read error:', err);
                            });
                    }

                    // Close all dropdowns when clicking outside
                    window.addEventListener('click', function () {
                        var uDropdown = document.getElementById('userDropdown');
                        var nDropdown = document.getElementById('notifDropdown');
                        if (uDropdown && uDropdown.classList.contains('show')) uDropdown.classList.remove('show');
                        if (nDropdown && nDropdown.classList.contains('show')) nDropdown.classList.remove('show');
                    });
                </script>