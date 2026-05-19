package com.workbridge.util;

import com.workbridge.model.UserStatus;
import com.workbridge.service.NotificationService;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * AuthFilter — Global security filter for WorkBridge.
 *
 * <p>Intercepts all requests to protected URL patterns and enforces:
 * 1. Authentication (user must be logged in)
 * 2. Account status (user must be ACTIVE)
 * 3. Authorization (user role must match the URL namespace)</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
@WebFilter(urlPatterns = {"/admin/*", "/employer/*", "/jobseeker/*", "/notifications/*"})
public class AuthFilter implements Filter {

    private final NotificationService notificationService = new NotificationService();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // Step 1: Cast to HttpServletRequest/Response
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Step 2: Get session (false — do not create new)
        HttpSession session = req.getSession(false);

        // Step 3: If session null or no user → redirect login
        if (session == null || !SessionUtil.isLoggedIn(session)) {
            res.sendRedirect(req.getContextPath() + "/auth?action=login");
            return;
        }

        com.workbridge.model.User user = SessionUtil.getUser(session);

        // Step 4: If status PENDING → redirect with error=pending
        if (user.getStatus() == UserStatus.PENDING) {
            res.sendRedirect(req.getContextPath() + "/auth?action=login&error=pending");
            return;
        }

        // Step 5: If status SUSPENDED → redirect with error=suspended
        if (user.getStatus() == UserStatus.SUSPENDED) {
            res.sendRedirect(req.getContextPath() + "/auth?action=login&error=suspended");
            return;
        }

        // Step 6: URI role check (admin/employer/jobseeker prefix)
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        if (path.startsWith("/admin") && user.getRole() != com.workbridge.model.UserRole.ADMIN) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Admin role required.");
            return;
        } else if (path.startsWith("/employer") && user.getRole() != com.workbridge.model.UserRole.EMPLOYER) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Employer role required.");
            return;
        } else if (path.startsWith("/jobseeker") && user.getRole() != com.workbridge.model.UserRole.JOB_SEEKER) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Job Seeker role required.");
            return;
        }

        // Inject unread notification count
        req.setAttribute("unreadCount", notificationService.getUnreadCount(user.getId()));

        // Step 7: chain.doFilter()
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
