<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="My Notifications | WorkBridge" scope="request" />
<c:set var="extraCss" value="dashboard.css" scope="request" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="dashboard-container">
    <div class="page-header">
        <div>
            <h1><i class="ph ph-bell" style="color: #2563eb;"></i> Notifications</h1>
            <p>Stay updated with your latest activities and system alerts.</p>
        </div>
        <c:if test="${not empty notifications}">
            <div style="display: flex; gap: 0.75rem;">
                <a href="${pageContext.request.contextPath}/notifications?action=markRead" class="btn-outline" style="display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.6rem 1.2rem; border-radius: 8px; text-decoration: none; font-size: 0.9rem;">
                    <i class="ph ph-checks"></i> Mark all as read
                </a>
                <a href="${pageContext.request.contextPath}/notifications?action=deleteAll" class="btn-outline" style="display: inline-flex; align-items: center; gap: 0.5rem; padding: 0.6rem 1.2rem; border-radius: 8px; text-decoration: none; font-size: 0.9rem; color: #ef4444; border-color: #fecaca;"
                   onclick="return confirm('Are you sure you want to delete all notifications?');">
                    <i class="ph ph-trash"></i> Delete All
                </a>
            </div>
        </c:if>
    </div>

    <div class="d-card">
        <div class="activity-list" style="padding: 1rem;">
            <c:forEach var="n" items="${notifications}">
                <div class="activity-item" style="display: flex; align-items: center; padding: 1rem; border-radius: 10px; margin-bottom: 0.5rem; transition: all 0.2s; ${n.read ? 'background: #ffffff; border-left: 3px solid transparent;' : 'background: #f0f9ff; border-left: 3px solid #3b82f6;'}">
                    <div style="width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; flex-shrink: 0; ${n.read ? 'background: #f1f5f9;' : 'background: #dbeafe;'}">
                        <i class="ph ph-bell" style="font-size: 1.1rem; ${n.read ? 'color: #94a3b8;' : 'color: #3b82f6;'}"></i>
                    </div>
                    <div style="flex: 1; margin-left: 1rem;">
                        <div style="font-size: 0.95rem; color: #1e293b; ${n.read ? '' : 'font-weight: 600;'}">${n.message}</div>
                        <div style="font-size: 0.8rem; color: #94a3b8; margin-top: 3px;">
                            <fmt:parseDate value="${n.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                            <i class="ph ph-clock" style="font-size: 0.75rem;"></i>
                            <fmt:formatDate pattern="MMM dd, yyyy 'at' hh:mm a" value="${parsedDate}" />
                        </div>
                    </div>
                    <c:if test="${!n.read}">
                        <div style="width: 8px; height: 8px; background: #3b82f6; border-radius: 50%; margin-right: 0.75rem; flex-shrink: 0;"></div>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/notifications?action=delete&id=${n.id}" title="Delete notification"
                       style="background: none; border: 1px solid transparent; cursor: pointer; padding: 0.5rem; border-radius: 8px; transition: all 0.2s; display: flex; align-items: center; justify-content: center; color: #94a3b8; text-decoration: none;"
                       onmouseover="this.style.background='#fef2f2'; this.style.color='#ef4444'; this.style.borderColor='#fecaca';"
                       onmouseout="this.style.background='none'; this.style.color='#94a3b8'; this.style.borderColor='transparent';">
                        <i class="ph ph-trash" style="font-size: 1.1rem;"></i>
                    </a>
                </div>
            </c:forEach>
            
            <c:if test="${empty notifications}">
                <div class="empty-state" style="padding: 3rem 1rem;">
                    <i class="ph ph-bell-slash" style="font-size: 3.5rem; color: #cbd5e1; display: block; margin-bottom: 1rem;"></i>
                    <p style="font-size: 1.1rem; color: #64748b; font-weight: 500;">No notifications yet.</p>
                    <p style="font-size: 0.85rem; color: #94a3b8; margin-top: 0.25rem;">When you perform actions in the system, notifications will appear here.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
