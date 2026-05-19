package com.workbridge.util;

import com.workbridge.model.User;
import com.workbridge.model.UserRole;
import com.workbridge.model.UserStatus;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.UUID;

/**
 * SessionUtil — Manages HTTP session lifecycle for WorkBridge.
 *
 * <p>Handles user binding, role checks, CSRF token management,
 * and access control redirects.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class SessionUtil {

    private static final String USER_KEY = "loggedInUser";
    private static final String CSRF_KEY = "csrfToken";

    /**
     * Binds the authenticated user to the session.
     *
     * @param session the HTTP session
     * @param user    the authenticated user
     */
    public static void setUser(HttpSession session, User user) {
        session.setAttribute(USER_KEY, user);
    }

    /**
     * Retrieves the logged-in user from the session.
     *
     * @param session the HTTP session
     * @return the logged-in user, or null if none
     */
    public static User getUser(HttpSession session) {
        if (session == null) return null;
        return (User) session.getAttribute(USER_KEY);
    }

    /**
     * Checks if a user is currently logged in.
     *
     * @param session the HTTP session
     * @return true if a user is logged in, false otherwise
     */
    public static boolean isLoggedIn(HttpSession session) {
        return getUser(session) != null;
    }

    /**
     * Checks if the logged-in user has the specified role.
     *
     * @param session the HTTP session
     * @param role    the role to check
     * @return true if the user has the role, false otherwise
     */
    public static boolean hasRole(HttpSession session, UserRole role) {
        User user = getUser(session);
        return user != null && user.getRole() == role;
    }

    /**
     * Checks if the logged-in user has an ACTIVE status.
     *
     * @param session the HTTP session
     * @return true if active, false otherwise
     */
    public static boolean isActive(HttpSession session) {
        User user = getUser(session);
        return user != null && user.getStatus() == UserStatus.ACTIVE;
    }

    /**
     * Enforces login requirement, redirecting to the login page if not logged in.
     *
     * @param session  the HTTP session
     * @param response the HTTP response
     * @return true if the user is logged in, false otherwise (and redirects)
     * @throws IOException if redirect fails
     */
    public static boolean requireLogin(HttpSession session, HttpServletResponse response) throws IOException {
        if (!isLoggedIn(session)) {
            response.sendRedirect(response.encodeRedirectURL("/auth?action=login"));
            return false;
        }
        return true;
    }

    /**
     * Enforces a role requirement, redirecting to an error page if not authorized.
     *
     * @param session  the HTTP session
     * @param response the HTTP response
     * @param request  the HTTP request
     * @param role     the required role
     * @return true if the user has the role, false otherwise
     * @throws IOException if redirect fails
     */
    public static boolean requireRole(HttpSession session, HttpServletResponse response, HttpServletRequest request, UserRole role) throws IOException {
        if (!requireLogin(session, response)) {
            return false;
        }
        if (!hasRole(session, role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to access this resource.");
            return false;
        }
        return true;
    }

    /**
     * Generates and stores a CSRF token in the session if not already present.
     *
     * @param session the HTTP session
     * @return the generated or existing CSRF token
     */
    public static String generateCsrfToken(HttpSession session) {
        String token = (String) session.getAttribute(CSRF_KEY);
        if (token == null) {
            token = UUID.randomUUID().toString();
            session.setAttribute(CSRF_KEY, token);
        }
        return token;
    }

    /**
     * Validates a CSRF token submitted in the request against the session token.
     *
     * @param session the HTTP session
     * @param request the HTTP request containing the "_csrf" parameter
     * @return true if valid, false otherwise
     */
    public static boolean validateCsrfToken(HttpSession session, HttpServletRequest request) {
        String sessionToken = (String) session.getAttribute(CSRF_KEY);
        String requestToken = request.getParameter("_csrf");
        return sessionToken != null && sessionToken.equals(requestToken);
    }

    /**
     * Invalidates the HTTP session, logging the user out.
     *
     * @param session the HTTP session
     */
    public static void invalidate(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
    }
}
